# Unveiling the role of mir-187 in adult ovarian follicle growth and female fecundity in medaka (Oryzias latipes)
This repository contains all code used in our study on the role of miR-187 in adult ovarian follicle growth and female fertility in *Oryzias latipes* (medaka). It includes 3D imaging analysis and BRB-seq transcriptomic analysis comparing young adult (90 dph) miR-187⁻/⁻ mutants to WT.

---

## Repository structure

- `scripts/python/` — 3D imaging analysis (segmentation/quantification workflows)
- `scripts/R/` — helper R functions used by the BRB-seq notebook
- `notebooks/BRBseq_analysis.Rmd` — transcriptomic pipeline (QC, DE, enrichment)
- `data/` — metadata and dataset links (no raw data in Git)
- `results/` — generated figures and tables
- `docs/` — methodological notes and references

---

## Data availability

Raw and processed data will be available upon publication:

- **RNA-seq raw reads (BRB-seq)**: NCBI SRA / ENA — BioProject **PRJNAxxxxxx**
- **Processed counts + metadata**: GEO **GSExxxxxx**
- **3D ovarian imaging**: BioImage Archive **BIA-xxxx**

> Accessions will be updated when available.

---

## Environment setup

### Python (for imaging analysis)
Create and activate the conda environment:
```bash
conda env create -f environment.yml
conda activate mir187-imaging
