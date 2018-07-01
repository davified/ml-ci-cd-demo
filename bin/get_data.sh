#!/usr/bin/env bash

set -e

source ./bin/common.sh
exit_if_directory_not_specified_as_first_argument $1
MODEL_DIR=$1

echo "[INFO] Getting data..."

mkdir -p ./data

# curl https://storage.googleapis.com/ml-ci-cd-demo-mlengine/nlp_sentiment/data/reviews_400K.json -o ./data/reviews_400K.json

echo "[INFO] Creating test fixtures"
copy_slice_of_data 10 $MODEL_DIR/tests/fixtures

echo "[INFO] Creating small subset of training data for local development"
copy_slice_of_data 100 ./data

echo "[INFO] Done!"
