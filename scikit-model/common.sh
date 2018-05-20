#!/usr/bin/env bash

set -e

export GOOGLE_APPLICATION_CREDENTIALS="./gcp_ml_ci_cd_demo.json"
export REGION="us-central1" # set to the same region where we're running Cloud ML Engine jobs
export PROJECT_ID="ml-ci-cd-demo"
export BUCKET=${PROJECT_ID}-mlengine
export MODEL_NAME="census_sklearn_pipeline"
export VERSION_NAME="v4"

echo "INFO: Setting project to ${PROJECT_ID}"
gcloud config set project $PROJECT_ID