#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
tf_estimator_dir="$current_directory/.."
TRAIN_DATA="${current_directory}/../data/adult.data.csv"
EVAL_DATA="${current_directory}/../data/adult.test.csv"
output_dir="${tf_estimator_dir}/output"
TRAIN_STEPS=1000

rm -rf $output_dir
mkdir -p $output_dir
touch $output_dir/log.txt

cd ${tf_estimator_dir}

echo "[INFO] Training tensorflow model locally"
gcloud ml-engine local train  --package-path trainer \
                              --module-name trainer.task \
                              -- \
                              --train-files $TRAIN_DATA \
                              --eval-files $EVAL_DATA \
                              --job-dir $output_dir \
                              --train-steps $TRAIN_STEPS \
                              --eval-steps 100 \
                              # &> $output_dir/log.txt  # comment out this line to see tensorflow logs in the console
