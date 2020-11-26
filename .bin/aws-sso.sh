#!/usr/bin/env bash

set -o nounset -o errexit -o pipefail

AWS_PROFILE="${AWS_PROFILE:-1}"

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN

# echo -n "** Using SSO profile: $AWS_PROFILE ... "

# login to AWS via browser
aws-sso.py export --profile "$AWS_PROFILE" >/dev/null 2>&1 ||
  aws sso login --profile "$AWS_PROFILE" >/dev/null
# import to ~/.aws/credentials
aws-sso.py import --profile "$AWS_PROFILE"
# export to env
aws-sso.py export --profile "$AWS_PROFILE" | tee ~/.local/aws-sso-$AWS_PROFILE.secrets

# echo "** authenticated as: $(aws iam list-account-aliases --output json | jq -r '.AccountAliases[]')"
# echo "** arn: $(aws sts get-caller-identity --output json | jq -r '.Arn')"
