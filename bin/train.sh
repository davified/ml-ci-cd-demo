#!/usr/bin/env bash

set -e

if [[ $1 == '' ]]; then
  echo "[ERROR] Please specify directory (e.g. scikit-model or tf-estimator) as first argument"
  exit 1
fi

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh

echo "debugging: which source"
which source

echo "[INFO] Activating virtual environment"
source activate ${virtual_environment_name}

cd $1
./bin/train.sh
cd - > /dev/null # mute output