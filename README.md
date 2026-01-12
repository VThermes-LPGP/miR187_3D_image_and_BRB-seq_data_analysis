# Computational workflows for analysis of 3D imaging data and BRB-seq data in miR-187-/- and wild-type medaka ovaries
This repository contains the scripts and code used in the article entitled <u>"Identification of miR-187 as a modulator of early oogenesis and female fecundity in
medaka"</u>.

It provides the computational workflows for:

- **3D imaging data analysis**, used to quantify ovarian follicle composition in young adult (104 dpf) and aged adult (211 dpf) miR-187 mutant (MUT) and wild-type (WT) medaka ovaries.

- **BRB-seq transcriptomic analysis**, performed to compare gene expression profiles between miR-187 mutant (MUT) and wild-type (WT) young adult medaka ovaries, and to identify potential miR-187-3p targets involved in ovarian function.


## Repository structure

```
miR187-medaka-fertility/
│
├─ 3D_imaging_data_analysis/
│ ├─ heatmap/
│ ├─ density/
│ ├─ total_count/
│ └─ README.md 
│
├─  BRB-seq_transcriptomic_analysis/
│ ├─ data/                     
│ ├─ BRBseq_analysis.Rmd        
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
- **3D ovarian images**: BioImage Archive **DOI 10.6019/S-BIAD1824**
- **3D image-derived data** (follicles diameters): Recherche Data Gouv **https://doi.org/10.57745/B6OOMX**


## Environment setup

Environment setup instructions are provided in the README files of each analysis module (BRB-seq transcriptomics analysis and 3D imaging data analysis).
Each module includes its own renv environment to ensure reproducibility.  


## How to reproduce

To reproduce the analyses, first clone the repository:
```bash
git clone https://github.com/V.Thermes_LPGP/miR187-medaka-fertility.git
cd miR187-medaka-fertility
```
This project contains two independent analysis pipelines (3D imaging data and BRB-seq transcriptomics).  
Each pipeline includes:

- its own dataset requirements,
- its own R environment setup (via `renv`),
- and its own step-by-step instructions.

Please refer to the `README.md` files located in:

- `3D_imaging_data_analysis/`
- `BRB-seq_transcriptomic_analysis/`

for complete reproduction details.

## If you use this code, please cite:

Identification of miR-187 as a modulator of early oogenesis and female fecundity in medaka. Marlène Davilma, Stéphanie Gay, Sully Heng, Fabrice Mahé, Manon Thomas, Laurence Dubreil, Jérôme Montfort, Aurélien Brionne, Julien Bobe, Violette Thermes (2026). 

## License

This repository is distributed under the MIT License.
