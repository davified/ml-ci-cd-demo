#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_directory_not_specified_as_first_argument $1

model_directory=${1%/} # remove any trailing slash

if [[ $model_directory == 'tf-estimator' ]]; then
  cd $model_directory
  ./bin/train_on_cloud.sh
  cd - > /dev/null # mute output
else
  echo "[INFO] Cloud training option not available for scikit-learn models"
  echo "[INFO] Exiting..."
  exit 0
fi
