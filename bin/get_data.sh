#!/usr/bin/env bash

set -e

source ./bin/common.sh
exit_if_directory_not_specified_as_first_argument $1
MODEL_DIR=$1

echo "[INFO] Getting data..."

mkdir -p ./data

curl https://storage.googleapis.com/ml-ci-cd-demo-mlengine/nlp_sentiment/data/reviews_400K.json -o ./data/reviews_400K.json

echo "[INFO] Creating test fixtures..."
NO_OF_SAMPLES=10
FIXTURES_DIR=$MODEL_DIR/tests/fixtures

head -n ${NO_OF_SAMPLES} ./data/reviews_400K.json > ${FIXTURES_DIR}/review_${NO_OF_SAMPLES}_samples.json

echo "[INFO] Done!"