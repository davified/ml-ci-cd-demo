#!/usr/bin/env bash

set -e

if [[ $1 == '' ]]; then
  echo "[ERROR] Please specify directory (e.g. scikit-model or tf-estimator) as first argument"
  exit 1
fi

cd $1
./bin/train.sh
cd - > /dev/null # mute output