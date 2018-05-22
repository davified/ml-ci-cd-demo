#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"

source ${current_directory}/common.sh

curl --request POST \
  --url "https://ml.googleapis.com/v1/projects/${PROJECT_ID}/models/${MODEL_NAME}/versions/${VERSION_NAME}:predict" \
  --header "authorization: Bearer $(gcloud auth print-access-token)" \
  --header 'content-type: application/json' \
  --data '{
  "instances": [
    [25, "Private", 226802, "11th", 7, "Never-married", "Machine-op-inspct", "Own-child", "Black", "Male", 0, 0, 40, "United-States"],
		[44, "Private", 160323, "Some-college", 10, "Married-civ-spouse", "Machine-op-inspct", "Husband", "Black", "Male", 7688, 0, 40, "United-States"]  
  ]
}
'