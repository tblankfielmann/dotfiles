#!/usr/bin/env python3

import os
import sys
import time
import json
import urllib
import argparse
import platform
import requests
import subprocess
import webbrowser
import configparser

from hashlib import sha1
from botocore import credentials
from datetime import datetime, timezone


if sys.version_info[0] < 3:
    def quote_plus(s):
        return urllib.quote_plus(s)
else:
    def quote_plus(s):
        return urllib.parse.quote_plus(s)


def get_arguments():
    """ Check and extract arguments provided. """
    parser = argparse.ArgumentParser(allow_abbrev=False)
    subparsers = parser.add_subparsers()

    console_p = subparsers.add_parser(
        name='console',
        help='Opens the default browser and logs into the AWS Web Console.',
    )
    console_p.add_argument('--profile', action='store', required=True)
    console_p.add_argument('--force-logout', action='store_true')
    console_p.add_argument('--logout-wait', type=int, action='store')
    console_p.set_defaults(command=console)

    export_p = subparsers.add_parser(
        name='export',
        help='Prints copy and paste ready credentials to export to your current shell.',
    )
    export_p.add_argument('--profile', action='store', required=True)
    export_p.set_defaults(command=export)

    import_p = subparsers.add_parser(
        name='import',
        help='Fetches new credentials and writes them to the local credentials file.',
    )
    import_p.add_argument('--profile', action='store', required=True)
    import_p.set_defaults(command=import_creds)

    process_p = subparsers.add_parser(
        name='process',
        help='Fetches "credential_process" compatible json.',
    )
    process_p.add_argument('--profile', action='store', required=True)
    process_p.set_defaults(command=process)

    return parser.parse_args()


def assert_profile_attribute(profile, attribute):
    """ Assert attribute in the AWS config profile. """

    if attribute not in profile:
        sys.exit("Value for '%s' not in '%s' profile" % (attribute, profile))


def retrieve_profile(profile_name):
    """ Read the AWS Config profile matching the specified profile name. """

    config_path = os.path.expanduser(os.path.join('~', '.aws', 'config'))
    config = configparser.ConfigParser()
    config.read(config_path)

    # Look for the required profile
    if "profile %s" % profile_name not in config:
        sys.exit("Cannot find profile '%s' in %s" %
                 (profile_name, config_path))

    profile = config["profile %s" % profile_name]

    # Check the values
    assert_profile_attribute(profile, "sso_start_url")
    assert_profile_attribute(profile, "sso_account_id")
    assert_profile_attribute(profile, "sso_role_name")
    assert_profile_attribute(profile, "sso_region")
    return profile


def update_cached_role_credentials(profile_name, silent):
    """ Update role credentials for profile in cli cache. """

    # Calling get-caller-identity from the cli
    # updates the credential cache
    result = subprocess.run(
        [
            'aws', 'sts', 'get-caller-identity',
            '--query', 'Arn', '--output', 'text',
            '--profile', profile_name
        ],
        stderr=subprocess.PIPE,
        stdout=subprocess.PIPE
    )
    if result.returncode != 0:
        print(result.stderr.decode(), file=sys.stderr)
        sys.exit("Please login with 'aws sso login --profile=%s'" %
                 profile_name)
    if silent:
        return

    print("Updated credentials for:\n%s" % result.stdout.decode())


def create_cache_key(profile_config):
    """ Resemble aws cli compatible cache key for the profile configuration. """

    args = {
        'startUrl': profile_config['sso_start_url'],
        'roleName': profile_config['sso_role_name'],
        'accountId': profile_config['sso_account_id']
    }

    args_json = json.dumps(args, sort_keys=True, separators=(',', ':'))
    return sha1(args_json.encode('utf-8')).hexdigest()


def get_cached_role_credentials(profile_config):
    """ Get role credentials for profile from cli cache. """

    cache_path = os.path.expanduser(os.path.join('~', '.aws', 'cli', 'cache'))
    file_cache = credentials.JSONFileCache(working_dir=cache_path)
    cache_key = create_cache_key(profile_config)
    try:
        cache_item = file_cache.__getitem__(cache_key)
    except Exception:
        return None

    cached_credentials = cache_item['Credentials']
    expires = cached_credentials['Expiration'].replace("UTC", "+0000")
    cached_credentials['Expiration'] = expires
    expires_datetime = datetime.strptime(expires, "%Y-%m-%dT%H:%M:%S%z")

    if expires_datetime <= datetime.now(timezone.utc):
        return None

    return cached_credentials


