# 3D Ovary Imaging Analysis – 3D Imaging Pipelines

This folder contains two analysis pipelines for 3D imaging data of WT and miR-187 mutant (MUT) medaka ovaries:

1. **Heatmap pipeline** – generates Z-score normalized heatmaps to visualize differences between WT and MUT.
2. **Density pipeline** – computes and visualizes follicle size distributions as density plots.

## Repository structure

```
3D_imaging_analysis/
├─ heatmap/
│  ├─ input/
│  └─ heatmap_miR187.R
│  └─ README.md
├─ density/
│  ├─ input/
│  └─ density_miR187.R
│  └─ README.md
├─ README.md   
```

## Instructions

- Each subfolder contains a complete README with detailed instructions:
  - `heatmap/README.md` – step-by-step guide for generating heatmaps
  - `density/README.md` – step-by-step guide for generating density plots

- To run the analyses:
  1. Navigate to the desired subfolder.
  2. Follow the instructions in the respective README.

## Notes

- Ensure that the `input/` folders are populated with the correct Excel files before running any scripts.
- Both pipelines automatically process datasets for 104 dpf (juveniles) and 211 dpf (adults).
