#!/usr/bin/env bash

set -e

source ./common.sh

curl --request POST \
  --url "https://ml.googleapis.com/v1/projects/${PROJECT_ID}/models/${MODEL_NAME}/versions/${VERSION_NAME}:predict" \
  --header "authorization: Bearer $(gcloud auth print-access-token)" \
  --header 'content-type: application/json' \
  --data '{
  "instances": [
    [25, 4, 226802, 1, 7, 4, 7, 3, 2, 1, 0, 0, 40, 38], [38, 4, 89814, 11, 9, 2, 5, 0, 4, 1, 0, 0, 50, 38], [28, 2, 336951, 7, 12, 2, 11, 0, 4, 1, 0, 0, 40, 38], [44, 4, 160323, 15, 10, 2, 7, 0, 2, 1, 7688, 0, 40, 38], [18, 0, 103497, 15, 10, 4, 0, 3, 4, 0, 0, 0, 30, 38]
  ]
}
'