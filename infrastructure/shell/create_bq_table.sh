#!/usr/bin/env bash

set -e
PROJECT_ID="ml-ci-cd-demo"
DATASET="bitcoin_prices"
TABLE="prices"

bq mk ${DATASET}
bq mk --table ${PROJECT_ID}:${DATASET}.${TABLE}