#!/usr/bin/env bash

set -e

# steps:
# load csv file
# drop unnecessary features and labels
# convert csv to gcp-expected format (see ./census.json)
# upload to GCS bucket