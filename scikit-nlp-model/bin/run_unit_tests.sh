#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"

nosetests -w "${current_directory}/../tests" --ignore-files='test_model_evaluation'
