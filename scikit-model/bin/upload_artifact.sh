#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_not_ci

ls -la $GOOGLE_APPLICATION_CREDENTIALS

if ! gsutil ls | grep -q gs://${BUCKET}/; then
  gsutil mb -l ${REGION} gs://${BUCKET}
fi

echo "[INFO] Copying model binaries to bucket"
gsutil cp ./build/model.pkl gs://$BUCKET/model.pkl