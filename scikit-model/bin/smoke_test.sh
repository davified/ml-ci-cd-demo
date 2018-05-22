#!/usr/bin/env bash

set -e

if [[ $1 == '' ]]; then
  echo "[ERROR] Please specify model version number (e.g. v42) for smoke test as second argument"
  exit 1
fi

version_name=$1

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="${current_directory}/../.."
source ${current_directory}/common.sh

echo "[INFO] Activating virtual environment"
source activate ${virtual_environment_name}

echo "[INFO] Running smoke tests against model version ${version_name}"
python ${current_directory}/../get_predictions.py --version ${version_name}
