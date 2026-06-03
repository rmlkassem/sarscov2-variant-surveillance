# Phase 8: Lineage Assignment and Consensus Quality Assessment

## Why this phase is important

After building the consensus genomes in Phase 7, the next step was to identify which SARS-CoV-2 lineage each sample belongs to.

This phase is important because a consensus genome alone is only a sequence. To understand it biologically, we need to classify it.

Lineage assignment helps answer questions such as:

* What SARS-CoV-2 lineage does each sample belong to?
* Are the samples from the same variant group or different groups?
* Are the consensus genomes good enough for interpretation?
* What mutations are present in each sample?
* Do different tools agree on the lineage results?

This phase turns the consensus sequences into biological information.

---

## What was done

The masked consensus genomes from Phase 7 were analyzed using two tools:

```text
Nextclade
Pangolin
```

The input file was the combined masked consensus FASTA file:

```text
results/consensus/all_samples.consensus.masked_below10x.fasta
```

The masked consensus was used because positions below 10x coverage were replaced with `N`. This makes the analysis more careful because low-confidence positions are not treated as certain bases.

---

## Tools used

The tools used in this phase were:

```text
Nextclade
Pangolin
```

Nextclade was used to:

* assign Nextclade clades
* predict Pango lineages
* check genome quality
* report nucleotide mutations
* report amino-acid mutations
* report missing regions

Pangolin was used to:

* assign Pango lineages independently
* provide lineage placement notes
* provide Scorpio calls for broader variant groups

Using both tools was useful because it allowed comparison between two lineage-assignment methods.

---

## Output folders

The Phase 8 outputs were stored in three folders:

```text
results/lineage_nextclade/
results/lineage_pangolin/
results/lineage_summary/
```

The folder structure was:

```text
lineage_nextclade
├── lineage_simple_summary.tsv
├── mutation_count_summary.tsv
├── mutation_summary.tsv
├── nextclade_aligned.fasta
├── nextclade_results.csv
├── nextclade_results.json
├── nextclade_results.tsv
└── nextclade_summary.tsv

lineage_pangolin
├── pangolin_lineage_report.csv
└── pangolin_summary.tsv

lineage_summary
└── nextclade_vs_pangolin.tsv
```

---

## Nextclade results

The main Nextclade summary file was:

```text
results/lineage_nextclade/lineage_simple_summary.tsv
```

The result was:

```text
sample        clade    Nextclade_pango    QC      substitutions    deletions    missing
ERR11029820   23A      XBB.1.5.5          good    96               9            108
ERR11029826   22E      EZ.1               good    82               9            137
ERR11029837   23A      XBB.1.5            good    96               9            216
ERR11029838   23A      XBB.1.5            good    93               9            174
ERR11029840   23A      XBB.1.5            good    93               9            184
ERR11029834   22D      BN.1.5             good    96               9            97
```

This means that Nextclade successfully assigned a clade and lineage to all six samples.

All samples had:

```text
QC status = good
```

This means that Nextclade considered all consensus genomes good enough for lineage-level interpretation.

---

## Meaning of clade and lineage

The `clade` column gives a broad evolutionary group.

The `Nextclade_pango` column gives a more specific Pango lineage.

For example:

```text
ERR11029837
clade: 23A
lineage: XBB.1.5
```

This means that ERR11029837 belongs to the broader Nextclade clade 23A and more specifically to the Pango lineage XBB.1.5.

In simple terms:

```text
clade = broader group
lineage = more specific group
```

---

## Nextclade lineage assignments

The Nextclade lineage assignments were:

```text
ERR11029820 → XBB.1.5.5
ERR11029826 → EZ.1
ERR11029834 → BN.1.5
ERR11029837 → XBB.1.5
ERR11029838 → XBB.1.5
ERR11029840 → XBB.1.5
```

Most samples were XBB-related.

Three samples were assigned to:

```text
XBB.1.5
```

One sample was assigned to:

```text
XBB.1.5.5
```

Two samples belonged to different Omicron sublineages:

```text
ERR11029826 → EZ.1
ERR11029834 → BN.1.5
```

---

## Nextclade mutation counts

The mutation count summary was stored in:

```text
results/lineage_nextclade/mutation_count_summary.tsv
```

The result was:

```text
sample        nucleotide_substitutions    nucleotide_deletions    insertions    aa_substitutions    aa_deletions    missing_regions
ERR11029820   96                          1                       0             68                  3               5
ERR11029826   82                          1                       0             61                  3               6
ERR11029837   96                          1                       0             66                  3               9
ERR11029838   93                          1                       0             65                  3               7
ERR11029840   93                          1                       0             66                  3               8
ERR11029834   96                          1                       0             68                  3               6
```

This table shows that all samples had:

```text
1 nucleotide deletion event
0 insertions
3 amino-acid deletions
```

The amino-acid deletions were:

```text
ORF1a:S3675-
ORF1a:G3676-
ORF1a:F3677-
```

This means that three amino acids were deleted in ORF1a.

---

## Difference between deletion event and deleted bases

There is an important difference between these two results:

```text
nucleotide_deletion_count = 1
totalDeletions = 9
```

