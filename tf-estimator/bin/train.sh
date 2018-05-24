#!/usr/bin/env bash

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="${current_directory}/../.."

MODEL_NAME="census_model" # to be replaced with MODEL_NAME in common.sh
JOB_NAME="$MODEL_NAME$(date '+%d_%m_%Y_%H_%M_%S')"

# for training locally
TRAIN_DATA="${project_directory}/data/adult.data"
EVAL_DATA="${project_directory}/data/adult.test"

# for training on cloud ml engine
# TRAIN_DATA="gs://${BUCKET}/data/adult.data.csv"
# EVAL_DATA="gs://${BUCKET}/data/adult.test.csv"
OUTPUT_PATH="gs://$BUCKET/$JOB_NAME"

gcloud ml-engine jobs submit training ${JOB_NAME} \
    --job-dir ${OUTPUT_PATH} \
    --runtime-version 1.4 \
    --module-name trainer.task \
    --package-path trainer/ \
    --region ${REGION} \
    --scale-tier STANDARD_1 \
    -- \
    --train-files ${TRAIN_DATA} \
    --eval-files ${EVAL_DATA} \
    --train-steps 1000 \
    --verbosity DEBUG  \
    --eval-steps 100