def get_role_credentials(profile_name, profile_config, silent):
    """ retrieve role credentials for selected profile """

    # try to read from cache
    role_cred = get_cached_role_credentials(profile_config)

    # on no success: update cache
    if role_cred is None:
        update_cached_role_credentials(profile_name, silent)
        role_cred = get_cached_role_credentials(profile_config)

    # still no succes? then fail
    if role_cred is None:
        print("Could not retrieve credentials for '%s'" %
              profile_name, file=sys.stderr)
        sys.exit("Please login with 'aws sso login --profile=%s'" %
                 profile_name)

    # on success:
    return role_cred


def import_creds(args):
    profile_name = args.profile

    # retrieve profile configuration
    profile_config = retrieve_profile(profile_name)

    # retrieve role credentials for selected profile
    role_cred = get_role_credentials(profile_name, profile_config, False)

    # set profile section in credentials file
    credentials_path = os.path.expanduser(
        os.path.join('~', '.aws', 'credentials'))
    c = configparser.ConfigParser()
    c.read(credentials_path)

    c[profile_name] = {
        'aws_access_key_id': role_cred['AccessKeyId'],
        'aws_secret_access_key': role_cred['SecretAccessKey'],
        'aws_session_token': role_cred['SessionToken'],
        'aws_security_token': role_cred['SessionToken']
    }

    # TODO make this atomic
    # write credentials file
    with open(credentials_path, 'w') as cred_file:
        c.write(cred_file)


def export(args):
    profile_name = args.profile

    # retrieve profile configuration
    profile_config = retrieve_profile(profile_name)
    aws_region = profile_config.get('region')

    # retrieve role credentials for selected profile
    role_cred = get_role_credentials(profile_name, profile_config, True)

    # print exportable credentials
    if platform.system() != 'Windows':
        print('export AWS_ACCESS_KEY_ID="%s"' % role_cred['AccessKeyId'])
        print('export AWS_SECRET_ACCESS_KEY="%s"' %
              role_cred['SecretAccessKey'])
        print('export AWS_SESSION_TOKEN="%s"' % role_cred['SessionToken'])
        print('export AWS_SECURITY_TOKEN="%s"' % role_cred['SessionToken'])
        if aws_region is not None:
            print('export AWS_DEFAULT_REGION="%s"' % aws_region)


def process(args):
    profile_name = args.profile

    # retrieve profile configuration
    profile_config = retrieve_profile(profile_name)

    # retrieve role credentials for selected profile
    role_cred = get_role_credentials(profile_name, profile_config, True)
    role_cred['Version'] = 1

    print(json.dumps(role_cred, sort_keys=True, separators=(',', ':')))


def console(args):
    profile_name = args.profile
    force_logout = args.force_logout
    logout_pause = args.logout_wait

    # retrieve profile configuration
    profile_config = retrieve_profile(profile_name)
    region = profile_config.get('sso_region')
    account = profile_config.get('sso_account_id')

    # retrieve role credentials for selected profile
    role_cred = get_role_credentials(profile_name, profile_config, False)

    # Get sign-in token from role credentials
    url_param = '?Action=getSigninToken&SessionDuration=43200&Session='
    url_param += quote_plus(json.dumps({
        'sessionId': role_cred.get('AccessKeyId'),
        'sessionKey': role_cred.get('SecretAccessKey'),
        'sessionToken': role_cred.get('SessionToken')
    }))
    url = "https://signin.aws.amazon.com/federation" + url_param

    signin_token_response = json.loads(requests.get(url).text)

    # Send browser to login URL
    url_param = '?Action=login&Issuer=-aws-sso-console&Destination='
    url_param += quote_plus("https://%s.console.aws.amazon.com/" % region)
    url_param += "&SigninToken=" + signin_token_response.get("SigninToken")
    url = ("https://%s.signin.aws.amazon.com/federation" % account) + url_param

    # Log out of old session?
    if force_logout or logout_pause is not None:
        logout_url = "https://%s.console.aws.amazon.com/console/logout!doLogout" % region
        webbrowser.open(logout_url, new=0, autoraise=False)

        if logout_pause is not None and logout_pause > 0:
            time.sleep(logout_pause)

    # Log into target role
    webbrowser.open(url)


def main():
    args = get_arguments()
    if 'command' in args:
        args.command(args)
    else:
        sys.exit("No command given! Use with '-h'.")


if __name__ == "__main__":
    main()