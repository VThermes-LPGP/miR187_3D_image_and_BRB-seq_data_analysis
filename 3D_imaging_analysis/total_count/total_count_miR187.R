# ============================================================
#  miR-187 Follicle Count Analysis — Automatic for 104 & 211 dpf
#  Generates final boxplots for both ages
# ============================================================

rm(list = ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(readxl)
library(ggplot2)
library(dplyr)

# -------------------------
# User parameters
# -------------------------
ages      <- c("104dpf", "211dpf")
seuil_min <- 20
seuil_max <- 1200
y_max     <- 5000

file_group_mapping <- list(A = "WT", B = "MUT")
group_colors <- c("#2080F1", "mediumseagreen")

# -------------------------
# Counting function
# -------------------------
# This function reads Excel files from each sample folder, counts follicles
# within the specified size range, and returns a combined data frame with group labels

Count <- function(input_subdir, thresh_min, thresh_max, mapping) {
  sample_dirs <- list.dirs(input_subdir, full.names = FALSE, recursive = FALSE)
  data_list <- list()
  
  for (sample in sample_dirs) {
    file <- list.files(file.path(input_subdir, sample), pattern = "\\.xlsx$", full.names = TRUE)
    if (length(file) == 0) next
    
    dat <- read_excel(file)
    dat <- dat[-1,]
    counts <- colSums(dat > thresh_min & dat < thresh_max, na.rm = TRUE)
    
    group <- mapping[[sample]]
    if (is.null(group)) stop(paste("No group mapping found for sample:", sample))
    
    data_list[[sample]] <- data.frame(count = counts,
                                      group = rep(group, length(counts)))
  }
  
  return(do.call(rbind, data_list))
}

# -------------------------
# Loop over ages
# -------------------------
# Iterates over each age folder, generates boxplots, performs Mann-Whitney test,
# and saves the figure in the corresponding output subfolder

for (age in ages) {
  
  input_subdir  <- file.path("input", age)
  output_subdir <- file.path("output", age)
  if (!dir.exists(output_subdir)) dir.create(output_subdir, recursive = TRUE)
  
  df <- Count(input_subdir, seuil_min, seuil_max, file_group_mapping)
  df$group <- factor(df$group, levels = c("WT", "MUT"))
  levels(df$group) <- c("italic('mir-187+/+')", "italic('mir-187-/-')")
  
  test_res    <- wilcox.test(count ~ group, data = df, exact = FALSE)
  p_value     <- test_res$p.value
  formatted_p <- gsub("\\.", ",", format(p_value, scientific = FALSE, digits = 3))
  signif_label <- ifelse(p_value < 0.05, "*", "ns")
  
  y_anchor <- y_max * 0.92
  y_offset <- y_max * 0.04
  
  p_boxplot <- ggplot(df, aes(x = group, y = count, fill = group)) +
    geom_boxplot(width = 0.6, outlier.shape = NA) +
    geom_jitter(aes(fill = group), width = 0.1, size = 1.5, color = "black", shape = 21) +
    scale_fill_manual(
      values = group_colors,
      labels = c(expression(italic("mir-187+/+")), expression(italic("mir-187-/-")))
    ) +
    labs(
      title = paste0("Total follicle count (", gsub("dpf","",age), " dpf)"),
      y = "Follicle number",
      fill = ""  
      ) +
    ylim(0, y_max) +
    theme_classic(base_size = 14) +
    theme(
      axis.title.x = element_blank(),
      plot.margin = margin(5,5,15,5)
    ) +
    geom_text(
      x = 1.5, y = y_max * 0.92,
      label = paste0("p = ", formatted_p),
      size = 3.5, color = "black"
    ) +
    geom_text(
      x = 1.5, y = y_max * 0.92 - y_max * 0.04,
      label = signif_label,
      size = 5, fontface = "bold", color = "black"
    ) +
    scale_x_discrete(labels = parse(text = levels(df$group)))
  
  # Save figure
  fig_name <- paste0("FollicleCount_", gsub("dpf","",age), "_", seuil_min, "-", seuil_max, ".png")
  ggsave(file.path(output_subdir, fig_name),
         p_boxplot, width = 15, height = 15, units = "cm", dpi = 200)
  
  message(paste0("✅ Boxplot for ", age, " saved in '", output_subdir, "'"))
}
