# Integrated analysis of miR-187 in medaka fertility
This repository contains the scripts and code used in the article entitled <u>"Unveiling the role of miR-187 in adult ovarian follicle growth and female fecundity in *Oryzias latipes* (medaka)"</u> (https://doi.org/xxx).

It provides the computational workflows for:

- **3D imaging analysis**, used to quantify ovarian follicle composition in young adult (104 dpf) and aged adult (211 dpf) miR-187 mutant (MUT) and wild-type (WT) medaka ovaries.

- **BRB-seq transcriptomic analysis**, performed to compare gene expression profiles between miR-187 mutant (MUT) and wild-type (WT) medaka ovaries, and to identify potential miR-187-3p targets involved in ovarian function.

---

## Repository structure

```
miR187-medaka-fertility/
│
├─ 3D_imaging_analysis/
│ ├─ README.md 
│ └─ img_viz3D.R
│
├─  BRB-seq_transcriptomic_analysis/
│ ├─ README.md
│ └─ data/        # input files
│ └─ BRBseq_analysis.Rmd       # Transcriptomic pipeline
│
├─ README.md
├─ .gitignore
├─ CITATION.cff
└─ environment.yml
```

---

## Data availability

Raw and processed data will be available upon publication:

- **RNA-seq raw reads (BRB-seq)**: NCBI SRA / ENA — BioProject **PRJNAxxxxxx**
- **3D ovarian imaging**: BioImage Archive **BIA-xxxx**

> Accessions will be updated when available.

---

## Environment setup

**R (for BRB-seq analysis)**
Use renv to restore the exact R environment used in this project.
renv ensures that everyone reproduces the same results by installing the same versions of the R packages.

Run the following commands in R:
```r
install.packages("renv")  # installs renv if not already available
renv::restore()           # installs all the package versions recorded in renv.lock
```

## How to reproduce

1-Clone the repository :
```bash
git clone https://github.com/S-Gay/miR187-medaka-fertility.git
cd miR187-medaka-fertility
```

2-Download datasets
See `data/README.md` for dataset links and accession numbers.

3-Run the analyses
Imaging: run the R scripts in `scripts/python/` and in `scripts/R/`
Transcriptomics: open and run the R Markdown notebook BRBseq_analysis.Rmd

## If you use this code, please cite:

Unveiling the role of mir-187 in adult ovarian follicle growth and female fecundity in medaka (Oryzias latipes).
Marlène Davilma, Stéphanie Gay, Sully Heng, Fabrice Mahé, Manon Thomas, Laurence Dubreil, Jérôme Montfort, Aurélien Brionne, Julien Bobe, Violette Thermes (2026). 
Version 1.0, Zenodo. DOI: 10.5281/zenodo.xxxxxx

## License

This repository is distributed under the MIT License.
