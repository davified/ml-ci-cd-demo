#!/usr/bin/env bash

set -e

model_directory=${1%/} # remove any trailing slash
current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_directory_not_specified_as_first_argument $1

if [[ ${model_directory} == 'scikit-model' ]]; then
  echo "[INFO] gcloud local training option is not available for scikit-learn models"
  echo "[INFO] Use bin/train.sh scikit-model instead."
  echo "[INFO] Exiting..."
  exit 0
fi

cd ${model_directory}
./bin/train_gcloud_local.sh
cd - > /dev/null # mute output