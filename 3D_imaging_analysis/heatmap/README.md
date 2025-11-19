# 3D Ovary Imaging Analysis – Heatmap Pipeline

## Overview and purpose
This R script processes 3D imaging data of WT and miR-187 mutant (MUT) medaka ovaries.  

It performs the following steps:

- Reads Excel files containing follicle diameter measurements.
- Calculates follicle distribution by size classes.
- Performs statistical analyses:
  - Shapiro normality test by group
  - Mann-Whitney test for independent WT vs MUT comparison
- Generates annotated heatmap showing Z-scores and p-values to visualize differences between groups.

This workflow allows researchers to analyse and visualize follicle size distributions across WT and MUT medaka ovaries at two developmental stages: 104 dpf (juveniles) and 211 dpf (adults).
The script automatically processes both ages and organizes outputs in separate folders.

---

## Repository structure
```
heatmap/
├─ input/
│  ├─ 104dpf/
│  │  ├─ A/         # WT Excel files for 104 dpf
│  │  └─ B/         # MUT Excel files for 104 dpf
│  └─ 211dpf/
│     ├─ A/         # WT Excel files for 211 dpf
│     └─ B/         # MUT Excel files for 211 dpf
├─ heatmap_miR187.R
├─ README.md
```

**Explanation:**  
- `input/<age>dpf/A/` – contains Excel files for WT ovaries at the given age.
- `input/<age>dpf/B/` – contains Excel files for MUT ovaries at the given age.
- `heatmap_miR187.R` – the main R script.
- `README.md` – this file, providing instructions and context.

---

## Prerequisites
The script requires the following R packages:

- `readxl`
- `data.table`
- `dplyr`
- `tidyr`
- `ComplexHeatmap`
- `circlize`

Install missing packages using `install.packages()`.

---

## Instructions for Use

1. **Clone or download** this repository.
   - Make sure the `input/` folder is located in the same directory as `heatmap_miR187.R`.

2. **Run the script:**
   - Open `heatmap_miR187.R` in RStudio.
   - Execute the script.
   - The script will automatically: 
          - Processes both 104 and 211 dpf datasets.
          - Generates `data_by_group.csv` automatically in each `input/<age>dpf/` folder.
          - Creates the corresponding `output/<age>dpf/` folders and saves the heatmaps there.

3. **Results:**
   - Heatmaps (Z-score normalized with p-value annotations) are saved in the corresponding `output/<age>dpf/` folder as `pearson_heatmap_<dataset>.png`.

