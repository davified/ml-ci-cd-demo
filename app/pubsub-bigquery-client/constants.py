import os 

TOPIC_NAME='bitcoin_stock_price'
SUBSCRIPTION_NAME='bitcoin_price_subscription'
PROJECT='ml-ci-cd-demo'
DATASET_NAME='minutely-bitcoin-price'
TABLE_NAME='prices'
JOBNAME='pubsub_to_bq_job'
BUCKET='demo-stock-prices'
TEMPLATE='pubsub-to-bq-template'