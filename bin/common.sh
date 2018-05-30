#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="$(echo $current_directory | sed 's/\/ml-ci-cd-demo.*/\/ml-ci-cd-demo/g')"

export PATH=$HOME/google-cloud-sdk/bin:$HOME/miniconda3/bin:$PATH
export virtual_environment_name="ml-ci-cd-demo"
export REGION="us-central1" # set to the same region where we're running Cloud ML Engine jobs
export PROJECT_ID="ml-ci-cd-demo"
export BUCKET="gs://${PROJECT_ID}-mlengine"
export MODEL_NAME="census_sklearn_pipeline"

if [[ $CI == 'true' ]]; then
  export GOOGLE_APPLICATION_CREDENTIALS="${TRAVIS_BUILD_DIR}/gcp_ml_ci_cd_demo.json"
else
  export GOOGLE_APPLICATION_CREDENTIALS="${project_directory}/gcp_ml_ci_cd_demo.json"
fi

if [[ $IS_SETUP != 'true' ]]; then
  echo "[INFO] Activating virtual environment"
  source deactivate
  source activate ${virtual_environment_name}

  echo "[INFO] Setting project to ${PROJECT_ID}"
  gcloud config set project $PROJECT_ID

  echo "[INFO] Activating service account"
  gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}
fi


exit_if_not_ci() {
  if [[ $CI != "true" ]]; then
    echo "[ERROR] This script should only be run on CI, and not on a local machine."
    echo "[ERROR] Exiting..."
    exit 1
  fi
}

exit_if_directory_not_specified_as_first_argument() {
  if [[ $1 == '' ]]; then
    echo "[ERROR] Please specify directory (e.g. scikit-model, scikit-nlp-model or tf-estimator) as first argument to this shell script"
    echo "[ERROR] Exiting..."
    exit 1
  fi
}

get_latest_model_version_for() {
  echo $(gcloud ml-engine versions list --model=$1 |
  tail -n+2           |
  grep -Eo '^[^ ]+'   |
  cut -d "v" -f 2     |
  sort -n             |
  tail -n 1)
}

get_current_default_version_for() {
  MODEL_NAME=$1
  echo "v$(gcloud ml-engine models list | grep ${MODEL_NAME} | cut -d "v" -f 2)"
}

get_next_version_name_for() {
  MODEL_NAME=$1
  # Getting latest version number for ${MODEL_NAME} model
  latest_version_number=$(get_latest_model_version_for ${MODEL_NAME})
  latest_version_plus_one="v$((${latest_version_number} + 1))"

  # Next version to be deployed will be ${latest_version_plus_one}"
  echo ${latest_version_plus_one}
}