The value `1` means there was one deletion event.

The value `9` means that this deletion event removed 9 nucleotide bases.

So one deletion event can remove several bases.

This explains why the mutation count summary says one deletion event, while the Nextclade summary reports nine deleted bases.

---

## Missing regions

Nextclade also reported missing bases.

Missing bases are usually positions that were masked as `N` in the consensus genome because they had low coverage.

The total missing bases were:

```text
ERR11029820 → 108
ERR11029826 → 137
ERR11029834 → 97
ERR11029837 → 216
ERR11029838 → 174
ERR11029840 → 184
```

ERR11029837 had the highest number of missing bases.

This agrees with Phase 7, where ERR11029837 had the highest number of masked below-10x positions.

Even with these missing bases, all samples still had good QC status.

---

## Pangolin results

Pangolin results were stored in:

```text
results/lineage_pangolin/
```

The main summary file was:

```text
results/lineage_pangolin/pangolin_summary.tsv
```

Pangolin assigned the following lineages:

```text
ERR11029820 → XBB.1.5.5
ERR11029826 → EZ.1
ERR11029834 → BN.1.5
ERR11029837 → XBB.1.5
ERR11029838 → XBB.1.5
ERR11029840 → XBB.1.5
```

Pangolin also provided broader Scorpio calls such as:

```text
Omicron (XBB.1.5-like)
Omicron (BA.5-like)
Omicron (BA.2-like)
Omicron (XBB-like)
```

These labels show that all samples belong to Omicron-related groups.

---

## Nextclade and Pangolin comparison

A comparison file was created:

```text
results/lineage_summary/nextclade_vs_pangolin.tsv
```

This file compared the lineage result from Nextclade with the lineage result from Pangolin.

The result showed:

```text
ERR11029820: Nextclade = XBB.1.5.5, Pangolin = XBB.1.5.5
ERR11029826: Nextclade = EZ.1, Pangolin = EZ.1
ERR11029834: Nextclade = BN.1.5, Pangolin = BN.1.5
ERR11029837: Nextclade = XBB.1.5, Pangolin = XBB.1.5
ERR11029838: Nextclade = XBB.1.5, Pangolin = XBB.1.5
ERR11029840: Nextclade = XBB.1.5, Pangolin = XBB.1.5
```

This means that Nextclade and Pangolin agreed for all six samples.

This agreement makes the lineage results more reliable.

---

## Note about ERR11029837

For sample ERR11029837, Pangolin reported:

```text
Usher placements: XBB.1.5(1/2) XBB.1.5.2(1/2)
```

This means that Pangolin saw possible placement support near both XBB.1.5 and XBB.1.5.2.

However, the final reported Pangolin lineage was:

```text
XBB.1.5
```

Nextclade also assigned:

```text
XBB.1.5
```

So the final interpretation remains XBB.1.5.

---

## Main biological interpretation

All six samples were assigned to Omicron-related lineages.

The samples grouped as follows:

```text
XBB.1.5-related samples:
ERR11029820
ERR11029837
ERR11029838
ERR11029840

EZ.1 sample:
ERR11029826

BN.1.5 sample:
ERR11029834
```

This means the six samples were not all identical.

Most samples belonged to XBB-related lineages, while ERR11029826 and ERR11029834 belonged to different Omicron sublineages.

---

## Results produced from this phase

The main results of Phase 8 were:

1. Nextclade lineage and clade assignments.

2. Nextclade QC status for all samples.

3. Nextclade mutation summaries.

4. Nextclade aligned FASTA output.

5. Pangolin lineage assignments.

6. Pangolin Scorpio calls.

7. A comparison table between Nextclade and Pangolin.

8. Confirmation that both tools agreed on all six lineage assignments.

---

## Phase 8 folder structure

The Phase 8 output structure was:

```text
results/
├── lineage_nextclade
│   ├── lineage_simple_summary.tsv
│   ├── mutation_count_summary.tsv
│   ├── mutation_summary.tsv
│   ├── nextclade_aligned.fasta
│   ├── nextclade_results.csv
│   ├── nextclade_results.json
│   ├── nextclade_results.tsv
│   └── nextclade_summary.tsv
├── lineage_pangolin
│   ├── pangolin_lineage_report.csv
│   └── pangolin_summary.tsv
└── lineage_summary
    └── nextclade_vs_pangolin.tsv
```

---

## Conclusion

Phase 8 successfully assigned SARS-CoV-2 lineages to all six consensus genomes.

Nextclade assigned clades, predicted Pango lineages, reported mutations, and confirmed that all samples had good QC status.

Pangolin independently assigned Pango lineages.

Both tools agreed for all six samples.

The final lineage results were:

```text
ERR11029820 → XBB.1.5.5
ERR11029826 → EZ.1
ERR11029834 → BN.1.5
ERR11029837 → XBB.1.5
ERR11029838 → XBB.1.5
ERR11029840 → XBB.1.5
```

These results showed that all samples were Omicron-related, with most samples belonging to XBB-related lineages.

The project was ready for Phase 9, where the mutation patterns of the different lineages were interpreted.

