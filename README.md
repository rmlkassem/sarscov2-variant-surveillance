# SARS-CoV-2 Variant Calling and Lineage Surveillance

This project reproduces the computational logic of SARS-CoV-2 genomic surveillance workflows using public sequencing data.

## Main goals

1. Download public SARS-CoV-2 FASTQ data
2. Perform read quality control
3. Trim reads
4. Map reads to the NC_045512.2 reference genome
5. Coverage Analysis
6. Call variants
7. Build consensus genomes
8. Assign Pangolin / Nextclade lineages
9. Compare mutations and lineages between samples

## Base paper

COVseq is a cost-effective workflow for mass-scale SARS-CoV-2 genomic surveillance.
<img width="2958" height="2732" alt="mermaid-diagram-2026-06-03-163011" src="https://github.com/user-attachments/assets/c959b079-119c-4eea-9404-215fcac20349" />

