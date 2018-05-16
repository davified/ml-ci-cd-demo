#!/usr/bin/env bash

set -e
PROJECT_ID="ml-ci-cd-demo"
# DATASET="TO_BE_NAMED"
# TABLE="TO_BE_NAMED"

bq mk ${DATASET}
bq mk --table ${PROJECT_ID}:${DATASET}.${TABLE}