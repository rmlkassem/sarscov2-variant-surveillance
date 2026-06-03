# Phase 9: Lineage Interpretation and Mutation Pattern Analysis

## Why this phase is important

After assigning lineages in Phase 8, the next step was to interpret what those lineages mean.

Phase 8 answered:

```text
What lineage does each sample belong to?
```

Phase 9 answers:

```text
How are these lineages different from each other?
What mutations are shared between samples?
What mutations are unique to some samples?
What Spike mutation patterns are seen in each lineage?
```

This phase is important because a lineage name alone is not enough. To understand the biological meaning, we need to look at the mutation pattern behind the lineage.

---

## What was done

In this phase, the Nextclade and Pangolin results were summarized and interpreted.

The analysis focused on:

* final lineage comparison
* sample acceptance for interpretation
* lineage counts
* clade counts
* Spike mutations by sample
* shared amino-acid substitutions
* unique amino-acid substitutions
* deletions and missing regions
* lineage-associated mutation patterns
* mutation heatmaps

The goal was to connect the lineage names with the mutations found in each sample.

---

## Tools and files used

This phase used the output files from:

```text
Nextclade
Pangolin
custom Python / command-line summaries
```

The main input information came from Phase 8 lineage and mutation outputs.

The results were stored in:

```text
results/phase9_interpretation/
```

---

## Output folder structure

The Phase 9 output folder was:

```text
results/phase9_interpretation/
├── clade_counts.tsv
├── clean_lineage_comparison.tsv
├── deletions_and_missing_regions.tsv
├── lineage_counts.tsv
├── lineage_patterns
│   ├── lineage_core_aa_patterns.tsv
│   ├── lineage_specific_core_aa_mutations.tsv
│   ├── lineage_specific_core_matrix.tsv
│   ├── lineage_specific_core_mutation_heatmap.png
│   ├── lineage_spike_patterns.tsv
│   ├── sample_spike_mutation_heatmap.png
│   └── sample_spike_mutation_matrix.tsv
├── sample_acceptance_summary.tsv
├── shared_aa_substitutions.tsv
├── spike_mutations_by_sample.tsv
└── unique_aa_substitutions_by_sample.tsv
```

---

## Clean lineage comparison

The file:

```text
clean_lineage_comparison.tsv
```

summarized the final lineage results from Nextclade and Pangolin.

The result showed that the two tools agreed for all six samples.

```text
ERR11029820 → XBB.1.5.5
ERR11029826 → EZ.1
ERR11029834 → BN.1.5
ERR11029837 → XBB.1.5
ERR11029838 → XBB.1.5
ERR11029840 → XBB.1.5
```

All samples had:

```text
lineage_agreement = yes
nextclade_qc = good
```

This means that Nextclade and Pangolin gave the same lineage assignment, and all samples were good enough for interpretation.

---

## Lineage counts

The file:

```text
lineage_counts.tsv
```

showed how many samples belonged to each lineage.

The result was:

```text
lineage      sample_count
XBB.1.5      3
XBB.1.5.5    1
EZ.1         1
BN.1.5       1
```

This means that the most common lineage in this dataset was:

```text
XBB.1.5
```

Three samples belonged to XBB.1.5.

The other lineages appeared once each.

---

## Clade counts

The file:

```text
clade_counts.tsv
```

showed how many samples belonged to each broader Nextclade clade.

The result was:

```text
clade    sample_count
23A      4
22E      1
22D      1
```

This means that most samples belonged to clade 23A.

The 23A samples were the XBB-related samples.

---

## Sample acceptance

The file:

```text
sample_acceptance_summary.tsv
```

showed whether each sample was accepted for lineage interpretation.

All samples were accepted:

```text
ERR11029820 → accepted_for_lineage_interpretation
ERR11029826 → accepted_for_lineage_interpretation
ERR11029834 → accepted_for_lineage_interpretation
ERR11029837 → accepted_for_lineage_interpretation
ERR11029838 → accepted_for_lineage_interpretation
ERR11029840 → accepted_for_lineage_interpretation
```

