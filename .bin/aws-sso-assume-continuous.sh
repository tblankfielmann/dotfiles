#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

SSO_ACCOUNT=$(aws sts get-caller-identity --output json | jq -r '.Account')
export SSO_ROLE=${SSO_ROLE:-"arn:aws:iam::$SSO_ACCOUNT:role/continuous"}
export SSO_SESSION=${SSO_PROFILE:-"unknown"}
export SSO_DURATION=${SSO_DURATION:-"3600"}

aws sts assume-role --role-arn "$SSO_ROLE" --role-session-name "$SSO_SESSION" --duration-seconds "$SSO_DURATION" --output json |
    jq -r ' "export AWS_ACCESS_KEY_ID=" + .Credentials.AccessKeyId + "\n" + "export AWS_SECRET_ACCESS_KEY=" + .Credentials.SecretAccessKey + "\n" + "export AWS_SECURITY_TOKEN=" + .Credentials.SessionToken + "\n" + "export AWS_SESSION_TOKEN=" + .Credentials.SessionToken'
