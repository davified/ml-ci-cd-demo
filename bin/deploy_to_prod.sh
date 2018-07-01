#!/usr/bin/env bash

set -e

source ./bin/common.sh
exit_if_not_ci

if [[ $1 == '' ]]; then
  echo "[ERROR] Please specify version of model to be deployed to PROD (e.g. v3) as first argument to this shell script"
  echo "[ERROR] Usage: ./bin/deploy_to_prod.sh v3"
  echo "[ERROR] Exiting..."
  exit 1
fi

version_to_deploy_to_prod=$1
current_deployed_version=$(get_current_default_version_for ${MODEL_NAME})

echo "[INFO] Current deployed version is ${current_deployed_version}"
echo "[INFO] version_to_deploy_to_prod=${version_to_deploy_to_prod}"
echo "[INFO] Next version to be deployed will be ${version_to_deploy_to_prod}"
gcloud ml-engine versions set-default ${version_to_deploy_to_prod} --model=${MODEL_NAME}

echo "[INFO] Model name and default version name (i.e. PROD version):"
gcloud ml-engine models list | grep ${MODEL_NAME}

./bin/smoke_test.sh ${version_to_deploy_to_prod}
