# Phase 6: Variant Calling Using bcftools

## Why this phase is important

After mapping and coverage analysis, the next step was to identify the genetic differences between each SARS-CoV-2 sample and the reference genome.

This process is called variant calling.

Variant calling is important because it tells us which positions in the viral genome are different from the reference sequence.

These differences can include:

* single nucleotide variants
* insertions
* deletions

In this project, variant calling was needed before building consensus genomes and assigning lineages.

Without variant calling, we would only know where the reads mapped, but we would not know how each sample differs from the SARS-CoV-2 reference genome.

---

## What was done

Variants were called from the sorted BAM files generated in Phase 4.

The workflow included several steps:

1. Raw variant calling
2. Variant normalization
3. Variant filtering
4. Variant summary generation
5. Deletion summary generation
6. Checking whether PASS variants overlapped low-coverage or zero-coverage regions

The main goal was to produce high-confidence variant files for each sample.

---

## Tools used

The main tool used in this phase was:

```text
bcftools
```

Several bcftools commands were used:

```text
bcftools mpileup
bcftools call
bcftools norm
bcftools view
bcftools query
bcftools stats
```

Other command-line tools such as `awk`, `grep`, and `wc` were used to summarize and inspect the results.

---

## Output folder

The outputs of this phase were stored in:

```text
results/vcf/
```

This folder contained:

```text
raw_vcf/
norm_vcf/
pass_vcf/
stats/
tables/
lowcov_variant_check/
```

Each folder had a specific purpose.

---

## Raw VCF files

The raw VCF files were stored in:

```text
results/vcf/raw_vcf/
```

These files contain the first variant calls produced by bcftools.

Example files:

```text
ERR11029820.raw.vcf.gz
ERR11029826.raw.vcf.gz
ERR11029834.raw.vcf.gz
ERR11029837.raw.vcf.gz
ERR11029838.raw.vcf.gz
ERR11029840.raw.vcf.gz
```

Each `.vcf.gz` file also had a `.tbi` index file.

The raw VCF files are useful as the first output of variant calling, but they are not the final files used for interpretation.

---

## Normalized VCF files

The normalized VCF files were stored in:

```text
results/vcf/norm_vcf/
```

Normalization was done to clean and standardize the representation of variants, especially insertions and deletions.

Example files:

```text
ERR11029820.norm.vcf.gz
ERR11029826.norm.vcf.gz
ERR11029834.norm.vcf.gz
ERR11029837.norm.vcf.gz
ERR11029838.norm.vcf.gz
ERR11029840.norm.vcf.gz
```

Normalization is important because the same deletion or insertion can sometimes be represented in different ways. Normalizing the VCF makes the variant representation more consistent.

---

## Filtered PASS VCF files

The filtered high-confidence VCF files were stored in:

```text
results/vcf/pass_vcf/
```

These files are the main variant files from Phase 6.

Example files:

```text
ERR11029820.pass.vcf.gz
ERR11029826.pass.vcf.gz
ERR11029834.pass.vcf.gz
ERR11029837.pass.vcf.gz
ERR11029838.pass.vcf.gz
ERR11029840.pass.vcf.gz
```

These VCF files contain variants that passed the filtering criteria.

They were used later for consensus genome generation.

---

## Variant summary

A summary table was generated:

```text
results/vcf/tables/variant_summary.tsv
```

The result was:

```text
sample        total_variants    snps    indels
ERR11029820   101               97      4
ERR11029826   89                84      5
ERR11029834   100               96      4
ERR11029837   102               98      4
ERR11029838   99                95      4
ERR11029840   99                95      4
```

This table shows that all samples had many single nucleotide variants and a small number of indels.

The sample with the highest number of total variants was:

```text
ERR11029837: 102 variants
```

The sample with the lowest number of total variants was:

```text
ERR11029826: 89 variants
```

Most variants were SNPs.

---

## Readable variant tables

Readable TSV files were created for each sample:

```text
results/vcf/tables/ERR11029820.variants.tsv
results/vcf/tables/ERR11029826.variants.tsv
results/vcf/tables/ERR11029834.variants.tsv
results/vcf/tables/ERR11029837.variants.tsv
results/vcf/tables/ERR11029838.variants.tsv
results/vcf/tables/ERR11029840.variants.tsv
```

These files make the VCF results easier to read.

Each table contains columns such as:

```text
CHROM
POS
REF
ALT
QUAL
DP
```

For example, part of the ERR11029837 variant table showed:

```text
CHROM         POS     REF    ALT    QUAL       DP
NC_045512.2   105     G      C      225.417    257
NC_045512.2   241     C      T      225.417    253
NC_045512.2   405     A      G      225.417    250
NC_045512.2   670     T      G      225.417    174
NC_045512.2   1890    G      A      225.417    247
```

This means that each listed position differs from the reference genome.

