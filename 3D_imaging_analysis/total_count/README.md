# 3D Ovary Imaging Analysis – total count Pipeline

## Overview and purpose
This R script automatically processes 3D imaging data of WT and miR-187 mutant (MUT) medaka ovaries at two developmental stages (104 dpf and 211 dpf).  

It performs the following steps:
- Reads Excel files from subfolders corresponding to each age (`104dpf` and `211dpf`).  
- Counts the number of follicles within a specified size range (default 20–1200 µm).  
- Performs Mann-Whitney U test between groups (`WT` vs `MUT`) for statistical comparison.  
- Generates boxplots showing total follicle counts for each age with p-values and significance indicated.  
- Colors groups consistently (`WT` = blue, `MUT` = green) and displays group names in italics (mir-187+/+ vs mir-187-/-).  

The workflow automatically organizes outputs into dedicated folders for each age.

## Repository structure
```
total_count/
├─ input/
│  ├─ 104dpf/
│  │  ├─ A.xlsx     #WT
│  │  ├─ B.xlsx     #MUT   
│  └─ 211dpf/
│  │  ├─ A.xlsx     #WT
│  │  ├─ B.xlsx     #MUT
├─ total_count_miR187.R
├─ README.md
```

**Explanation:** 
- `input/<age>dpf/` – contains Excel files for each experiment/age. File prefixes (A, B, …) are mapped to experimental groups (WT or MUT).  
- `total_count_miR187.R` – the main R script that generates the boxplots.  
- `README.md` – this file, providing instructions and context.  

---

## Prerequisites
The script requires the following R packages:

- `readxl`
- `ggplot2`
- `dplyr`

Install missing packages using `install.packages()`.

---

## Instructions for Use

1. **Clone or download** the repository.  
   - Ensure the `input/` folder is in the same directory as `total_count_miR187.R`.

2. **Run the script:**  
   - Open `total_count_miR187.R` in RStudio.  
   - Execute the script.  
   - The script will automatically:  
       - Detect all age subfolders.  
       - Count follicles within the specified size range.  
       - Perform Mann-Whitney tests.  
       - Generate boxplots with p-values and significance.  
       - Save figures in `output/<age>dpf/` folders as `.png`.  

3. **Results:**  
   - Boxplots are saved in the corresponding `output/<age>dpf>/` folder.  
   - Filenames follow the pattern: `FollicleCount_<age>_<min>-<max>.png`.
   
---

## Parameters
Users can modify the following parameters at the top of the script:

```
seuil_min     <- 20                       # Minimum follicle size
seuil_max     <- 1200                     # Maximum follicle size
y_max         <- 5000                     # Max y-axis for boxplot
group_colors       <- c("#2080F1", "mediumseagreen")
```
---

## Notes
- Excel files must contain numeric follicle counts. Zeros or NA values are ignored.
- The script automatically creates `output/` and age-specific subfolders if they do not exist.
- If no Excel files are found in a subfolder, the script will skip it and display a warning.