#!/usr/bin/env bash

set -e

# 1. Generate your credentials on GCP. Instructions: https://cloud.google.com/iam/docs/creating-managing-service-account-keys
# 2. Uncomment the following line:
# path_to_credentials="~/.ssh/ml-ci-cd-demo-919f2fca8724.json"

if [[ -z ${path_to_credentials+x} ]]; then
  echo "Error: please configure your api keys in ./infrastructure/shell/configure_api_key.sh"
  exit 1
else
  export GOOGLE_APPLICATION_CREDENTIALS=${path_to_credentials}
fi

