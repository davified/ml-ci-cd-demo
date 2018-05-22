#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh
exit_if_directory_not_specified_as_first_argument $1

if [[ $2 == '' ]]; then
  echo "[ERROR] Please specify model version (e.g. v42) to be deployed to production as the second argument to this shell script"
  echo "[ERROR] Exiting..."
  exit 1
fi

VERSION_TO_DEPLOY_TO_PROD=$2

cd $1
./bin/deploy_to_prod.sh $VERSION_TO_DEPLOY_TO_PROD
cd - > /dev/null # mute output