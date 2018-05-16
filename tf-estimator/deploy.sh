#!/usr/bin/env bash

set -e

source ./common.sh
MODEL_BINARIES=gs://tensorflow-serving-200405-2/census_dist_1_11_04_2018_07_41_22/export/census/1523404051
if [[ $MODEL_BINARIES == "" ]]; then
  echo "ERROR: get dynamic MODEL_BINARIES path from gcloud bucket before running this script"
  echo "Example: gs://YOUR_BUCKET/MODEL_NAME/export/census/1523404051"
  echo "copy and replace the last number with the directory in the newly created bucket and run this script again"
  exit 1
fi

gcloud ml-engine models create ${MODEL_NAME} --regions=${REGION}

# OUTPUT_PATH="${BUCKET_NAME}/${JOB_NAME}"
# gsutil ls -r "${OUTPUT_PATH}/export"

gcloud ml-engine versions create v1 \
  --model ${MODEL_NAME} \
  --origin ${MODEL_BINARIES} \
  --runtime-version 1.4
