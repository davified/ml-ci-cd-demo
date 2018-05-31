#!/usr/bin/env bash

set -e

./bin/run_unit_tests.sh $1

./bin/evaluate.sh $1