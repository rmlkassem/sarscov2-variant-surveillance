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

## Image Summarizing the whole workflow

<img width="649" height="4540" alt="mermaid-diagram-2026-06-03-163622" src="https://github.com/user-attachments/assets/1658e508-39b4-4821-be08-b1324a12cb73" />
