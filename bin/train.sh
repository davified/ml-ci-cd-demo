#!/usr/bin/env bash

set -e

source ./bin/common.sh
exit_if_directory_not_specified_as_first_argument $1

cd $1
echo "[INFO] Training model..."
python train.py
