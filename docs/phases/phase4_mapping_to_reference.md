# Phase 4: Mapping Trimmed Reads to the SARS-CoV-2 Reference Genome

## Why this phase is important

After trimming and cleaning the reads in Phase 3, the next step was to map the reads to the SARS-CoV-2 reference genome.

Mapping is important because sequencing reads are short fragments. To understand where these reads come from, they must be aligned to a known reference genome.

In this project, the reads were mapped to the SARS-CoV-2 reference genome:

```text
NC_045512.2
```

This step is needed before coverage analysis and variant calling.

Without mapping, we cannot know:

* where each read aligns on the viral genome
* which genome positions are covered
* which positions differ from the reference
* whether the paired-end reads behave correctly
* whether the data are suitable for variant calling

---

## What was done

The trimmed paired-end reads from Phase 3 were aligned to the SARS-CoV-2 reference genome.

After mapping, the alignment files were sorted and indexed.

The final alignment files were stored as sorted BAM files.

Each sample produced:

* one sorted BAM file
* one BAM index file

The BAM file contains the mapped sequencing reads.

The BAI file is the index file that allows tools to access the BAM file quickly.

---

## Tools used

The tools used in this phase were:

```text
BWA
samtools
```

BWA was used to align the trimmed reads to the SARS-CoV-2 reference genome.

samtools was used to process the alignment files, including sorting, indexing, and generating mapping statistics.

---

## BAM output files

The mapped and sorted BAM files were stored in:

```text
results/bam_len50/
```

The folder contained:

```text
ERR11029820.len50.sorted.bam
ERR11029820.len50.sorted.bam.bai
ERR11029826.len50.sorted.bam
ERR11029826.len50.sorted.bam.bai
ERR11029834.len50.sorted.bam
ERR11029834.len50.sorted.bam.bai
ERR11029837.len50.sorted.bam
ERR11029837.len50.sorted.bam.bai
ERR11029838.len50.sorted.bam
ERR11029838.len50.sorted.bam.bai
ERR11029840.len50.sorted.bam
ERR11029840.len50.sorted.bam.bai
```

The `.bam` files are the sorted read alignment files.

The `.bai` files are the BAM index files.

These files are important because they are used in later phases for:

* coverage analysis
* low-coverage detection
* variant calling
* visual inspection in IGB

---

## Mapping statistics output files

Mapping statistics were stored in:

```text
results/mapping_stats_len50/
```

The folder contained:

```text
ERR11029820.flagstat.txt
ERR11029826.flagstat.txt
ERR11029834.flagstat.txt
ERR11029837.flagstat.txt
ERR11029838.flagstat.txt
ERR11029840.flagstat.txt
mapping_summary_len50.tsv
```

Each `.flagstat.txt` file contains detailed mapping statistics for one sample.

The file:

```text
mapping_summary_len50.tsv
```

summarizes the most important mapping statistics for all samples.

---

## Mapping summary results

The mapping summary was:

```text
sample        mapped_percent    properly_paired_percent
ERR11029820   100.00            99.89
ERR11029826   100.00            99.93
ERR11029834   100.00            99.88
ERR11029837   100.00            99.92
ERR11029838   100.00            99.94
ERR11029840   100.00            99.92
```

All six samples had:

```text
100.00% mapped reads
```

This means that almost all reads successfully aligned to the SARS-CoV-2 reference genome.

The properly paired percentage ranged from:

```text
99.88% to 99.94%
```

This means that the paired-end reads aligned in the expected orientation and distance.

---

## Example flagstat result

For sample `ERR11029820`, the flagstat result showed:

```text
570928 + 0 in total
570670 + 0 primary
258 + 0 supplementary
570918 + 0 mapped (100.00%)
570660 + 0 primary mapped (100.00%)
570670 + 0 paired in sequencing
285335 + 0 read1
285335 + 0 read2
570014 + 0 properly paired (99.89%)
0 + 0 singletons (0.00%)
```

This means that the sample had excellent mapping performance.

Almost all reads mapped to the reference genome, and almost all paired reads were properly paired.

There were no singletons, meaning there were no cases where only one read from a pair mapped while the other did not.

---

## Interpretation

The mapping results were very strong.

All samples showed 100% mapped reads, which indicates that the trimmed reads matched the SARS-CoV-2 reference genome very well.

The properly paired percentage was also very high for all samples, around 99.9%.

This suggests that:

* the trimming step produced good reads
* the reference genome was appropriate
* the samples were suitable for downstream analysis
* the BAM files were reliable enough for coverage analysis and variant calling

---

## Results produced from this phase

The main results of Phase 4 were:

1. Sorted BAM files for all six samples.

2. BAM index files for all six samples.

3. Individual flagstat mapping reports for each sample.

4. A combined mapping summary table.

5. Confirmation that all samples had excellent mapping performance.

---

## Phase 4 folder structure

The BAM output folder was:

```text
results/bam_len50/
├── ERR11029820.len50.sorted.bam
├── ERR11029820.len50.sorted.bam.bai
├── ERR11029826.len50.sorted.bam
├── ERR11029826.len50.sorted.bam.bai
├── ERR11029834.len50.sorted.bam
├── ERR11029834.len50.sorted.bam.bai
├── ERR11029837.len50.sorted.bam
├── ERR11029837.len50.sorted.bam.bai
├── ERR11029838.len50.sorted.bam
├── ERR11029838.len50.sorted.bam.bai
├── ERR11029840.len50.sorted.bam
└── ERR11029840.len50.sorted.bam.bai
```

The mapping statistics folder was:

```text
results/mapping_stats_len50/
├── ERR11029820.flagstat.txt
├── ERR11029826.flagstat.txt
├── ERR11029834.flagstat.txt
├── ERR11029837.flagstat.txt
├── ERR11029838.flagstat.txt
├── ERR11029840.flagstat.txt
└── mapping_summary_len50.tsv
```

---

## Conclusion

Phase 4 successfully mapped the trimmed SARS-CoV-2 reads to the reference genome `NC_045512.2`.

All six samples showed 100% mapped reads and approximately 99.9% properly paired reads.

These results indicate that the mapping step was successful and that the sorted BAM files were suitable for the next phase: coverage and low-coverage analysis.
