#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="${current_directory}/../.."
source ${project_directory}/bin/common.sh

MODEL_NAME='census_tensorflow'