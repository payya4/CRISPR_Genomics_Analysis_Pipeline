# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load your data
grouped_genes_by_go <- read.csv("~/Desktop/grouped_genes_by_go.csv")

# Calculate the number of genes associated with each GO term
grouped_genes_by_go <- grouped_genes_by_go %>%
  mutate(gene_count = sapply(strsplit(genes, ", "), length))

# Plot the bar chart
ggplot(grouped_genes_by_go, aes(x = reorder(Term, gene_count), y = gene_count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Number of Genes Associated with Each GO Term",
       x = "GO Term",
       y = "Number of Genes") +
  theme(axis.text.y = element_text(size = 8),
        axis.title.y = element_blank())

# Script fully made by Yasmine Alqanai.
