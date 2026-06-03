#!/usr/bin/env bash

set -euo pipefail

mkdir -p data/metadata

QUERY='SARS-CoV-2[Organism] AND Illumina[Platform] AND AMPLICON[Strategy]'

wget -O data/metadata/sra_runinfo_sarscov2_illumina_amplicon.csv \
"http://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&db=sra&rettype=runinfo&term=${QUERY}"

echo "Metadata downloaded:"
ls -lh data/metadata/sra_runinfo_sarscov2_illumina_amplicon.csv
