#!/usr/bin/env bash

set -euo pipefail

echo "Starting Phase 3: Read trimming with fastp"

mkdir -p results/trimmed
mkdir -p results/fastp
mkdir -p logs

for R1 in data/raw/*_1.fastq.gz
do
    RUN=$(basename "$R1" _1.fastq.gz)
    R2="data/raw/${RUN}_2.fastq.gz"

    echo "======================================"
    echo "Processing sample: $RUN"
    echo "R1: $R1"
    echo "R2: $R2"
    echo "======================================"

    if [[ ! -f "$R2" ]]; then
        echo "ERROR: Missing R2 file for $RUN"
        exit 1
    fi

    fastp \
      -i "$R1" \
      -I "$R2" \
      -o "results/trimmed/${RUN}_R1.trimmed.fastq.gz" \
      -O "results/trimmed/${RUN}_R2.trimmed.fastq.gz" \
      --detect_adapter_for_pe \
      --qualified_quality_phred 20 \
      --length_required 50 \
      --thread 4 \
      --html "results/fastp/${RUN}_fastp.html" \
      --json "results/fastp/${RUN}_fastp.json" \
      2>&1 | tee "logs/${RUN}_fastp.log"

done

echo "Phase 3 trimming complete."
