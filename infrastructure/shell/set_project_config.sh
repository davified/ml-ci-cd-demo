#!/usr/bin/env bash

set -e

source ./common.sh

echo "setting gcloud cli core/project property to: ${project_id}"
gcloud config set project ${project_id}
