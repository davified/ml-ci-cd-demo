#!/usr/bin/env bash

set -e

# if [[ $CI != "true" ]]; then
#     echo "[ERROR] This script should only be run on CI, and not on a local machine."
#     echo "[ERROR] Exiting..."
#     exit 1
# fi

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh

model_status_code=$(gcloud beta ml-engine models list | grep -c ${MODEL_NAME} || true) # 1 if model exists, 0 otherwise
if [[ ${model_status_code} == 0 ]]; then
    echo "[INFO] Creating model resource (i.e. a container for all versions of this model)" 
    gcloud beta ml-engine models create ${MODEL_NAME} --regions ${REGION}
fi

echo "[INFO] Deploying model to GCP ML Engine"
DEPLOYMENT_SOURCE="gs://$BUCKET"
FRAMEWORK="SCIKIT_LEARN"

echo "[INFO] Getting latest version number for ${MODEL_NAME} model"
latest_version=$(gcloud beta ml-engine versions list --model=census_sklearn_pipeline | awk '{w=$1} END{print w}')
latest_version_number=$(echo ${latest_version} | cut -d "v" -f 2)
latest_version_number_plus_one=$((${latest_version_number} + 1))
echo "[INFO] Latest version is v${latest_version_number} and next version to be deployed will be v${latest_version_number_plus_one}"

echo "[INFO] Creating a version of the model"
gcloud beta ml-engine versions create "v${latest_version_number_plus_one}" \
    --model $MODEL_NAME --origin $DEPLOYMENT_SOURCE \
    --runtime-version=1.5 --framework $FRAMEWORK \
    --python-version=3.5

echo "[INFO] Describe model versions"
gcloud beta ml-engine versions describe $VERSION_NAME \
    --model $MODEL_NAME
