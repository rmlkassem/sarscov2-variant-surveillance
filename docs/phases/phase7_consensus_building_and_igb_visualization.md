# Phase 7: Consensus Genome Building and IGB Visualization

## Why this phase is important

After variant calling in Phase 6, the next step was to build a consensus genome for each SARS-CoV-2 sample.

A consensus genome represents the reconstructed viral genome sequence for one sample.

This step is important because variant calling gives us a list of differences from the reference genome, but lineage assignment tools such as Nextclade and Pangolin need complete genome sequences as FASTA files.

The main idea is:

```text
Reference genome
+ high-confidence variants
+ masking low-confidence positions
= consensus genome
```

Consensus building is also important because it converts the analysis from variant-level information into full sample-level genome sequences.

---

## What was done

In this phase, the filtered PASS VCF files from Phase 6 were applied to the SARS-CoV-2 reference genome.

Two versions of consensus genomes were generated:

1. Unmasked consensus genomes
2. Masked consensus genomes

The unmasked consensus genomes were created by applying the high-confidence variants directly to the reference genome.

The masked consensus genomes were created by applying the variants and then replacing positions below 10x coverage with `N`.

The masked version is more conservative because uncertain positions are not treated as confident bases.

---

## Tools used

The tools used in this phase were:

```text
bcftools consensus
samtools
minimap2
IGB
```

`bcftools consensus` was used to generate consensus FASTA sequences.

`samtools` was used to index and check BAM files.

`minimap2` was used to align one consensus genome back to the reference genome for visualization.

IGB was used to visually inspect the reference genome, consensus alignment, variants, deletions, and masked regions.

---

## Output folder

The outputs of this phase were stored in:

```text
results/consensus/
```

The folder contained:

```text
aligned_to_reference/
all_samples.consensus.masked_below10x.fasta
all_samples.consensus.unmasked.fasta
masked_below10x/
masks/
qc/
unmasked/
```

---

## Unmasked consensus genomes

The unmasked consensus genomes were stored in:

```text
results/consensus/unmasked/
```

This folder contained:

```text
ERR11029820.consensus.unmasked.fasta
ERR11029826.consensus.unmasked.fasta
ERR11029834.consensus.unmasked.fasta
ERR11029837.consensus.unmasked.fasta
ERR11029838.consensus.unmasked.fasta
ERR11029840.consensus.unmasked.fasta
```

These files represent the reference genome after applying the PASS variants from Phase 6.

The unmasked consensus genomes had no `N` bases.

From the QC summary:

```text
sample        version      sequence_length    N_count    N_percent
ERR11029820   unmasked     29850              0          0.0000
ERR11029826   unmasked     29844              0          0.0000
ERR11029834   unmasked     29850              0          0.0000
ERR11029837   unmasked     29850              0          0.0000
ERR11029838   unmasked     29850              0          0.0000
ERR11029840   unmasked     29850              0          0.0000
```

This means that all unmasked consensus sequences were complete sequences without masked bases.

---

## Masked consensus genomes

The masked consensus genomes were stored in:

```text
results/consensus/masked_below10x/
```

This folder contained:

```text
ERR11029820.consensus.masked_below10x.fasta
ERR11029826.consensus.masked_below10x.fasta
ERR11029834.consensus.masked_below10x.fasta
ERR11029837.consensus.masked_below10x.fasta
ERR11029838.consensus.masked_below10x.fasta
ERR11029840.consensus.masked_below10x.fasta
```

In these files, positions with coverage below 10x were replaced with `N`.

The masked consensus sequences are safer for downstream interpretation because low-confidence positions are not reported as confident bases.

From the QC summary:

```text
sample        version            sequence_length    N_count    N_percent
ERR11029820   masked_below10x    29894              108        0.3613
ERR11029826   masked_below10x    29894              137        0.4583
ERR11029834   masked_below10x    29894              97         0.3245
ERR11029837   masked_below10x    29894              216        0.7226
ERR11029838   masked_below10x    29894              174        0.5821
ERR11029840   masked_below10x    29894              184        0.6155
```

All masked consensus genomes had less than 1% `N` bases.

ERR11029837 had the highest number of masked bases:

```text
ERR11029837: 216 N bases
```

This matches the earlier coverage analysis, where ERR11029837 had the lowest 10x genome coverage among the samples.

---

## Combined multi-FASTA files

Two combined FASTA files were created:

```text
results/consensus/all_samples.consensus.unmasked.fasta
results/consensus/all_samples.consensus.masked_below10x.fasta
```

Both files contained all six samples:

```text
>ERR11029820
>ERR11029826
>ERR11029834
>ERR11029837
>ERR11029838
>ERR11029840
```

The combined masked consensus FASTA was used later for lineage assignment with Nextclade and Pangolin.

---

## Mask BED files

The BED mask files were stored in:

```text
results/consensus/masks/
```

The folder contained:

```text
ERR11029820.below10x.bed
ERR11029826.below10x.bed
ERR11029834.below10x.bed
ERR11029837.below10x.bed
ERR11029838.below10x.bed
ERR11029840.below10x.bed
```

These BED files were created from the below-10x coverage positions identified in Phase 5.

For example, part of the ERR11029837 BED file was:

```text
NC_045512.2     0       1
NC_045512.2     1       2
NC_045512.2     2       3
NC_045512.2     3       4
NC_045512.2     4       5
NC_045512.2     5       6
NC_045512.2     6       7
NC_045512.2     7       8
NC_045512.2     21634   21635
NC_045512.2     21635   21636
```

This means that these positions were below 10x coverage and were masked as `N` in the masked consensus sequence.

