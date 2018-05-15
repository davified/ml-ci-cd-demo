#!/usr/bin/env bash

set -e

source ./common.sh

echo "INFO: Setting project to ${PROJECT_ID}"
gcloud config set project ${PROJECT_ID}

if ! gsutil ls | grep -q gs://${BUCKET}/; then
  gsutil mb -l ${REGION} gs://${BUCKET}
fi

echo "INFO: Copying model binaries to bucket"
gsutil cp ./model.pkl gs://$BUCKET/model.pkl

echo "INFO: Creating model resource (i.e. a container for all versions of this model)" 
# gcloud beta ml-engine models create ${MODEL_NAME}  # note: this command is not idempotent. can only be run once
#--region ${REGION}

echo "INFO: Deploying model to GCP ML Engine"

DEPLOYMENT_SOURCE="gs://$BUCKET"
FRAMEWORK="SCIKIT_LEARN"

echo "INFO: Creating a version of the model"
gcloud beta ml-engine versions create $VERSION_NAME \
    --model $MODEL_NAME --origin $DEPLOYMENT_SOURCE \
    --runtime-version="1.5" --framework $FRAMEWORK \
    --python-version=3.5

echo "INFO: Describe version"
gcloud beta ml-engine versions describe $VERSION_NAME \
    --model $MODEL_NAME
