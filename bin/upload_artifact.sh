#!/usr/bin/env bash

set -e

model_directory=${1%/} # remove any trailing slash
current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_directory_not_specified_as_first_argument ${model_directory}

if [[ ${model_directory} == 'tf-estimator' ]]; then
  echo "[INFO] tensorflow models trained on gcloud ml-engine are already artifacted in ML Engine"
  echo "[INFO] Nothing to upload. Skipping..."
  exit 0
fi

cd ${model_directory}
./bin/upload_artifact.sh
cd - > /dev/null # mute output
