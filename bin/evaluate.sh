#!/usr/bin/env bash

set -e

source ./bin/common.sh
exit_if_directory_not_specified_as_first_argument $1

cd $1
echo "[INFO] Running model evaluation tests..."
# nosetests -w "./tests" -a 'statistical_test'
python -m unittest tests/test_model_evaluation.py 
