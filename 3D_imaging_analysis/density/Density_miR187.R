#==============================================================
#                 Follicle Density Analysis  
#     Automated multi-experiment pipeline for WT vs MUT
#==============================================================

#---------------------------
# 0. Clean workspace
#---------------------------
rm(list = ls())

#---------------------------
# 1. Load required libraries
#---------------------------
library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(ggridges)
library(viridis)
library(hrbrthemes)
library(svglite)
library(RColorBrewer)

#---------------------------
# 2. Set working directory to script location
#---------------------------
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#---------------------------
# 3. User parameters
#---------------------------

# Follicle size range to keep
size_min <- 20
size_max <- 250

input_root  <- "input/" 
output_root <- "output/"

color_palette <- c("WT" = "#2080F1", "MUT" = "mediumseagreen")

#---------------------------
# 4. Detect experiments (subfolders)
#---------------------------
experiment_folders <- list.dirs(input_root, recursive = FALSE)

if (length(experiment_folders) == 0){
  stop("❌ No subfolder found in /input/. Please add at least one (e.g., input/104dpf/).")
}

#==============================================================
#                 MAIN LOOP OVER EXPERIMENTS
#==============================================================
for (experiment_path in experiment_folders) {
  
  experiment_name <- basename(experiment_path)
  
  message("\n===================================================")
  message("  Processing experiment: ", experiment_name)
  message("===================================================\n")
  
  output_dir <- file.path(output_root, experiment_name)
  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
  
  #----------------------------------------------------------
  # 5. Import Excel files
  #----------------------------------------------------------
  excel_files <- list.files(experiment_path, pattern = "\\.xlsx$", full.names = TRUE)
  
  if (length(excel_files) == 0){
    warning(paste("⚠ No .xlsx file found in:", experiment_path))
    next
  }
  
  sample_names <- gsub(".xlsx$", "", basename(excel_files))
  
  #----------------------------------------------------------
  # 6. Read and combine data
  #----------------------------------------------------------
  all_data <- data.frame()
  
  for (i in seq_along(excel_files)){
    
    df <- read_excel(excel_files[i])
    
    df <- df[-1, ]
    df[is.na(df)] <- 0
    
    df_long <- pivot_longer(
      df, cols = everything(),
      names_to = "sample", values_to = "size"
    )
    
    df_long <- df_long[df_long$size > 0, ]
    
    df_long$sample <- sample_names[i]
    
    df_long$group <- ifelse(grepl("WT", df_long$sample), "WT", "MUT")
    
    all_data <- rbind(all_data, df_long)
  }
  
  #----------------------------------------------------------
  # 7. Filter by follicle size
  #----------------------------------------------------------
  all_data <- all_data %>%
    filter(size >= size_min & size <= size_max)
  
  #----------------------------------------------------------
  # 8. Density calculation function
  #----------------------------------------------------------
  compute_density <- function(data, label){
    dens <- density(
      data$size,
      n = 512,
      from = size_min,
      to = size_max
    )
    data.frame(size = dens$x, density = dens$y, group = label)
  }
  
  density_WT  <- compute_density(filter(all_data, group == "WT"), "WT")
  density_MUT <- compute_density(filter(all_data, group == "MUT"), "MUT")
  
  density_all <- rbind(density_WT, density_MUT)
  
  #----------------------------------------------------------
  # 9. Plot: combined density curves
  #----------------------------------------------------------
  plot_density <- ggplot() +
    geom_density(
      data = all_data,
      aes(x = size, color = group, linetype = sample),
      linewidth = 0.3, alpha = 0.6
    ) +
    geom_line(
      data = density_all,
      aes(x = size, y = density, color = group),
      linewidth = 0.6
    ) +
    scale_color_manual(values = color_palette) +
    scale_linetype_manual(values = rep("dashed", length(unique(all_data$sample)))) +
    labs(
      title = paste("Follicle distribution by size (", experiment_name, ")", sep=""),
      x = "Follicle diameter (µm)",
      y = "Probability Density"
    ) +
    theme_light() +
    theme(
      plot.title    = element_text(face = "bold"),
      axis.title    = element_text(face = "bold"),
      panel.border  = element_rect(color = "black", fill = NA, linewidth = 1.5),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank(),
      legend.title  = element_blank()
    ) +
    guides(linetype = "none")
  
  #----------------------------------------------------------
  # 10. Save outputs
  #----------------------------------------------------------
  out_base <- paste0(output_dir, "/Combined_Density_WT_MUT_", size_min, "-", size_max)
  
  ggsave(paste0(out_base, ".png"), plot_density, width = 20, height = 10, dpi = 400, units = "cm")
  ggsave(paste0(out_base, ".pdf"), plot_density, width = 20, height = 10, dpi = 400, units = "cm")
  
  message("✔ Figures saved in: ", output_dir)
}

