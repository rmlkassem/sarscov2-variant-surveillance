# Phase 5: Coverage and Low-Coverage Analysis

## Why this phase is important

After mapping the trimmed reads to the SARS-CoV-2 reference genome in Phase 4, the next step was to check genome coverage.

Coverage means how many reads support each position of the reference genome.

This phase is important because variant calling and consensus genome building depend on read depth. A genome position covered by many reads is more reliable than a position covered by only a few reads.

For example:

```text
High coverage = more confidence
Low coverage = less confidence
Zero coverage = no read support
```

If a mutation is found in a low-coverage region, it should be interpreted carefully.

Coverage analysis helps answer:

```text
Which parts of the viral genome are well supported?
Which regions have weak or missing read support?
Which positions should be masked later as N in the consensus genome?
```

---

## What was done

Coverage was calculated for each sorted BAM file generated in Phase 4.

For each sample, depth was measured across the SARS-CoV-2 reference genome.

The analysis produced:

* per-position depth files
* per-sample coverage summary files
* one combined coverage summary table
* files listing positions below 10x coverage
* files listing positions with zero coverage

The 10x threshold was used as a practical cutoff to identify positions with weak read support.

---

## Tools used

The tools used in this phase were:

```text
samtools
awk / shell commands
```

`samtools depth` was used to calculate read depth across the reference genome.

Text-processing commands were then used to summarize coverage and extract low-coverage positions.

---

## Output folder

The outputs of this phase were stored in:

```text
results/coverage_len50/
```

The folder contained:

```text
ERR11029820.coverage_summary.txt
ERR11029820.depth.txt
ERR11029826.coverage_summary.txt
ERR11029826.depth.txt
ERR11029834.coverage_summary.txt
ERR11029834.depth.txt
ERR11029837.coverage_summary.txt
ERR11029837.depth.txt
ERR11029838.coverage_summary.txt
ERR11029838.depth.txt
ERR11029840.coverage_summary.txt
ERR11029840.depth.txt
coverage_summary_len50.tsv
low_coverage_positions/
```

---

## Depth files

Each sample had a depth file, for example:

```text
ERR11029820.depth.txt
ERR11029837.depth.txt
```

A depth file records the coverage at each reference genome position.

A typical line means:

```text
reference_name    position    depth
```

For example:

```text
NC_045512.2    1000    2000
```

This would mean that position 1000 of the reference genome was covered by 2000 reads.

These depth files are useful for detailed inspection of coverage across the genome.

---

## Coverage summary files

Each sample also had a coverage summary file, for example:

```text
ERR11029820.coverage_summary.txt
ERR11029837.coverage_summary.txt
```

These files summarize the overall coverage of each sample.

The combined summary table was:

```text
coverage_summary_len50.tsv
```

This file is the main result of Phase 5.

---

## Main coverage results

The combined coverage summary was:

```text
sample        mean_depth    covered_gt0_percent    covered_10x_percent
ERR11029820   2082.21      99.8729                99.6388
ERR11029826   2291.55      99.6489                99.5419
ERR11029834   1986.33      99.8763                99.6756
ERR11029837   2156.95      99.6957                99.2777
ERR11029838   2277.64      99.6723                99.4181
ERR11029840   1812.85      99.8027                99.3847
```

---

## Interpretation of mean depth

Mean depth shows the average number of reads covering the genome.

The mean depth ranged from:

```text
1812.85x to 2291.55x
```

This is very high coverage.

The sample with the highest mean depth was:

```text
ERR11029826: 2291.55x
```

The sample with the lowest mean depth was:

```text
ERR11029840: 1812.85x
```

Even the lowest mean depth was still very high, meaning that all samples had strong sequencing support.

---

## Interpretation of covered_gt0_percent

The `covered_gt0_percent` column shows the percentage of the genome covered by at least one read.

All samples had more than:

```text
99.6% covered by at least one read
```

