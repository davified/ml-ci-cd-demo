#!/usr/bin/env bash

set -e

if [[ $1 == '' ]]; then
  echo "[ERROR] Please supply model job name as first argument to this shell script"
  echo "[ERROR] Example: bin/launch_tensorboard.sh census_model2018_05_25_08_03_38"
  echo "[ERROR] Exiting..."
  exit 1
fi

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh

JOB_NAME=$1
OUTPUT_PATH="${BUCKET}/tf-estimator-output/${JOB_NAME}"
echo "[INFO] Please view tensorboard at http://localhost:6006"
tensorboard --logdir=$OUTPUT_PATH
