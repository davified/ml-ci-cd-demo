#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_not_ci

model_status_code=$(gcloud beta ml-engine models list | grep -c ${MODEL_NAME} || true) # 1 if model exists, 0 otherwise
if [[ ${model_status_code} == 0 ]]; then
    echo "[INFO] Creating model resource (i.e. a container for all versions of this model)" 
    gcloud beta ml-engine models create ${MODEL_NAME} --regions ${REGION}
fi

echo "[INFO] Deploying model to GCP ML Engine"
DEPLOYMENT_SOURCE="${BUCKET}"
FRAMEWORK="SCIKIT_LEARN"

echo "[INFO] Getting latest version number for ${MODEL_NAME} model"
latest_version_number=$(gcloud beta ml-engine versions list --model=${MODEL_NAME} |
tail -n+2           |
grep -Eo '^[^ ]+'   |
cut -d "v" -f 2     |
sort -n             |
tail -n 1)
latest_version_plus_one="v$((${latest_version_number} + 1))"
echo "[INFO] Latest version is v${latest_version_number} and next version to be deployed will be ${latest_version_plus_one}"

echo "[INFO] Creating a version of the model"
gcloud beta ml-engine versions create "${latest_version_plus_one}" \
    --model $MODEL_NAME --origin $DEPLOYMENT_SOURCE \
    --runtime-version=1.5 --framework $FRAMEWORK \
    --python-version=3.5

echo "[INFO] Describe model versions"
gcloud beta ml-engine versions describe $latest_version_plus_one \
    --model $MODEL_NAME

echo "[INFO] Running smoke test against latest deployed version"

${current_directory}/smoke_test.sh ${latest_version_plus_one}