#!/usr/bin/env bash

set -e

model_directory=${1%/} # remove any trailing slash
current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
# exit_if_not_ci
exit_if_directory_not_specified_as_first_argument ${model_directory}

if ! gsutil ls | grep -q ${BUCKET}/; then
  gsutil mb -l ${REGION} ${BUCKET}
fi

echo "[INFO] Copying model binaries to bucket"
gsutil cp ${model_directory}/build/model.pkl ${BUCKET}/nlp_sentiment/build/model.pkl