This is because all samples had:

```text
QC status = good
```

So all six consensus genomes were suitable for lineage-level analysis.

---

## Spike mutations by sample

The file:

```text
spike_mutations_by_sample.tsv
```

listed the Spike protein mutations found in each sample.

This is important because Spike mutations are commonly used to compare SARS-CoV-2 variants.

The number of Spike substitutions was:

```text
ERR11029820 → 38 Spike substitutions
ERR11029826 → 33 Spike substitutions
ERR11029837 → 38 Spike substitutions
ERR11029838 → 36 Spike substitutions
ERR11029840 → 37 Spike substitutions
ERR11029834 → 36 Spike substitutions
```

No Spike deletions were reported:

```text
spike_deletion_count = 0
```

This means that differences between these samples were mainly Spike substitutions, not Spike deletions.

---

## Shared amino-acid substitutions

The file:

```text
shared_aa_substitutions.tsv
```

listed amino-acid substitutions and how many samples had each mutation.

Several mutations were found in all six samples.

Examples include:

```text
E:T9I
M:A63T
N:P13L
N:R203K
N:G204R
ORF1a:G1307S
ORF1a:L3027F
ORF1b:P314L
S:D405N
S:D614G
S:E484A
S:G142D
S:K417N
S:N440K
S:N460K
S:N501Y
S:N679K
```

These shared mutations show that the samples have common Omicron-related mutation patterns.

---

## Unique amino-acid substitutions

The file:

```text
unique_aa_substitutions_by_sample.tsv
```

listed mutations that appeared in only one sample.

The unique mutation counts were:

```text
ERR11029820 → 4 unique amino-acid substitutions
ERR11029826 → 16 unique amino-acid substitutions
ERR11029834 → 15 unique amino-acid substitutions
ERR11029837 → 2 unique amino-acid substitutions
ERR11029838 → 2 unique amino-acid substitutions
ERR11029840 → 2 unique amino-acid substitutions
```

ERR11029826 and ERR11029834 had more unique mutations than the XBB.1.5 samples.

This supports the idea that ERR11029826 and ERR11029834 belong to different lineages.

---

## Deletions and missing regions

The file:

```text
deletions_and_missing_regions.tsv
```

separated real deletions from missing or masked regions.

All samples had the same nucleotide deletion:

```text
11288-11296
```

This deletion produced three amino-acid deletions in ORF1a:

```text
ORF1a:S3675-
ORF1a:G3676-
ORF1a:F3677-
```

The file also listed missing or masked regions.

These missing regions are not the same as biological deletions.

They usually represent positions masked as `N` because coverage was below 10x.

So the important difference is:

```text
Deletion = real sequence change
Missing region = uncertain region masked as N
```

---

## Lineage Spike patterns

The file:

```text
lineage_patterns/lineage_spike_patterns.tsv
```

summarized Spike mutation patterns by lineage.

This file helps answer:

```text
What Spike mutation pattern is seen in each lineage?
```

The XBB.1.5 lineage had three samples:

```text
ERR11029837
ERR11029838
ERR11029840
```

These samples shared a core Spike mutation pattern.

The core XBB.1.5 Spike pattern included mutations such as:

```text
S:T19I
S:V83A
S:G142D
S:H146Q
S:Q183E
S:V213E
S:G252V
S:G339H
S:R346T
S:L368I
S:S371F
S:S373P
S:S375F
S:T376A
S:D405N
S:K417N
S:N440K
S:N460K
S:S477N
S:T478K
S:E484A
S:F486P
S:F490S
S:Q498R
S:N501Y
S:Y505H
S:D614G
S:H655Y
S:N679K
S:P681H
S:N764K
S:D796Y
S:Q954H
S:N969K
```

This pattern was supported by multiple samples because XBB.1.5 had three samples.

For BN.1.5, EZ.1, and XBB.1.5.5, each lineage had only one sample. Therefore, their patterns should be interpreted carefully.

