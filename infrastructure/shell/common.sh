#!/usr/bin/env bash

# This script defines variables which are required by more than 1 shell script.
set -e

export project_id="ml-ci-cd-demo"
export bucket_name="bitcoin_prices"

source ./configure_api_key.sh
echo $GOOGLE_APPLICATION_CREDENTIALS