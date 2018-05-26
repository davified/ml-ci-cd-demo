#!/usr/bin/env bash

set -e

JSON_DATA=./census.json
MODEL_NAME=census_tensorflow

gcloud ml-engine predict --model ${MODEL_NAME} --json-instances ${JSON_DATA}
