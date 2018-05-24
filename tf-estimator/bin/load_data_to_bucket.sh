#!/usr/bin/env bash

set -e

# to be replaced with a job that dumps data from BigQuery to GCS bucket

source ./bin/common.sh

head -n 5 ./tf-estimator/data/adult.data.csv
exit 0

echo "Copying data to ${BUCKET}/data/"
gsutil cp ./tf-estimator/data/adult.data.csv ${BUCKET}/data/adult.data.csv
gsutil cp ./tf-estimator/data/adult.test.csv ${BUCKET}/data/adult.test.csv
