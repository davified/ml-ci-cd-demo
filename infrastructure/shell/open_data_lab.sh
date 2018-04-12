#!/usr/bin/env bash

set -e

if [[ $1 == '' ]]; then
  echo "ERROR: Usage ./open_data_lab.sh <cluster_name>"
  exit 1
fi

cluster_vm_name=$1-m  # cluster vm name = cluster name + '-m'

echo "===================================================================================="
echo "To access datalab, open another terminal in your local machine and run the following command:"
echo "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --proxy-server="socks5://localhost:1080" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost" --user-data-dir=/tmp/junk"
echo "===================================================================================="

gcloud compute ssh ${cluster_vm_name} --zone=asia-southeast1-a -- -D 1080  
