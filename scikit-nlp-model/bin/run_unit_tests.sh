#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"

python -m unittest tests/test_data_loader.py 
# nosetests -w "${current_directory}/../tests" --ignore-files='test_model_evaluation'