For example:

```text
G105C
```

means that the reference has `G` at position 105, while the sample has `C`.

---

## bcftools statistics

Detailed bcftools statistics were stored in:

```text
results/vcf/stats/
```

The folder contained:

```text
ERR11029820.bcftools_stats.txt
ERR11029826.bcftools_stats.txt
ERR11029834.bcftools_stats.txt
ERR11029837.bcftools_stats.txt
ERR11029838.bcftools_stats.txt
ERR11029840.bcftools_stats.txt
```

These files provide technical statistics about the VCF files, such as the number of records, SNPs, indels, and other variant-level information.

---

## Deletion summary

A deletion summary table was created:

```text
results/vcf/tables/deletion_summary.tsv
```

This file was important because deletions in VCF format can be confusing.

The deletion summary translated the VCF deletion records into clearer deletion intervals.

For most samples, the following deletion intervals were detected:

```text
11288-11296
21633-21641
28362-28370
29734-29759
```

For sample ERR11029826, one extra deletion was detected:

```text
21765-21770
```

This explains why ERR11029826 had five indels, while most other samples had four.

---

## Why deletion interpretation was important

In VCF format, deletions are represented using an anchor base.

For example:

```text
VCF position: 21632
REF: TTACCCCCTG
ALT: T
```

This means the first base is kept as an anchor, and the deleted region is:

```text
21633-21641
```

So the VCF position is not always the full deleted interval. The deletion summary file made this clearer.

---

## Low-coverage variant check

Because Phase 5 identified low-coverage and zero-coverage positions, the PASS variants were checked against those regions.

The first check counted variants overlapping below-10x regions:

```text
sample        pass_variants_in_below10x
ERR11029820   3
ERR11029826   4
ERR11029834   3
ERR11029837   3
ERR11029838   3
ERR11029840   3
```

A similar result was found for zero-coverage regions:

```text
sample        pass_variants_in_zero_coverage
ERR11029820   3
ERR11029826   4
ERR11029834   3
ERR11029837   3
ERR11029838   3
ERR11029840   3
```

At first, this looked suspicious because a variant should not normally be called at a position with zero coverage.

However, further inspection showed that these were deletion records overlapping zero-coverage regions, not false SNPs called at unsupported positions.

---

## Exact zero-coverage check

To confirm this, an exact-position check was performed.

This check asked:

```text
Does any PASS variant start exactly at a zero-coverage position?
```

The result was:

```text
sample        exact_pass_variants_at_zero_coverage_positions
ERR11029820   0
ERR11029826   0
ERR11029834   0
ERR11029837   0
ERR11029838   0
ERR11029840   0
```

This is an important result.

It means that no high-confidence variant started exactly at a zero-coverage position.

Therefore, the apparent overlap with zero coverage was explained by deletion intervals, not by unsupported variant calls.

---

## Interpretation

Variant calling was successful.

The samples had between 89 and 102 total variants.

Most variants were SNPs.

Each sample had several deletion events, and ERR11029826 had one extra deletion compared with the other samples.

The low-coverage overlap check showed that some PASS variants overlapped low-coverage or zero-coverage regions. However, the exact-position check confirmed that no PASS variant started exactly at a zero-coverage position.

This means the filtered variants were reliable enough to use in the next phase.

---

## Results produced from this phase

The main results of Phase 6 were:

1. Raw VCF files for each sample.

2. Normalized VCF files for each sample.

3. Filtered PASS VCF files for each sample.

4. VCF index files.

5. bcftools statistics reports.

6. Readable variant tables.

7. A variant summary table.

8. A deletion summary table.

9. Low-coverage overlap checks.

10. Exact zero-coverage checks.

---

## Phase 6 folder structure

The Phase 6 output folder was:

```text
results/vcf/
├── lowcov_variant_check/
├── norm_vcf/
├── pass_vcf/
├── raw_vcf/
├── stats/
└── tables/
```

The most important files for interpretation were:

```text
results/vcf/pass_vcf/*.pass.vcf.gz
results/vcf/tables/variant_summary.tsv
results/vcf/tables/deletion_summary.tsv
results/vcf/tables/*.variants.tsv
results/vcf/lowcov_variant_check/exact_position_check/exact_zero_coverage_summary.tsv
```

---

## Conclusion

Phase 6 identified high-confidence variants for all six SARS-CoV-2 samples using bcftools.

The variant summary showed that the samples contained mostly SNPs, with a small number of indels.

Deletion analysis showed repeated deletion events across the samples, with ERR11029826 having one additional deletion.

Quality checking against low-coverage regions showed that no PASS variant started exactly at a zero-coverage position. Therefore, the variant calls were considered suitable for consensus genome generation.

The project was ready to move into Phase 7, where the filtered variants were used to build consensus SARS-CoV-2 genomes.
