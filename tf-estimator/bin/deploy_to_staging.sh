#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh

OUTPUT_PATH=$(cat ./build/model_output_path.txt) # why is . == tf-estimator?

echo "[INFO] Finding MODEL_BINARIES path on GCS bucket"
echo "[INFO] Found OUTPUT_PATH=${OUTPUT_PATH}"
MODEL_BINARIES=$(gsutil ls ${OUTPUT_PATH}/export/census | grep -E "${OUTPUT_PATH}/export/census/\d+/$")
echo "[INFO] Found MODEL_BINARIES=${MODEL_BINARIES}"

model_status_code=$(gcloud ml-engine models list | grep -c ${MODEL_NAME} || true) # 1 if model exists, 0 otherwise
if [[ ${model_status_code} == 0 ]]; then
  echo "[INFO] Creating model resource (i.e. a container for all versions of this model)" 
  gcloud ml-engine models create ${MODEL_NAME} --regions=${REGION}
else
  echo "[INFO] Model ${MODEL_NAME} already exists. Skipping model creation..." 
fi

latest_version_plus_one=$(get_next_version_name_for ${MODEL_NAME})
echo "[INFO] Creating next version (${latest_version_plus_one}) for model ${MODEL_NAME}"

echo "[INFO] Creating model version..." 
gcloud ml-engine versions create ${latest_version_plus_one} \
  --model ${MODEL_NAME} \
  --origin ${MODEL_BINARIES} \
  --runtime-version 1.4

${current_directory}/smoke_test.sh