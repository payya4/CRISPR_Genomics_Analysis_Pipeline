library(dplyr)
library(tidyr)
library(ggplot2)

# Load data from Scoary results
p_values <- read.csv('~/Desktop/filtered_data_1.4_new.csv')

# Extract necessary columns (Gene, Bonferroni_p, Benjamini_H_p)
p_values <- p_values %>% select(Gene, Bonferroni_p, Benjamini_H_p)

# Filter significant genes (e.g., p-value < 0.05 in at least one correction)
significant_genes <- p_values %>%
  filter(Bonferroni_p < 0.000000000000000000000000000000002 | Benjamini_H_p < 0.000000000000000000000000000000002)

# Optional: Select top N significant genes for better visualization
top_n_genes <- significant_genes %>%
  top_n(-30, wt = Bonferroni_p)  # Change 30 to the number of top genes you want to display

# Convert to long format for visualization
long_format <- top_n_genes %>%
  gather(key = 'Correction', value = 'p_value', Bonferroni_p, Benjamini_H_p)

# Clean up the Correction names
long_format$Correction <- gsub('Bonferroni_p', 'Bonferroni', long_format$Correction)
long_format$Correction <- gsub('Benjamini_H_p', 'Benjamini-Hochberg', long_format$Correction)

# Create the point plot
ggplot(long_format, aes(x = Gene, y = p_value, shape = Correction, color = Correction)) +
  geom_point(position = position_dodge(width = 0.5), size = 3) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 8),
    axis.text.y = element_text(size = 10),
    legend.position = "bottom",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8),
    plot.title = element_text(hjust = 0.5)
  ) +
  labs(
    title = 'Comparison of Bonferroni and Benjamini-Hochberg Corrected p-values',
    x = 'Gene',
    y = 'Corrected p-value',
    color = 'Correction Method',
    shape = 'Correction Method'
  ) +
  scale_y_log10() +
  scale_color_manual(values = c("Bonferroni" = "steelblue", "Benjamini-Hochberg" = "coral")) +
  guides(shape = guide_legend(override.aes = list(size = 4))) +
  theme(panel.grid.major = element_line(color = "gray90"),
        panel.grid.minor = element_line(color = "gray95"))
# Script fully made by Yasmine Alqanai.
