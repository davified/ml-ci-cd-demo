#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_directory_not_specified_as_first_argument $1

model_directory=${1%/} # remove any trailing slash

cd $model_directory
./bin/train.sh
cd - > /dev/null # mute output
