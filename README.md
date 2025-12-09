# Integrated analysis of miR-187 in medaka fertility
This repository contains the scripts and code used in the article entitled <u>"Unveiling the role of miR-187 in adult ovarian follicle growth and female fecundity in *Oryzias latipes* (medaka)"</u> (https://doi.org/xxx).

It provides the computational workflows for:

- **3D imaging analysis**, used to quantify ovarian follicle composition in young adult (104 dpf) and aged adult (211 dpf) miR-187 mutant (MUT) and wild-type (WT) medaka ovaries.

- **BRB-seq transcriptomic analysis**, performed to compare gene expression profiles between miR-187 mutant (MUT) and wild-type (WT) young adult medaka ovaries, and to identify potential miR-187-3p targets involved in ovarian function.


## Repository structure

```
miR187-medaka-fertility/
│
├─ 3D_imaging_analysis/
│ ├─ heatmap/
│ ├─ density/
│ ├─ total_count/
│ └─ README.md 
│
├─  BRB-seq_transcriptomic_analysis/
│ ├─ data/                      # input files
│ ├─ BRBseq_analysis.Rmd        # Transcriptomic pipeline 
│ └─ README.md
│
├─ README.md
├─ .gitignore
├─ CITATION.cff
└─ environment.yml
```

## Data availability

Raw and processed data will be available upon publication:

- **RNA-seq raw reads (BRB-seq)**: NCBI SRA / ENA — BioProject **PRJNA1233206** 
- **3D ovarian imaging**: BioImage Archive **BIA-xxxx**

> Accessions will be updated when available.


## Environment setup

Environment setup instructions are provided in the README files of each analysis module (BRB-seq transcriptomics and 3D imaging).
Each module includes its own renv environment to ensure reproducibility.  


## How to reproduce

To reproduce the analyses, first clone the repository:
```bash
git clone https://github.com/V.Thermes_LPGP/miR187-medaka-fertility.git
cd miR187-medaka-fertility
```
This project contains two independent analysis pipelines (3D imaging and BRB-seq transcriptomics).  
Each pipeline includes:

- its own dataset requirements,
- its own R environment setup (via `renv`),
- and its own step-by-step instructions.

Please refer to the `README.md` files located in:

- `3D_imaging_analysis/`
- `BRB-seq_transcriptomic_analysis/`

for complete reproduction details.

## If you use this code, please cite:

Unveiling the role of mir-187 in adult ovarian follicle growth and female fecundity in medaka (Oryzias latipes).
Marlène Davilma, Stéphanie Gay, Sully Heng, Fabrice Mahé, Manon Thomas, Laurence Dubreil, Jérôme Montfort, Aurélien Brionne, Julien Bobe, Violette Thermes (2026). 
Version 1.0, Zenodo. DOI: 10.5281/zenodo.xxxxxx

## License

This repository is distributed under the MIT License.
