# Phase 1: Dataset and Reference Genome Setup

## Purpose of this phase

The purpose of Phase 1 was to prepare the starting data required for the SARS-CoV-2 genomic surveillance workflow.

This phase is important because every downstream analysis depends on having:

* Raw sequencing reads for each sample
* Metadata describing the selected runs
* A SARS-CoV-2 reference genome
* Indexed reference files needed by mapping and downstream tools

In this project, six paired-end SARS-CoV-2 sequencing samples were prepared for analysis.

---

## What was done

The project data were organized into two main parts:

1. Raw sequencing data and metadata under `data/`
2. SARS-CoV-2 reference genome files under `references/`

The raw sequencing data consisted of six paired-end FASTQ samples. Each sample has two files:

* `_1.fastq.gz`: forward reads
* `_2.fastq.gz`: reverse reads

The reference genome used in the project was `NC_045512.2`, which is the SARS-CoV-2 reference genome used throughout the mapping, coverage, variant calling, and consensus-building steps.

---

## Raw data organization

The raw sequencing reads were stored in:

```text
data/raw/
```

The folder contained 12 FASTQ files, representing six paired-end samples:

```text
ERR11029820_1.fastq.gz
ERR11029820_2.fastq.gz

ERR11029826_1.fastq.gz
ERR11029826_2.fastq.gz

ERR11029834_1.fastq.gz
ERR11029834_2.fastq.gz

ERR11029837_1.fastq.gz
ERR11029837_2.fastq.gz

ERR11029838_1.fastq.gz
ERR11029838_2.fastq.gz

ERR11029840_1.fastq.gz
ERR11029840_2.fastq.gz
```

These files are the starting point of the analysis. They contain the raw sequencing reads that were later checked by FastQC, trimmed, mapped to the reference genome, and used for variant calling.

---

## Selected samples

The six samples included in the project were:

```text
ERR11029820
ERR11029826
ERR11029834
ERR11029837
ERR11029838
ERR11029840
```

Each sample has a forward and reverse FASTQ file, meaning the data are paired-end sequencing data.

Paired-end data are useful because the two reads from the same DNA fragment improve mapping confidence and help produce more reliable downstream variant calls.

---

## Metadata files

Metadata files were stored in:

```text
data/metadata/
```

The metadata folder contained:

```text
ena_sarscov2_illumina_amplicon_paired.tsv
ena_sarscov2_illumina_metadata.tsv
selected_fastq_urls.txt
selected_runs.txt
selected_runs_metadata.tsv
```

These files document the selected sequencing runs and their associated information.

The most important metadata files are:

```text
selected_runs.txt
```

This file records the selected sample/run accessions used in the project.

```text
selected_runs_metadata.tsv
```

This file stores metadata for the selected runs.

```text
selected_fastq_urls.txt
```

This file stores the FASTQ download links used to obtain the raw sequencing data.

The metadata files are important for reproducibility because they allow another person to understand which samples were selected and where the raw data came from.

---

## Reference genome files

The SARS-CoV-2 reference genome files were stored in:

```text
references/
```

The folder contained:

```text
NC_045512.2.fasta
NC_045512.2.raw.fasta
NC_045512.2.fasta.fai
NC_045512.2.fasta.amb
NC_045512.2.fasta.ann
NC_045512.2.fasta.bwt
NC_045512.2.fasta.pac
NC_045512.2.fasta.sa
```

The main reference FASTA file was:

```text
references/NC_045512.2.fasta
```

This reference genome was used as the coordinate system for mapping, coverage analysis, variant calling, consensus genome generation, and visualization.

---

## Reference index files

Several index files were present beside the reference FASTA:

```text
NC_045512.2.fasta.fai
NC_045512.2.fasta.amb
NC_045512.2.fasta.ann
NC_045512.2.fasta.bwt
NC_045512.2.fasta.pac
NC_045512.2.fasta.sa
```

The `.fai` file is the FASTA index used by tools such as `samtools` and `bcftools`.

The `.amb`, `.ann`, `.bwt`, `.pac`, and `.sa` files are reference index files used for read alignment with BWA.

These index files are necessary because mapping tools and variant-calling tools need fast access to reference genome positions.

---

## Tools represented in this phase

Based on the produced files, this phase prepared files needed by tools used later in the workflow, including:

* FastQC and MultiQC for read quality control
* Trimming tools for read cleaning
* BWA for mapping
* Samtools for BAM processing and reference indexing
* Bcftools for variant calling and consensus-related work

No downstream analysis was performed in this phase yet. This phase mainly prepared and organized the input data.

---

## Results produced from this phase

The main results of Phase 1 were:

1. Six paired-end SARS-CoV-2 raw FASTQ datasets were available in `data/raw/`.

2. Metadata files documenting the selected runs were available in `data/metadata/`.

3. The SARS-CoV-2 reference genome `NC_045512.2.fasta` was available in `references/`.

4. Reference genome index files were present and ready for downstream mapping and variant calling.

5. The project was ready to move into Phase 2, which performs raw read quality control using FastQC and MultiQC.

---

## Phase 1 folder structure

The relevant Phase 1 structure was:

```text
data
├── metadata
│   ├── ena_sarscov2_illumina_amplicon_paired.tsv
│   ├── ena_sarscov2_illumina_metadata.tsv
│   ├── selected_fastq_urls.txt
│   ├── selected_runs.txt
│   └── selected_runs_metadata.tsv
└── raw
    ├── ERR11029820_1.fastq.gz
    ├── ERR11029820_2.fastq.gz
    ├── ERR11029826_1.fastq.gz
    ├── ERR11029826_2.fastq.gz
    ├── ERR11029834_1.fastq.gz
    ├── ERR11029834_2.fastq.gz
    ├── ERR11029837_1.fastq.gz
    ├── ERR11029837_2.fastq.gz
    ├── ERR11029838_1.fastq.gz
    ├── ERR11029838_2.fastq.gz
    ├── ERR11029840_1.fastq.gz
    └── ERR11029840_2.fastq.gz

references
├── NC_045512.2.fasta
├── NC_045512.2.fasta.amb
├── NC_045512.2.fasta.ann
├── NC_045512.2.fasta.bwt
├── NC_045512.2.fasta.fai
├── NC_045512.2.fasta.pac
├── NC_045512.2.fasta.sa
└── NC_045512.2.raw.fasta
```

The `data/nextclade/` folder was not included in this phase because it belongs to a later lineage-assignment step.

---

## Conclusion

Phase 1 successfully prepared the raw SARS-CoV-2 sequencing samples, metadata files, and reference genome required for the project.

This created the foundation for the rest of the workflow, where the raw reads would be checked for quality, cleaned, mapped to the reference genome, analyzed for coverage, used for variant calling, and eventually reconstructed into consensus genomes for lineage assignment.
