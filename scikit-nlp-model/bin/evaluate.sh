#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"

echo "[INFO] Running model evaluation tests"
nosetests -w "./tests" -a 'statistical_test'
