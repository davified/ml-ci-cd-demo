#!/usr/bin/env bash

set -e

echo "[INFO] Getting data..."

mkdir -p ./data

curl https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data -o ./data/adult.data
curl https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test -o ./data/adult.test

echo "[INFO] Done!"