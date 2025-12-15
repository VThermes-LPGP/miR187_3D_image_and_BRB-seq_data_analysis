# BRB-seq transcriptomic analysis pipeline

## Overview and purpose
The notebook "BRBseq_analysis.Rmd" reproduces the main steps of the BRB-seq transcriptomic analysis used in the article entitled <ins> The miR-187 is a newly identified regulator of early oogenesis and female fecundity in medaka. </ins>

It focuses on two key objectives:

**- Differential Gene Expression and KEGG Pathway Analysis**
To compare transcriptomic profiles between miR-187 mutant (MUT) and wild-type (WT) medaka ovaries, and to explore the biological pathways affected by miR-187 deletion.

**- Identification of Potential miR-187-3p Targets** 
To identify and characterize genes potentially regulated by miR-187-3p that may contribute to ovarian function.

---
## Upstream data processing prior to the BRB-seq transcriptomic analysis
Raw read alignment and gene quantification were carried out using the [Nextflow RNAseq pipeline](https://forgemia.inra.fr/lpgp/rnaseq), developed and maintained by the INRAE LPGP bioinformatics team.  

This automated workflow includes:  
Transcriptome alignment and quantification with *Alevin-fry* ([PMID: 37034702](https://pubmed.ncbi.nlm.nih.gov/37034702/)) via its simpleaf wrapper,  
Genome alignment and exon-level quantification with *STARsolo* ([PMID: 23104886](https://pubmed.ncbi.nlm.nih.gov/23104886/)).  

The gene-level count matrices obtained (STAR_SOLO_counts.xls) were used as input data for the analyses described in this notebook.

---
## File structure
All input and output files are organized in the data/ directory to ensure full reproducibility of the analyses.  

**Input directory**: `data/input/`  
Contains the source files required to run the analyses  
*(STAR_SOLO_counts.xls, orthologs.txt.gz, miR187_contextscore_output.txt)*

**Output directory**: `data/output/` 
> **This directory is intentionally empty.**

Outputs are not included in this repository because all figures and tables appear in the associated publication. Users running the pipeline will generate their own outputs locally.

---
## Reproducibility
To reproduce the analyses:

*Ensure the input/ and output/ folders are in the same directory as the notebook*  

1- Download the input data placed in data/input/.  
2- Open the notebook BRBseq_analysis.Rmd  
3- Run all code chunks sequentially from top to bottom  
4- All generated results will automatically appear in data/output/

---
## Environment setup

**R environment**
Use renv to restore the exact R environment used in this project.
renv ensures that everyone reproduces the same results by installing the same versions of the R packages.

Run the following commands in R:
```r
install.packages("renv")  # installs renv if not already available
renv::restore()           # installs all the package versions recorded in renv.lock
```
