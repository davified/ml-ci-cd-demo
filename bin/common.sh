#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="${current_directory}/.."

export PATH=$HOME/google-cloud-sdk/bin:$HOME/miniconda3/bin:$PATH
export virtual_environment_name="ml-ci-cd-demo"
if [[ $CI == 'true' ]]; then
  export GOOGLE_APPLICATION_CREDENTIALS="${TRAVIS_BUILD_DIR}/gcp_ml_ci_cd_demo.json"
else
  export GOOGLE_APPLICATION_CREDENTIALS="${project_directory}/gcp_ml_ci_cd_demo.json"
fi

export REGION="us-central1" # set to the same region where we're running Cloud ML Engine jobs
export PROJECT_ID="ml-ci-cd-demo"
export BUCKET=${PROJECT_ID}-mlengine
export MODEL_NAME="census_sklearn_pipeline"


exit_if_not_ci() {
  if [[ $CI != "true" ]]; then
    echo "[ERROR] This script should only be run on CI, and not on a local machine."
    echo "[ERROR] Exiting..."
    exit 1
  fi
}

exit_if_directory_not_specified_as_first_argument() {
  if [[ $1 == '' ]]; then
    echo "[ERROR] Please specify directory (e.g. scikit-model or tf-estimator) as first argument to this shell script"
    echo "[ERROR] Exiting..."
    exit 1
  fi
}


echo "[INFO] Setting project to ${PROJECT_ID}"
gcloud config set project $PROJECT_ID

echo "[INFO] Activating service account"
gcloud auth activate-service-account --key-file ${TRAVIS_BUILD_DIR}/gcp_ml_ci_cd_demo.json