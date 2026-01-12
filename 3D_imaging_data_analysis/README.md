# 3D Ovary Imaging Data Analysis Pipelines

This folder contains three analysis pipelines for 3D imaging data of WT and miR-187 mutant (MUT) medaka ovaries for 104 dpf (juveniles) and 211 dpf (adults):

1. **Heatmap pipeline** – generates Z-score normalized heatmaps to visualize differences between WT and MUT.
2. **Density pipeline** – computes and visualizes follicle size distributions as density plots.
3. **Total count pipeline** – counts total follicle numbers and generates boxplots.

## Repository structure

```
3D_imaging_data_analysis/
├─ heatmap/
│  ├─ input/
│  ├─ heatmap_miR187.R
│  └─ README.md
├─ density/
│  ├─ input/
│  ├─ density_miR187.R
│  └─ README.md
├─ total_count/
│  ├─ input/
│  ├─ total_count_miR187.R
│  └─ README.md
├─ renv/
│  ├─ .gitignore
│  ├─ activate.R
│  └─ settings.json
├─ renv.lock
├─ README.md   
```

## Instructions

- Each subfolder contains a complete README with detailed instructions:
  - `heatmap/README.md` – step-by-step guide for generating heatmaps
  - `density/README.md` – step-by-step guide for generating density plots
  - `total_count/README.md` – step-by-step guide for generating total follicle count boxplots

- To run the analyses:
  1. Navigate to the desired subfolder.
  2. Follow the instructions in the respective README.

## Environment setup
Use  `renv` to restore the exact R environment used in this project. `renv` ensures that everyone reproduces the same results across machines.
The `renv.lock` file contains the exact versions of packages required to run the pipelines.

After cloning the repository, restore the environment with:
```
install.packages("renv")  # If renv is not already installed
renv::restore()           # installs packages as recorded in renv.lock
```


## Notes

- Ensure that the `input/` folders are populated with the correct Excel files before running any scripts.
- All pipelines automatically process datasets for 104 dpf (juveniles) and 211 dpf (adults).
