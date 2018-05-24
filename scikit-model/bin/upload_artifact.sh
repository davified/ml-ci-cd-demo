#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_not_ci

if ! gsutil ls | grep -q ${BUCKET}/; then
  gsutil mb -l ${REGION} ${BUCKET}
fi

echo "[INFO] Copying model binaries to bucket"
gsutil cp ./build/model.pkl ${BUCKET}/model.pkl