BED format uses zero-based coordinates, which is why the first genome position is represented as `0-1`.

---

## Masked positions summary

The number of positions masked in each sample was summarized in:

```text
results/consensus/qc/masked_positions_summary.tsv
```

The result was:

```text
sample        below10x_positions
ERR11029820   108
ERR11029826   137
ERR11029834   97
ERR11029837   216
ERR11029838   174
ERR11029840   184
```

This table shows how many below-10x positions were masked as `N` in each sample.

The sample with the lowest number of masked positions was:

```text
ERR11029834: 97 positions
```

The sample with the highest number of masked positions was:

```text
ERR11029837: 216 positions
```

---

## Example masked consensus sequence

An example from ERR11029837 was:

```text
>ERR11029837
NNNNNNNNTTTATACCTTCCCAGGTAACAAACCAACCAACTTTCGATCTCTTGTAGATCT
GTTCTCTAAACGAACTTTAAAATCTGTGTGGCTGTCACTCGGCTCCATGCTTAGTGCACT
CACGCAGTATAATTAATAACTAATTACTGTCGTTGACAGGACACGAGTAACTCGTCTATC
TTCTGCAGGCTGCTTACGGTTTCGTCCGTGTTGCAGCCGATCATCAGCACATCTAGGTTT
```

The sequence starts with several `N` bases.

This means that the beginning of the genome had low coverage and was masked.

This is expected because genome ends often have weaker coverage.

---

## Consensus QC interpretation

The consensus QC showed that the unmasked consensus files had no `N` bases.

The masked consensus files had some `N` bases because below-10x positions were intentionally masked.

The `N_percent` values were all below 1%, which means that the consensus genomes were mostly complete and suitable for lineage assignment.

The masked consensus genomes were preferred for downstream lineage analysis because they avoid overconfidence in low-coverage positions.

---

## Consensus alignment for IGB visualization

One consensus genome, ERR11029837, was aligned back to the SARS-CoV-2 reference genome for visualization in IGB.

The output files were stored in:

```text
results/consensus/aligned_to_reference/
```

The folder contained:

```text
ERR11029837.consensus_vs_reference.bam
ERR11029837.consensus_vs_reference.bam.bai
```

The `samtools flagstat` result showed:

```text
1 + 0 in total
1 + 0 primary
1 + 0 mapped (100.00%)
1 + 0 primary mapped (100.00%)
```

This means that the consensus sequence aligned successfully back to the reference genome.

This alignment was not a raw read alignment. It represented the consensus genome sequence aligned to the reference coordinate system.

---

## IGB visualization

IGB was used to visually inspect the results.

The visualization helped compare:

* the SARS-CoV-2 reference genome
* the consensus genome aligned to the reference
* variant and deletion regions
* masked positions
* original read alignments

This visual inspection helped confirm that the computational outputs made sense.

For example, the masked consensus showed `N` bases at low-coverage positions, and deletion regions could be compared with the VCF/BED tracks.

IGB therefore served as a visual validation step after consensus building.

---

## Results produced from this phase

The main results of Phase 7 were:

1. Individual unmasked consensus FASTA files.

2. Individual masked consensus FASTA files.

3. Combined unmasked multi-FASTA file.

4. Combined masked multi-FASTA file.

5. BED mask files for below-10x positions.

6. Consensus QC summary.

7. Masked positions summary.

8. Consensus-to-reference BAM alignment for IGB visualization.

9. Visual confirmation of consensus and masked regions in IGB.

---

## Phase 7 folder structure

The Phase 7 output folder was:

```text
results/consensus/
├── aligned_to_reference
│   ├── ERR11029837.consensus_vs_reference.bam
│   └── ERR11029837.consensus_vs_reference.bam.bai
├── all_samples.consensus.masked_below10x.fasta
├── all_samples.consensus.unmasked.fasta
├── masked_below10x
│   ├── ERR11029820.consensus.masked_below10x.fasta
│   ├── ERR11029826.consensus.masked_below10x.fasta
│   ├── ERR11029834.consensus.masked_below10x.fasta
│   ├── ERR11029837.consensus.masked_below10x.fasta
│   ├── ERR11029838.consensus.masked_below10x.fasta
│   └── ERR11029840.consensus.masked_below10x.fasta
├── masks
│   ├── ERR11029820.below10x.bed
│   ├── ERR11029826.below10x.bed
│   ├── ERR11029834.below10x.bed
│   ├── ERR11029837.below10x.bed
│   ├── ERR11029838.below10x.bed
│   └── ERR11029840.below10x.bed
├── qc
│   ├── consensus_qc_summary.tsv
│   └── masked_positions_summary.tsv
└── unmasked
    ├── ERR11029820.consensus.unmasked.fasta
    ├── ERR11029826.consensus.unmasked.fasta
    ├── ERR11029834.consensus.unmasked.fasta
    ├── ERR11029837.consensus.unmasked.fasta
    ├── ERR11029838.consensus.unmasked.fasta
    └── ERR11029840.consensus.unmasked.fasta
```

---

## Conclusion

Phase 7 successfully generated consensus SARS-CoV-2 genomes for all six samples.

Both unmasked and masked consensus genomes were produced. The masked consensus genomes replaced below-10x positions with `N`, making them more conservative for downstream analysis.

Consensus QC showed that all masked genomes had low percentages of `N` bases, below 1%.

The combined masked consensus FASTA file was ready for lineage assignment in Phase 8.

IGB visualization was also used to inspect and confirm the consensus alignment, masked regions, and variant/deletion patterns.
