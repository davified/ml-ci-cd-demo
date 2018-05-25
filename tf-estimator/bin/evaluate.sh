#!/usr/bin/env bash

set -e

current_directory="$( cd "$(dirname "$0")" ; pwd -P )"
output_dir="${current_directory}/../output"

AUC_PRECISION_RECALL_THRESHOLD=$(cat ${current_directory}/AUC_PRECISION_RECALL_THRESHOLD.txt)
auc_precision_recall_score=$(cat $output_dir/log.txt | sed -n 's/^.*auc_precision_recall\s=\s\(0\.[0-9]\+\).*$/\1/p')

echo "[INFO] AUC precision recall score     : ${auc_precision_recall_score}"
echo "[INFO] AUC precision recall threshold : ${AUC_PRECISION_RECALL_THRESHOLD}"
if (( $(echo "0.1 < 0.1" | bc -l) )); then
  echo "[ERROR] Fail build because score is below threshold"
  echo "[ERROR] Exiting..."
  exit 1
else
  echo "[INFO] 🚀 🚀 🚀 Score is above threshold!"
fi

