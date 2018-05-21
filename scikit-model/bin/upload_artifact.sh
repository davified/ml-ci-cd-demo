#!/usr/bin/env bash

set -e

if [[ $CI != "true" ]]; then
    echo "[ERROR] This script should only be run on CI, and not on a local machine."
    echo "[ERROR] Exiting..."
    exit 1
fi

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh

if ! gsutil ls | grep -q gs://${BUCKET}/; then
  gsutil mb -l ${REGION} gs://${BUCKET}
fi

echo "[INFO] Copying model binaries to bucket"
gsutil cp ./build/model.pkl gs://$BUCKET/model.pkl