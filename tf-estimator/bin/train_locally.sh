#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
tf_estimator_dir="$current_directory/.."
TRAIN_DATA="${current_directory}/../data/adult.data.csv"
EVAL_DATA="${current_directory}/../data/adult.test.csv"
OUTPUT_DIR="${tf_estimator_dir}/output/census_$(date '+%Y%m%d_%H%M%S')"
TRAIN_STEPS=1000

rm -rf $OUTPUT_DIR

cd ${tf_estimator_dir}

echo "[INFO] Training tensorflow model locally"
gcloud ml-engine local train  --package-path trainer \
                              --module-name trainer.task \
                              -- \
                              --train-files $TRAIN_DATA \
                              --eval-files $EVAL_DATA \
                              --job-dir $OUTPUT_DIR \
                              --train-steps $TRAIN_STEPS \
                              --eval-steps 100

cd -
