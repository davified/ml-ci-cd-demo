#!/usr/bin/env bash

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="$(echo $current_directory | sed 's/\/ml-ci-cd-demo.*/\/ml-ci-cd-demo/g')"

MODEL_NAME="census_model" # to be replaced with MODEL_NAME in common.sh
JOB_NAME="$MODEL_NAME$(date '+%d_%m_%Y_%H_%M_%S')"

# for training locally
# TRAIN_DATA="${current_directory}/../data/adult.data.csv"
# EVAL_DATA="${current_directory}/../data/adult.test.csv"

# for training on cloud ml engine
TRAIN_DATA="${BUCKET}/data/adult.data.csv"
EVAL_DATA="${BUCKET}/data/adult.test.csv"
OUTPUT_PATH="${BUCKET}/tf-estimator-output/${JOB_NAME}"
echo ${OUTPUT_PATH} > ${project_directory}/tf-estimator/build/model_output_path.txt

gcloud ml-engine jobs submit training ${JOB_NAME} \
    --job-dir ${OUTPUT_PATH} \
    --runtime-version 1.4 \
    --module-name trainer.task \
    --package-path trainer/ \
    --region ${REGION} \
    --scale-tier STANDARD_1 \
    --stream-logs
    -- \
    --train-files ${TRAIN_DATA} \
    --eval-files ${EVAL_DATA} \
    --train-steps 1000 \
    --verbosity DEBUG  \
    --eval-steps 100
