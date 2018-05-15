#!/usr/bin/env bash

set -e

export GOOGLE_APPLICATION_CREDENTIALS="~/.ssh/training-data-analyst.json"
export REGION="us-central1" # set to the same region where we're running Cloud ML Engine jobs
export PROJECT_ID="training-data-analyst-202307"
export BUCKET=${PROJECT_ID}-mlengine
export MODEL_NAME="census_scikit_learn"
export VERSION_NAME="v5"
