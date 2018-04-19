#!/usr/bin/env bash
# TODO: fix --data json payload bug in shell script
set -e

source ./common.sh
job_name="pubsub_to_bq"
topic_name="bitcoin_stock_price"
dataset="bitcoin_prices"
table="prices"
job_region="us-central1-f" # dataflow runs in limited regions

curl --request POST \
  --url 'https://dataflow.googleapis.com/v1b3/projects/ml-ci-cd-demo/templates:launch?gcsPath=gs://dataflow-templates/latest/PubSub_to_BigQuery' \
  --header "authorization: Bearer $(gcloud auth print-access-token)" \
  --data '{
   "jobName": "pubsub_to_bq",
   "parameters": {
       "inputTopic": "projects/ml-ci-cd-demo/topics/bitcoin_stock_price",
       "outputTableSpec": "ml-ci-cd-demo:bitcoin_prices.prices"
   },
   "environment": {
       "tempLocation": "gs://bitcoin_prices/temp",
       "zone": "us-central1-f"
   }
}'
