#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="$(echo $current_directory | sed 's/\/ml-ci-cd-demo.*/\/ml-ci-cd-demo/g')"
source ${project_directory}/bin/common.sh

MODEL_NAME='census_tensorflow'