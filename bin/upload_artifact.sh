#!/usr/bin/env bash

set -e

source ./bin/common.sh
exit_if_not_ci
exit_if_directory_not_specified_as_first_argument $1

if ! gsutil ls | grep -q ${BUCKET}/; then
  gsutil mb -l ${REGION} ${BUCKET}
fi

echo "[INFO] Copying model binaries to bucket"
gsutil cp $1/build/model.pkl ${BUCKET}/nlp_sentiment/build/model.pkl