This means that nearly the entire SARS-CoV-2 genome had read support in every sample.

The highest value was:

```text
ERR11029834: 99.8763%
```

The lowest value was:

```text
ERR11029826: 99.6489%
```

Both values are still very high.

---

## Interpretation of covered_10x_percent

The `covered_10x_percent` column shows the percentage of the genome covered by at least 10 reads.

This is important because 10x coverage gives more confidence than only one or two reads.

All samples had more than:

```text
99.2% of the genome covered at 10x
```

The highest 10x coverage was:

```text
ERR11029834: 99.6756%
```

The lowest 10x coverage was:

```text
ERR11029837: 99.2777%
```

ERR11029837 had the lowest 10x coverage among the six samples, but it still had more than 99% of the genome covered at 10x.

This means the sample was still suitable for downstream analysis.

---

## Low-coverage and zero-coverage positions

The folder:

```text
low_coverage_positions/
```

contained files for each sample:

```text
ERR11029820.below10x.txt
ERR11029820.zero_coverage.txt
ERR11029826.below10x.txt
ERR11029826.zero_coverage.txt
ERR11029834.below10x.txt
ERR11029834.zero_coverage.txt
ERR11029837.below10x.txt
ERR11029837.zero_coverage.txt
ERR11029838.below10x.txt
ERR11029838.zero_coverage.txt
ERR11029840.below10x.txt
ERR11029840.zero_coverage.txt
```

The `.below10x.txt` files list positions with coverage below 10x.

The `.zero_coverage.txt` files list positions with no read coverage.

These files are important for later phases because low-confidence positions can be masked as `N` during consensus genome generation.

---

## Why low-coverage files are important

Low-coverage positions are not ignored. They are recorded so that later analysis can treat them carefully.

These files were used later for:

```text
checking whether variants overlap weakly covered regions
masking low-confidence positions in the consensus genome
interpreting missing regions reported by Nextclade
```

This makes the workflow more reliable because it avoids treating uncertain positions as high-confidence bases.

---

## Results produced from this phase

The main results of Phase 5 were:

1. Per-position depth files for each sample.

2. Per-sample coverage summary files.

3. A combined coverage summary table.

4. Below-10x position files for each sample.

5. Zero-coverage position files for each sample.

6. Confirmation that all six samples had strong genome coverage.

---

## Phase 5 folder structure

The Phase 5 output folder was:

```text
results/coverage_len50/
├── ERR11029820.coverage_summary.txt
├── ERR11029820.depth.txt
├── ERR11029826.coverage_summary.txt
├── ERR11029826.depth.txt
├── ERR11029834.coverage_summary.txt
├── ERR11029834.depth.txt
├── ERR11029837.coverage_summary.txt
├── ERR11029837.depth.txt
├── ERR11029838.coverage_summary.txt
├── ERR11029838.depth.txt
├── ERR11029840.coverage_summary.txt
├── ERR11029840.depth.txt
├── coverage_summary_len50.tsv
└── low_coverage_positions
    ├── ERR11029820.below10x.txt
    ├── ERR11029820.zero_coverage.txt
    ├── ERR11029826.below10x.txt
    ├── ERR11029826.zero_coverage.txt
    ├── ERR11029834.below10x.txt
    ├── ERR11029834.zero_coverage.txt
    ├── ERR11029837.below10x.txt
    ├── ERR11029837.zero_coverage.txt
    ├── ERR11029838.below10x.txt
    ├── ERR11029838.zero_coverage.txt
    ├── ERR11029840.below10x.txt
    └── ERR11029840.zero_coverage.txt
```

---

## Conclusion

Phase 5 showed that all six SARS-CoV-2 samples had excellent genome coverage.

The mean depth was very high for all samples, and more than 99% of the genome was covered at 10x depth in every sample.

Low-coverage and zero-coverage positions were identified and saved for later use.

These results confirmed that the samples were suitable for Phase 6, where variants were called using bcftools.
