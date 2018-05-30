#!/usr/bin/env bash

set -e

echo "[INFO] Getting data..."

mkdir -p ./data

curl https://storage.googleapis.com/ml-ci-cd-demo-mlengine/nlp_sentiment/data/review_400000_samples.json -o ./data/review_400000_samples.json

# echo "[INFO] Generating fixtures for unit tests from training/testing data"
# head -n 10 ./data/adult.data > ./scikit-model/tests/fixtures/samples.csv

echo "[INFO] Done!"