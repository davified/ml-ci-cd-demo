#!/usr/bin/env bash

set -e
# TODO: davidtan [2018-01-27] make this work with 2 cpus

if [[ $1 == '' ]]; then
  echo "ERROR: Usage ./create_dataproc_cluster.sh <cluster_name>"
  exit 1
fi

cluster_name=$1

./set_project_config.sh

echo "Creating a Dataproc cluster. This will take a few minutes..."

gcloud dataproc clusters create ${cluster_name} --single-node \
  --region=asia-southeast1 \
  --zone=asia-southeast1-a \
  --initialization-actions gs://dataproc-initialization-actions/datalab/datalab.sh
