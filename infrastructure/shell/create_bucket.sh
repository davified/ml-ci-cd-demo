#!/usr/bin/env bash

set -e

source ./common.sh

storage_class="regional"
bucket_location="asia-southeast1"

gsutil mb -p ${project_id} -c ${storage_class} -l ${bucket_location} gs://${bucket_name}/
