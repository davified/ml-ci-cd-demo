#!/usr/bin/env bash

# Run distributed training job on GCP ML Engine

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
project_directory="$(echo $current_directory | sed 's/\/ml-ci-cd-demo.*/\/ml-ci-cd-demo/g')"
output_dir="${project_directory}/tf-estimator/output"
mkdir -p $output_dir

MODEL_NAME="census_model" # to be replaced with MODEL_NAME in common.sh
JOB_NAME="$MODEL_NAME$(date '+%Y_%m_%d_%H_%M_%S')"

TRAIN_DATA="${BUCKET}/data/adult.data.csv"
EVAL_DATA="${BUCKET}/data/adult.test.csv"
OUTPUT_PATH="${BUCKET}/tf-estimator-output/${JOB_NAME}"
HYPERPARAMETER_CONFIG="${project_directory}/tf-estimator/hyperparameters.yml"

mkdir -p ${project_directory}/tf-estimator/build/

echo ${OUTPUT_PATH} > ${project_directory}/tf-estimator/build/last_trained_model_output_path.txt
gsutil cp ${project_directory}/tf-estimator/build/last_trained_model_output_path.txt $BUCKET/

gcloud ml-engine jobs submit training ${JOB_NAME} \
    --job-dir ${OUTPUT_PATH} \
    --runtime-version 1.4 \
    --configuration $HYPERPARAMETER_CONFIG \
    --module-name trainer.task \
    --package-path trainer/ \
    --region ${REGION} \
    --scale-tier STANDARD_1 \
    --stream-logs \
    -- \
    --train-files ${TRAIN_DATA} \
    --eval-files ${EVAL_DATA} \
    --train-steps 1000 \
    --verbosity DEBUG  \
    --eval-steps 100 \
    2>&1 |tee $output_dir/log.txt # write output to a log file + display on stdout and stderr
