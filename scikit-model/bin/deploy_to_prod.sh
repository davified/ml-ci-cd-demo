#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
# exit_if_not_ci

VERSION_TO_DEPLOY_TO_PROD=$1

current_deployed_version="v$(gcloud beta ml-engine models list | grep ${MODEL_NAME} | cut -d "v" -f 2)"

echo "[INFO] Current deployed version is ${current_deployed_version}"
echo "[INFO] VERSION_TO_DEPLOY_TO_PROD=${VERSION_TO_DEPLOY_TO_PROD}"
echo "[INFO] Next version to be deployed will be ${VERSION_TO_DEPLOY_TO_PROD}"
gcloud beta ml-engine versions set-default ${VERSION_TO_DEPLOY_TO_PROD} --model=${MODEL_NAME}

echo "[INFO] Listing model(s) and default version name(s)"
gcloud beta ml-engine models list

echo "[INFO] Running smoke test against latest deployed version"
${current_directory}/smoke_test.sh ${VERSION_TO_DEPLOY_TO_PROD}