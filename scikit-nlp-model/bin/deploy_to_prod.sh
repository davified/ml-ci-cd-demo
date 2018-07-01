#!/usr/bin/env bash

set -e

source ./bin/common.sh
exit_if_not_ci

version_to_deploy_to_prod=$(cat ./config/SKLEARN_NLP_PROD_VERSION.txt)

current_deployed_version=$(get_current_default_version_for ${MODEL_NAME})

echo "[INFO] Current deployed version is ${current_deployed_version}"
echo "[INFO] version_to_deploy_to_prod=${version_to_deploy_to_prod}"
echo "[INFO] Next version to be deployed will be ${version_to_deploy_to_prod}"
gcloud ml-engine versions set-default ${version_to_deploy_to_prod} --model=${MODEL_NAME}

echo "[INFO] Listing model(s) and default version name(s)"
gcloud ml-engine models list

./bin/smoke_test.sh ${version_to_deploy_to_prod}