---

## Lineage-specific core amino-acid mutations

The file:

```text
lineage_patterns/lineage_specific_core_aa_mutations.tsv
```

identified mutations that were present in a lineage and absent from the other lineages in this dataset.

This file helps answer:

```text
What mutations distinguish each lineage in this dataset?
```

The results were:

```text
BN.1.5 → 15 lineage-specific core amino-acid mutations
EZ.1 → 16 lineage-specific core amino-acid mutations
XBB.1.5 → 0 lineage-specific core amino-acid mutations
XBB.1.5.5 → 4 lineage-specific core amino-acid mutations
```

BN.1.5 had lineage-specific mutations such as:

```text
S:F157L
S:G257S
S:I210V
S:K147E
S:K356T
S:W152R
```

EZ.1 had lineage-specific mutations such as:

```text
S:F486V
S:G339D
S:K444T
S:L452R
S:Q613H
S:S247N
S:Y248S
```

XBB.1.5.5 had:

```text
ORF1a:L1896F
ORF1a:S2246L
ORF1a:S2900L
S:K1181I
```

XBB.1.5 had zero lineage-specific core mutations in this file because its core mutations were also shared with related lineages in this dataset, especially XBB.1.5.5.

---

## Mutation heatmaps

Two heatmap figures were generated:

```text
sample_spike_mutation_heatmap.png
lineage_specific_core_mutation_heatmap.png
```

The sample Spike heatmap shows mutation presence or absence across samples.

In this heatmap:

```text
Rows = samples and lineages
Columns = Spike mutations
Color = mutation present or absent
```

This helps visually compare mutation patterns.

The heatmap showed that the XBB.1.5 samples had very similar Spike mutation patterns.

The EZ.1 and BN.1.5 samples had different mutation patterns.

This supports the lineage assignments from Nextclade and Pangolin.

---

## Important caution

This project has only six samples.

Some lineages are represented by only one sample:

```text
XBB.1.5.5 → 1 sample
EZ.1 → 1 sample
BN.1.5 → 1 sample
```

Because of this, we should not say:

```text
These are statistically proven lineage-defining mutations.
```

The better interpretation is:

```text
These are lineage-associated mutation patterns observed in this dataset.
```

This wording is more accurate and scientific.

---

## Main interpretation

The Phase 9 results showed that:

* all samples were accepted for lineage interpretation
* Nextclade and Pangolin agreed in Phase 8
* most samples belonged to XBB-related lineages
* XBB.1.5 was the most common lineage
* ERR11029826 belonged to EZ.1
* ERR11029834 belonged to BN.1.5
* XBB.1.5 samples had similar Spike mutation patterns
* EZ.1 and BN.1.5 had distinct mutation patterns
* all samples shared the ORF1a deletion S3675-, G3676-, and F3677-
* missing regions were due to masked low-coverage positions

---

## Results produced from this phase

The main results of Phase 9 were:

1. A clean lineage comparison table.

2. Lineage count summary.

3. Clade count summary.

4. Sample acceptance summary.

5. Spike mutation table by sample.

6. Deletion and missing-region table.

7. Shared amino-acid substitution table.

8. Unique amino-acid substitution table.

9. Lineage Spike mutation patterns.

10. Lineage-specific amino-acid mutation patterns.

11. Spike mutation heatmap.

12. Lineage-specific mutation heatmap.

---

## Conclusion

Phase 9 completed the biological interpretation of the SARS-CoV-2 genomic surveillance workflow.

The lineage results showed that all six samples were Omicron-related.

Most samples were XBB-related, especially XBB.1.5.

The mutation analysis showed that samples from the same lineage had similar mutation patterns, while different lineages showed different mutation profiles.

The heatmaps provided a visual way to compare these patterns.

Because the dataset is small, the mutation patterns should be described as lineage-associated patterns observed in this dataset, not as statistically proven lineage-defining mutations.

This phase completed the project by moving from technical genome analysis to biological interpretation.
