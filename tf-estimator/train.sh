#!/usr/bin/env bash
# tutorial link: https://cloud.google.com/ml-engine/docs/tensorflow/getting-started-training-prediction

# define common environment variables
source ./common.sh
echo ${JOB_NAME} > ./latest_model_name.txt

# for training locally
#TRAIN_DATA="$(pwd)/data/adult.data.csv"
#EVAL_DATA="$(pwd)/data/adult.test.csv"

# for training on cloud ml engine
TRAIN_DATA="${BUCKET_NAME}/data/adult.data.csv"
EVAL_DATA="${BUCKET_NAME}/data/adult.test.csv"
OUTPUT_PATH="$BUCKET_NAME/$JOB_NAME"

gcloud ml-engine jobs submit training ${JOB_NAME} \
    --job-dir ${OUTPUT_PATH} \
    --runtime-version 1.4 \
    --module-name trainer.task \
    --package-path trainer/ \
    --region ${REGION} \
    --scale-tier STANDARD_1 \
    -- \
    --train-files "${BUCKET_NAME}/data/adult.data.csv" \
    --eval-files "${BUCKET_NAME}/data/adult.test.csv" \
    --train-steps 1000 \
    --verbosity DEBUG  \
    --eval-steps 100
