#!/usr/bin/env bash

set -e

if [[ $1 = '' ]]; then
  echo "[ERROR] Please specify model version name as first argument to this script"
  echo "[ERROR] Example: bin/smoke_test.sh v42"
  echo "[ERROR] Exiting..."
  exit 1
fi

source ./bin/common.sh

python ./bin/smoke_test.py --version $1
