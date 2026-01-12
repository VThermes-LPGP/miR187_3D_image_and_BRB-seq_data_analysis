# 3D Ovarian Image Analysis – density Pipeline

## Overview and purpose
This R script processes 3D image data of WT and miR-187 mutant (MUT) medaka ovaries.  

It performs the following steps:

- Reads Excel files containing follicle diameter measurements for each sample.
- Filters follicle sizes within a user-defined range (default 20–250 µm).
- Computes density distributions for each sample and group (WT vs MUT).
- Generates combined density plots with average curves for WT and MUT

This workflow allows researchers to analyze and visualize follicle size distributions across WT and MUT medaka ovaries at two developmental stages: 104 dpf (juveniles) and 211 dpf (adults).
The script automatically detects experiments in separate subfolders and organizes outputs in dedicated folders.

---

## Repository structure
```
density/
├─ input/
│  ├─ 104dpf/
│  │  ├─ WT4.xlsx
│  │  ├─ WT5.xlsx   
│  │  ├─ MUT2.xlsx
│  │  ├─ ... 
│  └─ 211dpf/
│  │  ├─ WT4.xlsx
│  │  ├─ WT5.xlsx   
│  │  ├─ MUT2.xlsx
│  │  ├─ ...      
├─ density_miR187.R
├─ README.md
```

**Explanation:**  
- `input/<age>dpf/` – contains Excel files for each experiment/age. Files must include "WT" or "MUT" in their names for automatic grouping.
- `density_miR187.R` – the main R script.
- `README.md` – this file, providing instructions and context.

---

## Prerequisites
The script requires the following R packages:

- `readxl`
- `ggplot2`
- `tidyr`
- `dplyr`
- `ggridges`
- `viridis`
- `hrbrthemes`
- `svglite`
- `RColorBrewer`

Install missing packages using `install.packages()`.

---

## Instructions for Use

1. **Clone or download** this repository.
   - Ensure the `input/` folder is in the same directory as `density_miR187.R`.

2. **Run the script:**
   - Open `density_miR187.R` in RStudio.
   - Execute the script.
   - The script will automatically: 
          - Detect all subfolders in input/ (each subfolder = experiment/age).
          - Read all .xlsx files within each subfolder.
          - Compute density curves and generate combined density plots.
          - Save .png and .pdf figure in `output/<age>dpf/` folders.

3. **Results:**
   - Density plots are saved in the corresponding `output/<age>dpf/` folder as `Combined_Density_WT_MUT_20-250.png` and as `Combined_Density_WT_MUT_20-250.pdf`.

## Parameters
Users can modify the following parameters at the top of the script:

```
size_min <- 20        # Minimum follicle diameter (µm)
size_max <- 250       # Maximum follicle diameter (µm)
input_root  <- "input/"
output_root <- "output/"
color_palette <- c("WT" = "#2080F1", "MUT" = "mediumseagreen")
```

## Notes
  - Excel files must contain numeric follicle diameters. Zeros or NA values are ignored.
  - File names must contain "WT" or "MUT" to be correctly grouped.
  - If no Excel files are found in a subfolder, the script will skip it and display a warning.


