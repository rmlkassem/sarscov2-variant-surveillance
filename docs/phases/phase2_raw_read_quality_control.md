# Phase 2: Raw Read Quality Control Using FastQC and MultiQC

## Purpose of this phase

The purpose of Phase 2 was to evaluate the quality of the raw sequencing reads before performing trimming, mapping, coverage analysis, variant calling, and consensus genome construction.

This step is important because raw FASTQ files may contain sequencing problems such as:

* low-quality bases
* abnormal sequence quality patterns
* adapter contamination
* unusual GC content
* high duplication levels
* overrepresented sequences
* variable sequence lengths

If these issues are not detected early, they can affect all downstream analysis steps. For example, low-quality bases can lead to incorrect mapping or false variant calls.

Therefore, raw read quality control is a necessary checkpoint before continuing to read trimming and mapping.

---

## What was done

FastQC was run on each raw paired-end FASTQ file.

Each of the six SARS-CoV-2 samples had two FASTQ files:

* forward reads: `_1.fastq.gz`
* reverse reads: `_2.fastq.gz`

Since there were six paired-end samples, FastQC was run on 12 raw FASTQ files in total.

After FastQC was completed, MultiQC was used to combine all FastQC outputs into one summary report. This made it easier to compare the quality of all samples together.

---

## Tools used

The tools used in this phase were:

* FastQC
* MultiQC

FastQC was used to generate an individual quality-control report for each FASTQ file.

MultiQC was used to summarize all FastQC reports into one combined report.

---

## FastQC output files

The FastQC outputs were stored in:

```text
results/fastqc/raw/
```

This folder contained one `.html` report and one `.zip` file for each raw FASTQ file.

Example:

```text
ERR11029820_1_fastqc.html
ERR11029820_1_fastqc.zip
ERR11029820_2_fastqc.html
ERR11029820_2_fastqc.zip
```

The `.html` files are human-readable FastQC reports that can be opened in a browser.

The `.zip` files contain the detailed FastQC result files used by MultiQC.

A total of 24 FastQC output files were produced:

* 12 HTML reports
* 12 ZIP result files

---

## Samples analyzed

The samples analyzed in this phase were:

```text
ERR11029820
ERR11029826
ERR11029834
ERR11029837
ERR11029838
ERR11029840
```

Each sample had forward and reverse reads, so the FastQC reports were generated for:

```text
ERR11029820_1
ERR11029820_2
ERR11029826_1
ERR11029826_2
ERR11029834_1
ERR11029834_2
ERR11029837_1
ERR11029837_2
ERR11029838_1
ERR11029838_2
ERR11029840_1
ERR11029840_2
```

---

## MultiQC output files

The MultiQC output was stored in:

```text
results/multiqc/raw/
```

The main report file was:

```text
multiqc_raw_report.html
```

This file provides a combined quality-control report for all raw FASTQ files.

The detailed MultiQC data were stored in:

```text
results/multiqc/raw/multiqc_raw_report_data/
```

This folder contained summary files such as:

```text
fastqc-status-check-heatmap.txt
fastqc_per_base_sequence_quality_plot.txt
fastqc_per_sequence_quality_scores_plot.txt
fastqc_per_sequence_gc_content_plot_Counts.txt
fastqc_per_base_n_content_plot.txt
fastqc_sequence_counts_plot.txt
fastqc_sequence_duplication_levels_plot.txt
fastqc_overrepresented_sequences_plot.txt
fastqc_top_overrepresented_sequences_table.txt
multiqc_fastqc.txt
multiqc_general_stats.txt
multiqc_data.json
multiqc.log
```

These files provide the underlying data used to build the MultiQC report.

---

## FastQC and MultiQC status interpretation

The file:

```text
fastqc-status-check-heatmap.txt
```

summarized the FastQC module status for all 12 raw FASTQ files.

The modules checked included:

* Basic Statistics
* Per Base Sequence Quality
* Per Tile Sequence Quality
* Per Sequence Quality Scores
* Per Base Sequence Content
* Per Sequence GC Content
* Per Base N Content
* Sequence Length Distribution
* Sequence Duplication Levels
* Overrepresented Sequences
* Adapter Content

The table showed that all raw FASTQ files passed important quality modules such as:

