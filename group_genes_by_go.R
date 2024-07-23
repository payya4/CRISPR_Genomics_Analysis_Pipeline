# Load necessary libraries
library(dplyr)
library(tidyr)

# Load your data
scoary_results <- read.csv("~/Desktop/filtered_data_1.4_new.csv")
eggnog_annotations <- read.delim("~/Desktop/eggnog_output/eggnog_results.emapper.annotations", 
                                 header = TRUE, sep = "\t", comment.char = "", skip = 4)
go_enrichment_results <- read.csv("~/Desktop/go_enrichment_results.csv")

# Extract relevant columns
genes <- scoary_results$Gene
odds_ratios <- scoary_results$Odds_ratio
bonferroni_pvalues <- scoary_results$Bonferroni_p

# Create a data frame
data_frame <- data.frame(gene = genes, odds_ratio = odds_ratios, bonferroni_p = bonferroni_pvalues)

# Filter significant genes (Bonferroni corrected p-value < 0.05)
significant_results <- data_frame %>%
  filter(bonferroni_p < 0.0000000001)

# Select top 3000 significant genes based on p-value
top_genes <- significant_results %>%
  arrange(bonferroni_p) %>%
  head(3000)

# Replace Inf values with a large finite number
max_finite_odds_ratio <- max(top_genes$odds_ratio[is.finite(top_genes$odds_ratio)], na.rm = TRUE) * 1.5
top_genes <- top_genes %>%
  mutate(odds_ratio = ifelse(is.infinite(odds_ratio), max_finite_odds_ratio, odds_ratio))

# Filter out odds ratios that are less than or equal to 0.01 and arrange in ascending order
top_genes <- top_genes %>%
  filter(odds_ratio > 40) %>%
  arrange(odds_ratio)

# Create a matrix for odds ratios
odds_matrix <- matrix(top_genes$odds_ratio, nrow = length(top_genes$gene), ncol = 1)
rownames(odds_matrix) <- top_genes$gene
colnames(odds_matrix) <- "Odds_Ratio"

# Check if Preferred_name is among significant genes and list comma-separated genes associated with each GO term
significant_gene_annotations <- eggnog_annotations %>%
  filter(Preferred_name %in% top_genes$gene) %>%
  select(Preferred_name, GOs) %>%
  mutate(GOs = strsplit(as.character(GOs), ",")) %>% # Split GOs into separate rows
  unnest(GOs) %>% # Unnest the list columns
  filter(GOs != "") # Remove empty GO terms

# Add GO terms descriptions
significant_gene_annotations <- significant_gene_annotations %>%
  left_join(go_enrichment_results, by = c("GOs" = "GO.ID")) %>%
  select(Preferred_name, GOs, Term)

# Group by GO terms and ensure no duplicates within each category
grouped_genes_by_go <- significant_gene_annotations %>%
  group_by(Term) %>%
  summarise(genes = paste(unique(Preferred_name), collapse = ", "))

# Save the grouped data to a CSV file
write.csv(grouped_genes_by_go, "~/Desktop/grouped_genes_by_go.csv", row.names = FALSE)

# Print the grouped data
print(grouped_genes_by_go)

# Script fully made by Yasmine Alqanai.
