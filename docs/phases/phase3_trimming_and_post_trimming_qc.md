# Phase 3: Read Trimming and Post-Trimming Quality Control

## Why this phase is important

After checking the raw reads in Phase 2, the next step was to clean the reads.

Raw sequencing reads may contain:

* low-quality bases
* adapter sequences
* very short reads
* reads with too many uncertain bases

These problems can affect the next steps, especially mapping and variant calling.

If poor-quality reads are kept, they may map incorrectly to the SARS-CoV-2 reference genome or create false variants.

Therefore, trimming is important because it improves the quality of the reads before mapping.

---

## What was done

In this phase, the raw paired-end FASTQ files were processed using `fastp`.

The goal was to remove low-quality parts of the reads and filter out reads that were not suitable for downstream analysis.

Each sample had two paired-end files:

* Read 1
* Read 2

The six samples processed were:

```text
ERR11029820
ERR11029826
ERR11029834
ERR11029837
ERR11029838
ERR11029840
```

After trimming, `fastp` produced one HTML report and one JSON report for each sample.

Then, Fastqc is applied for each trimmed file, followed by MultiQC to summarize all Fastqc-trimmed results into one combined report.

---

## Tools used

The tools used in this phase were:

```text
fastp
Fastqc
MultiQC
```

`fastp` was used for read trimming and filtering.

MultiQC was used to summarize the fastp results and post-trimming quality-control outputs.

---

## fastp output files

The fastp output reports were stored in:

```text
results/fastp/
```

The folder contained:

```text
ERR11029820_fastp.html
ERR11029820_fastp.json
ERR11029826_fastp.html
ERR11029826_fastp.json
ERR11029834_fastp.html
ERR11029834_fastp.json
ERR11029837_fastp.html
ERR11029837_fastp.json
ERR11029838_fastp.html
ERR11029838_fastp.json
ERR11029840_fastp.html
ERR11029840_fastp.json
```

The `.html` files are visual reports that can be opened in a browser.

The `.json` files contain detailed trimming statistics that can be read by MultiQC.

---

## MultiQC output files after trimming

The MultiQC report for the trimmed reads was stored in:

```text
results/multiqc/trimmed/
```

The main report file was:

```text
multiqc_trimmed_report.html
```

This report summarizes the trimming results for all samples in one place.

The data folder was:

```text
results/multiqc/trimmed/multiqc_trimmed_report_data/
```

It contained files related to fastp and FastQC summaries after trimming, including:

```text
multiqc_fastp.txt
multiqc_fastqc.txt
multiqc_general_stats.txt
fastp_filtered_reads_plot.txt
fastp-seq-quality-plot_Read_1_Before_filtering.txt
fastp-seq-quality-plot_Read_1_After_filtering.txt
fastp-seq-quality-plot_Read_2_Before_filtering.txt
fastp-seq-quality-plot_Read_2_After_filtering.txt
```

These files help compare read quality before and after filtering.

---

## Main trimming results

The fastp reports showed that most reads passed filtering.

The number of reads after filtering was around:

```text
0.5 million to 0.6 million reads per sample
```

The percentage of reads passing filtering was around:

```text
90.6% to 92.7%
```

This means that most sequencing reads were kept after trimming.

The GC content was very consistent across samples:

```text
about 37.6% to 37.8%
```

This consistency is a good sign because all samples are from the same viral genome type.

The Q30 rate after filtering was around:

```text
90.6% to 91.5%
```

This means that most bases had high quality after trimming.

---

## Adapter trimming

fastp detected and trimmed adapter sequences.

The adapter percentage ranged approximately from:

```text
23.5% to 33.1%
```

This means adapter contamination was present in the raw reads and needed to be handled.

This is one of the reasons trimming was necessary.

---

## Reads removed during filtering

Most removed reads were removed because they became too short after trimming.

Examples of too-short reads removed:

```text
ERR11029820: 44,592 too-short reads
ERR11029826: 66,804 too-short reads
ERR11029834: 44,434 too-short reads
ERR11029837: 56,796 too-short reads
ERR11029838: 63,288 too-short reads
ERR11029840: 42,144 too-short reads
```

Only a very small number of reads were removed because of low quality or too many N bases.

This means the main filtering effect came from removing short reads after adapter/quality trimming.

---

## Duplication

The reports also showed duplication values.

High duplication is common in SARS-CoV-2 amplicon sequencing because the sequencing targets specific viral regions. This means many reads can look similar or repeated.

Therefore, duplication should not automatically be considered a failure in this project.

---

## Interpretation

The trimming step was successful.

The data after trimming still had:

* high read quality
* high Q30 values
* consistent GC content
* most reads retained
* adapter sequences handled
* low-quality and too-short reads removed

This means the cleaned reads were suitable for the next phase: mapping to the SARS-CoV-2 reference genome.

---

## Results produced from this phase

The main results of Phase 3 were:

1. fastp HTML reports for each sample.

2. fastp JSON reports for each sample.

3. A MultiQC report summarizing the trimming results.

4. Post-trimming quality-control data files.

5. Cleaned reads ready for mapping.

---

## Phase 3 folder structure

The fastp result folder was:

```text
results/fastp/
├── ERR11029820_fastp.html
├── ERR11029820_fastp.json
├── ERR11029826_fastp.html
├── ERR11029826_fastp.json
├── ERR11029834_fastp.html
├── ERR11029834_fastp.json
├── ERR11029837_fastp.html
├── ERR11029837_fastp.json
├── ERR11029838_fastp.html
├── ERR11029838_fastp.json
├── ERR11029840_fastp.html
└── ERR11029840_fastp.json
```

The MultiQC result folder was:

```text
results/multiqc/trimmed/
├── multiqc_trimmed_report.html
└── multiqc_trimmed_report_data/
    ├── multiqc_fastp.txt
    ├── multiqc_fastqc.txt
    ├── multiqc_general_stats.txt
    ├── fastp_filtered_reads_plot.txt
    ├── fastp-seq-quality-plot_Read_1_Before_filtering.txt
    ├── fastp-seq-quality-plot_Read_1_After_filtering.txt
    ├── fastp-seq-quality-plot_Read_2_Before_filtering.txt
    └── fastp-seq-quality-plot_Read_2_After_filtering.txt
```

---

## Conclusion

Phase 3 cleaned the raw SARS-CoV-2 sequencing reads using fastp.

Most reads passed filtering, adapter sequences were trimmed, and the quality of the reads remained high after trimming.

The trimmed reads were suitable for Phase 4, where they were mapped to the SARS-CoV-2 reference genome.
