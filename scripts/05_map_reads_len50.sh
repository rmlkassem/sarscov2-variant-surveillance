#!/usr/bin/env bash

set -euo pipefail

echo "Starting Phase 4: Mapping length-50 trimmed reads"

REF="references/NC_045512.2.fasta"

mkdir -p results/bam_len50
mkdir -p results/mapping_stats_len50
mkdir -p results/coverage_len50
mkdir -p logs

if [[ ! -f "$REF" ]]; then
    echo "ERROR: Reference genome not found: $REF"
    exit 1
fi

if [[ ! -f "${REF}.bwt" ]]; then
    echo "Indexing reference with BWA..."
    bwa index "$REF"
fi

if [[ ! -f "${REF}.fai" ]]; then
    echo "Indexing reference with samtools faidx..."
    samtools faidx "$REF"
fi

for R1 in results/trimmed/*_R1.trimmed.fastq.gz
do
    RUN=$(basename "$R1" _R1.trimmed.fastq.gz)
    R2="results/trimmed/${RUN}_R2.trimmed.fastq.gz"

    echo "======================================"
    echo "Mapping sample: $RUN"
    echo "======================================"

    if [[ ! -f "$R2" ]]; then
        echo "ERROR: Missing R2 for $RUN"
        exit 1
    fi

    bwa mem -t 4 "$REF" "$R1" "$R2" \
    2> "logs/${RUN}_len50_bwa.log" \
    | samtools sort -@ 4 \
    -o "results/bam_len50/${RUN}.len50.sorted.bam" -

    samtools index "results/bam_len50/${RUN}.len50.sorted.bam"

    samtools flagstat \
    "results/bam_len50/${RUN}.len50.sorted.bam" \
    > "results/mapping_stats_len50/${RUN}.flagstat.txt"

    samtools depth -a \
    "results/bam_len50/${RUN}.len50.sorted.bam" \
    > "results/coverage_len50/${RUN}.depth.txt"

    awk '
    {
        total += $3
        if ($3 > 0) covered++
        if ($3 >= 10) covered10++
    }
    END {
        print "Genome positions:", NR
        print "Mean depth:", total/NR
        print "Covered positions >0x:", covered, "(" covered/NR*100 "%)"
        print "Covered positions >=10x:", covered10, "(" covered10/NR*100 "%)"
    }
    ' "results/coverage_len50/${RUN}.depth.txt" \
    > "results/coverage_len50/${RUN}.coverage_summary.txt"

done

echo -e "sample\tmapped_percent\tproperly_paired_percent" \
> results/mapping_stats_len50/mapping_summary_len50.tsv

for FILE in results/mapping_stats_len50/*.flagstat.txt
do
    SAMPLE=$(basename "$FILE" .flagstat.txt)

    MAPPED=$(grep " mapped (" "$FILE" | head -n 1 | sed -E 's/.*\(([^%]+)%.*/\1/')
    PROPER=$(grep " properly paired (" "$FILE" | sed -E 's/.*\(([^%]+)%.*/\1/')

    echo -e "${SAMPLE}\t${MAPPED}\t${PROPER}" \
    >> results/mapping_stats_len50/mapping_summary_len50.tsv
done

echo -e "sample\tmean_depth\tcovered_gt0_percent\tcovered_10x_percent" \
> results/coverage_len50/coverage_summary_len50.tsv

for FILE in results/coverage_len50/*.coverage_summary.txt
do
    SAMPLE=$(basename "$FILE" .coverage_summary.txt)

    MEAN=$(grep "Mean depth" "$FILE" | awk '{print $3}')
    COV0=$(grep "Covered positions >0x" "$FILE" | sed -E 's/.*\(([^%]+)%.*/\1/')
    COV10=$(grep "Covered positions >=10x" "$FILE" | sed -E 's/.*\(([^%]+)%.*/\1/')

    echo -e "${SAMPLE}\t${MEAN}\t${COV0}\t${COV10}" \
    >> results/coverage_len50/coverage_summary_len50.tsv
done

echo "Phase 4 length-50 mapping complete."
