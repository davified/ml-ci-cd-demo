#!/usr/bin/env bash

set -e

echo "[INFO] Getting data..."

mkdir -p ./data

curl https://storage.googleapis.com/ml-ci-cd-demo-mlengine/nlp_sentiment/data/reviews_400K.json -o ./data/reviews_400K.json

NO_OF_SAMPLES=10
FIXTURES_DIR=./scikit-nlp-model/tests/fixtures

head -n ${NO_OF_SAMPLES} ./data/reviews_400K.json > ${FIXTURES_DIR}/review_${NO_OF_SAMPLES}_samples.json

# echo "[INFO] Generating fixtures for unit tests from training/testing data"
# head -n 10 ./data/adult.data > ./scikit-model/tests/fixtures/samples.csv

echo "[INFO] Done!"