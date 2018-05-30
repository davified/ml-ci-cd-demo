#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh

if [[ $1 = '' ]]; then
  echo "[ERROR] Please specify model version name as first argument to this script"
  echo "[ERROR] Example: bin/smoke_test.sh v42"
  echo "[ERROR] Exiting..."
  exit 1
fi

MODEL_NAME="nlp_sentiment"
version_name=$1

python ${current_directory}/smoke_test.py --version ${version_name}