#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"

nosetests -w "${current_directory}/../tests" -I 'test_model_evaluation'