```text
Basic Statistics
Per Base Sequence Quality
Per Tile Sequence Quality
Per Sequence Quality Scores
Per Base N Content
Adapter Content
```

These results indicate that the raw reads had generally good base quality and did not show major adapter contamination.

Some modules showed intermediate or lower status values, including:

```text
Per Base Sequence Content
Per Sequence GC Content
Sequence Length Distribution
Sequence Duplication Levels
Overrepresented Sequences
```

This is not unexpected for amplicon-based viral sequencing data. Amplicon sequencing can produce non-random sequence composition, repeated regions, and high duplication patterns because reads are generated from targeted regions of a small viral genome.

The repeated lower score for sequence duplication levels suggests that many reads may be duplicated or highly similar. In the context of SARS-CoV-2 amplicon sequencing, this does not automatically mean the data are unusable. It should be interpreted carefully because targeted viral sequencing naturally produces uneven and repeated coverage patterns.

---

## Main results produced from this phase

The main outputs of Phase 2 were:

1. Individual FastQC HTML reports for each raw FASTQ file.

2. FastQC ZIP files containing detailed QC data for each raw FASTQ file.

3. A combined MultiQC HTML report summarizing all FastQC results.

4. MultiQC data tables containing module-level quality-control results.

5. A FastQC status heatmap showing the quality-control status of all samples across multiple QC modules.

---

## Phase 2 folder structure

The relevant Phase 2 output structure was:

```text
results/fastqc/raw/
├── ERR11029820_1_fastqc.html
├── ERR11029820_1_fastqc.zip
├── ERR11029820_2_fastqc.html
├── ERR11029820_2_fastqc.zip
├── ERR11029826_1_fastqc.html
├── ERR11029826_1_fastqc.zip
├── ERR11029826_2_fastqc.html
├── ERR11029826_2_fastqc.zip
├── ERR11029834_1_fastqc.html
├── ERR11029834_1_fastqc.zip
├── ERR11029834_2_fastqc.html
├── ERR11029834_2_fastqc.zip
├── ERR11029837_1_fastqc.html
├── ERR11029837_1_fastqc.zip
├── ERR11029837_2_fastqc.html
├── ERR11029837_2_fastqc.zip
├── ERR11029838_1_fastqc.html
├── ERR11029838_1_fastqc.zip
├── ERR11029838_2_fastqc.html
├── ERR11029838_2_fastqc.zip
├── ERR11029840_1_fastqc.html
├── ERR11029840_1_fastqc.zip
├── ERR11029840_2_fastqc.html
└── ERR11029840_2_fastqc.zip
```

```text
results/multiqc/raw/
├── multiqc_raw_report.html
└── multiqc_raw_report_data/
    ├── fastqc-status-check-heatmap.txt
    ├── fastqc_overrepresented_sequences_plot.txt
    ├── fastqc_per_base_n_content_plot.txt
    ├── fastqc_per_base_sequence_quality_plot.txt
    ├── fastqc_per_sequence_gc_content_plot_Counts.txt
    ├── fastqc_per_sequence_gc_content_plot_Percentages.txt
    ├── fastqc_per_sequence_quality_scores_plot.txt
    ├── fastqc_sequence_counts_plot.txt
    ├── fastqc_sequence_duplication_levels_plot.txt
    ├── fastqc_sequence_length_distribution_plot.txt
    ├── fastqc_top_overrepresented_sequences_table.txt
    ├── multiqc.log
    ├── multiqc.parquet
    ├── multiqc_citations.txt
    ├── multiqc_data.json
    ├── multiqc_fastqc.txt
    ├── multiqc_general_stats.txt
    ├── multiqc_software_versions.txt
    └── multiqc_sources.txt
```

---

## Conclusion

Phase 2 successfully evaluated the quality of the raw SARS-CoV-2 sequencing reads.

The most important quality modules, including per-base sequence quality, per-sequence quality scores, per-base N content, and adapter content, showed good status across the samples.

Some modules related to sequence composition, GC content, sequence length distribution, duplication levels, and overrepresented sequences showed warning or lower status values. These patterns are common in targeted viral amplicon sequencing and should be considered during interpretation, but they did not prevent the workflow from continuing.

The project was ready to move into Phase 3, where trimming and filtering were performed to remove low-quality reads and prepare the data for mapping.
