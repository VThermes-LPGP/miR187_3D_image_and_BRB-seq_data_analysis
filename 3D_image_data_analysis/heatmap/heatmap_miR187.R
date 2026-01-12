# heatmap_miR187.R

# Single script for processing 3D imaging data of WT and MUT ovaries
# Author: Marlène Davilma
# Description: This script reads Excel files containing follicle diameter data from 3D-imaged ovaries,
# calculates the distribution of follicles by size classes, performs Shapiro + Mann-Whitney tests,
# and generates the final heatmap figures.

#-----------------------
# Required libraries
#-----------------------
library(readxl)
library(data.table)
library(dplyr)
library(tidyr)
library(ComplexHeatmap)
library(circlize)

#-----------------------
# Define working directory
#-----------------------
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#-----------------------
# Loop over ages
#-----------------------
for(age_dpf in c(104, 211)) {
  
  #-----------------------
  # Define size classes and stage names according to age
  #-----------------------
  if(age_dpf == 104) {
    size_class <- c(20, 60, 90, 120, 150, 250, 400, 500, 800)
    stage_name <- c("I","II","III","IV","V","VI","VII","VIII")
  } else if(age_dpf == 211) {
    size_class <- c(20, 60, 90, 120, 150, 250, 400, 500, 800, 1200)
    stage_name <- c("I","II","III","IV","V","VI","VII","VIII","IX")
  } else {
    stop("⚠️ age_dpf not recognized. Use 104 or 211.")
  }
  
  group_names <- c("WT", "MUT")
  
  #-----------------------
  # Define input/output directories dynamically
  #-----------------------
  input_dir <- paste0("input/", age_dpf, "dpf/")
  output_dir <- paste0("output/", age_dpf, "dpf/")
  if(!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)
  
  #-----------------------
  # Table_Maker module
  #-----------------------
  Table_Maker <- function(size_class, names) {
    file_list <- c("A", "B")
    df_list <- list()
    
    for(i in file_list) {
      path <- paste0(input_dir, i)
      files <- list.files(path, pattern = "\\.xlsx$", full.names = TRUE)
      if(length(files) > 0) {
        df <- read_excel(files)
        df_list <- append(df_list, list(df))
      }
    }
    
    df_table_list <- list()
    
    for (n in 1:length(df_list)) {
      data <- df_list[[n]]
      data <- data[-1, ]
      data <- data.table(data)
      data <- data.table::melt.data.table(data, measure.vars = 1:ncol(data))
      data <- na.omit(data)
      
      labels <- paste0(size_class[-length(size_class)], "-", size_class[-1])
      class_data <- data
      class_data[, class := cut(value, breaks = size_class, labels = labels, include.lowest = TRUE)]
      class_data <- na.omit(class_data)
      
      class_counts <- class_data[, .N, by = .(variable, class)]
      class_sums <- class_counts[, .(total = sum(N)), by = variable]
      class_data <- merge(class_counts, class_sums, by = "variable")
      class_data[, percentage := round(N / total * 100, 2)]
      class_data <- class_data[, .(variable, class, percentage)]
      
      sorted_data <- dcast(
        data = class_data,
        variable ~ class,
        value.var = "percentage",
        fill = 0,
        drop = FALSE
      )
      
      group <- data.frame(category = rep(file_list[n], nrow(sorted_data)))
      sorted_data <- cbind(group, sorted_data)
      df_table_list[[n]] <- sorted_data
    }
    
    final_data <- do.call(rbind, df_table_list)
    
    if(is.vector("names")) {
      for(i in 1:length(names)) {
        final_data$category <- gsub(unique(final_data$category)[i], names[i], final_data$category)
      }
    }
    
    write.csv2(final_data, paste0(input_dir, "data_by_group.csv"))
  }
  
  Table_Maker(size_class, group_names)
  
  #-----------------------
  # Test_KW module
  #-----------------------
  Test_KW <- function() {
    csv_files <- list.files(input_dir, pattern = ".csv")
    kw_results_list <- list()
    
    for (file in csv_files) {
      file_base <- gsub(".csv", "", file)
      
      data_i <- read.csv2(file.path(input_dir, file))
      data_i <- data_i[, -1]
      mydata <- data_i
      
      ncol_names <- names(mydata)
      ncol_names <- gsub("X", "", gsub("\\.", "-", ncol_names))
      ncol_names[length(ncol_names)] <- gsub("-", ">", ncol_names[length(ncol_names)])
      
      size_class_vec <- c()
      test_pval <- c()
      signif_label <- c()
      shapiro_pval_group1 <- c()
      shapiro_pval_group2 <- c()
      
      for (k in 3:length(ncol_names)) {
        data_tmp <- data.frame(
          category = mydata$category,
          number = as.double(mydata[, k])
        )
        
        if (length(na.omit(unique(data_tmp$category))) < 2 || all(is.na(data_tmp$number))) {
          next
        }
        
        groups <- unique(data_tmp$category)
        pvals_shapiro <- sapply(groups, function(g) {
          vals <- data_tmp$number[data_tmp$category == g]
          if(length(vals) >= 3) {
            if(length(unique(vals)) > 1) {
              return(shapiro.test(vals)$p.value)
            } else { return(NA) }
          } else { return(NA) }
        })
        
        shapiro_pval_group1 <- c(shapiro_pval_group1, pvals_shapiro[1])
        shapiro_pval_group2 <- c(shapiro_pval_group2, pvals_shapiro[2])
        
        test <- wilcox.test(number ~ category, data = data_tmp, exact = FALSE)
        pval <- test$p.value
        sig <- ifelse(pval < 0.001, "***",
                      ifelse(pval < 0.01, "**",
                             ifelse(pval < 0.05, "*", "ns")))
        
        a <- gsub("\\.", "-", colnames(mydata)[k])
        size_class_vec <- c(size_class_vec, a)
        test_pval <- c(test_pval, pval)
        signif_label <- c(signif_label, sig)
      }
      
      if (length(size_class_vec) == 0) {
        message(paste("⚠️ No test performed for file:", file))
        next
      }
      
      kw_results <- data.frame(
        "size_class" = size_class_vec,
        "p_value" = test_pval,
        "significance" = signif_label,
        "Shapiro_pval_group1" = shapiro_pval_group1,
        "Shapiro_pval_group2" = shapiro_pval_group2
      )
      
      kw_results_list[[file_base]] <- kw_results
    }
    return(kw_results_list[[1]])
  }
  
  kw_results <- Test_KW()
  
  #-----------------------
  # Final Heatmap module
  #-----------------------
  csv_file <- list.files(input_dir, pattern = ".csv")
  data_name <- gsub(".csv", "", csv_file) 
  assign(data_name, read.csv2(file.path(input_dir, csv_file)))
  data_i <- get(data_name)
  data_i <- data_i[, -1]
  data <- data_i
  
  sample_names <- data$variable
  data <- data[, -2]
  
  data$category <- factor(data$category, levels = unique(data$category))
  
  ncol_names <- names(data)
  ncol_names <- gsub("X", "", gsub("\\.", "-", ncol_names))
  colnames(data) <- ncol_names
  
  lab <- ncol_names[-1]
  
  data <- rev(data)
  data <- data %>% dplyr::select(category, 1:length(data))
  
  pval_df <- kw_results
  
  # Transpose and standardize
  mat <- t(data[, -1])
  row_split <- data$category
  mat <- t(scale(t(mat)))
  mat <- mat[rev(seq_len(nrow(mat))), ]
  
  # Define stage classes
  bounds_low <- sapply(strsplit(rownames(mat), "-"), function(x) as.numeric(x[1]))
  ind <- sapply(size_class[-1], function(threshold) {
    indices <- which(bounds_low < threshold)
    if(length(indices) == 0) NA else max(indices)
  })
  column_subcategories <- rep(NA, nrow(mat))
  column_subcategories[1:ind[1]] <- stage_name[1]
  if(length(ind) > 1){
    for(k in 2:length(ind)){
      column_subcategories[(ind[k-1]+1):ind[k]] <- stage_name[k]
    }
  }
  column_subcategories <- factor(column_subcategories, levels = stage_name)
  
  # Create heatmap
  heatmap_plot <- ComplexHeatmap::Heatmap(
    t(mat),
    row_split = row_split,
    row_names_side = "left",
    row_gap = unit(2, "mm"),
    column_names_side = "bottom",
    column_names_rot = 45,
    cluster_columns = FALSE,
    cluster_rows = FALSE,
    column_split = column_subcategories,
    name = "Z-score",
    col = circlize::colorRamp2(c(-4, -1, 0, 1, 4),
                               c("#006A9F", "#004F78", "#031E2E", "orange", "yellow")),
    bottom_annotation = HeatmapAnnotation(
      P_value = -log10(pval_df$p_value),
      show_legend = TRUE,
      annotation_legend_param = list(
        title = bquote("-"*~Log[10]*"(P_value)"),
        legend_direction = "horizontal",
        heatmap_legend_side = "bottom",
        legend_width = unit(2, "cm")
      ),
      col = list(
        P_value = circlize::colorRamp2(
          c(0, 1.1, 1.3, 1.30103, 2, 4),
          c("snow4", "grey80", "grey90", "lightgreen", "#41ab5d", "darkgreen")
        )
      )
    ),
    row_names_gp = grid::gpar(fontsize = 12),
    column_names_gp = grid::gpar(fontsize = 12),
    column_gap = unit(0.5, "mm"),
    heatmap_legend_param = list(
      at = c(-4, -2, 0, 2, 4),
      labels = c("-4", "-2", "0", "2", "4"),
      annotation_legend_side = "bottom",
      legend_grouping = "original",
      legend_direction = "horizontal",
      heatmap_legend_side = "bottom",
      inner_margin = unit(1, "mm"),
      legend_width = unit(3, "cm")
    )
  )
  
  png(
    paste0(output_dir, "pearson_heatmap_", data_name, ".png"),
    width = 10, height = 10, units = "in",
    res = 1200, pointsize = 4, bg = "transparent"
  )
  draw(heatmap_plot, background = "transparent",
       heatmap_legend_side = "bottom",
       annotation_legend_side = "bottom")
  dev.off()
}
