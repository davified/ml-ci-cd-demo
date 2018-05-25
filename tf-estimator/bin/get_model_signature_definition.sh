#!/usr/bin/env bash

set -e

MODEL_BINARIES=gs://ml-ci-cd-demo-mlengine/tf-estimator-output/census_model24_05_2018_10_31_46/export/census/1527129398/

saved_model_cli show --dir $MODEL_BINARIES --tag serve --signature_def predict
