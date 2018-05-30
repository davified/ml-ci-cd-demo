#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
# source ${current_directory}/common.sh
if [[ $1 == '' ]]; then
  echo "[ERROR] Please specify directory (e.g. scikit-nlp-model) as first argument to this shell script"
  echo "[ERROR] Exiting..."
  exit 1
fi

cd $1
./bin/deploy_to_staging.sh
cd - > /dev/null # mute output