#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"

echo "[DEBUG] Listing python tests directory"
ls "$current_directory/../tests"

echo "[INFO] Running model evaluation tests"
nosetests -w "$current_directory/../tests" -a 'statistical_test'
