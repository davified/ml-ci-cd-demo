#!/usr/bin/env bash

set -e

if [[ $1 == '' ]]; then
  echo "ERROR: Usage ./delete_dataproc_cluster.sh <cluster_name>"
  exit 1
fi

cluster_name=$1

./set_project_config.sh

gcloud dataproc clusters delete ${cluster_name} --region=asia-southeast1
