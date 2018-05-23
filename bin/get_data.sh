#!/usr/bin/env bash

set -e

echo "[INFO] Getting data..."

mkdir -p ./data

curl https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data -o ./data/adult.data
curl https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test -o ./data/adult.test

# remove the unnecessary first line from test data 
sed -i -e "1d" ./data/adult.test
# remove the unnecessary period (.) at the end of each line
# sed -i "s/.$//" ./data/adult.test

echo "[INFO] Generating fixtures for unit tests from training/testing data"
head -n 10 ./data/adult.data > ./scikit-model/tests/fixtures/samples.csv

echo "[INFO] Done!"