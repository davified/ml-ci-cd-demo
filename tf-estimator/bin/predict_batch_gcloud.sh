#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_directory}/common.sh

JOB_NAME='batch_prediction'
MODEL_NAME='census_tensorflow'
INPUT_PATH="$BUCKET/data/tensorflow/census.json"
OUTPUT_PATH="$BUCKET/predictions"
DATA_FORMAT='text'

gcloud ml-engine jobs submit prediction $JOB_NAME \
  --model $MODEL_NAME \
  --input-paths $INPUT_PATH \
  --output-path $OUTPUT_PATH \
  --region $REGION \
  --data-format $DATA_FORMAT
