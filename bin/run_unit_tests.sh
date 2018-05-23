#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_directory_not_specified_as_first_argument $1

echo "[INFO] Activating virtual environment"
source deactivate
source activate ${virtual_environment_name}

cd $1
./bin/run_unit_tests.sh
cd - > /dev/null # mute output