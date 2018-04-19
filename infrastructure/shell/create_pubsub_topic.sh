#!/usr/bin/env bash

set -e

topic_name=bitcoin_stock_price

gcloud pubsub topics create ${topic_name}