# Load necessary libraries
library(ggplot2)
library(dplyr)

# Create the data frame
gene_data <- data.frame(
  category = c("Core genes", "Soft core genes", "Shell genes", "Cloud genes"),
  count = c(41, 22, 3373, 113930)
)

# Create the bar chart with log scale and centered title
ggplot(gene_data, aes(x = category, y = count, fill = category)) +
  geom_bar(stat = "identity") +
  scale_y_log10() +
  labs(title = "Distribution of Gene Categories",
       x = "Gene Category",
       y = "Count (log scale)",
       fill = "Gene Category") +
  geom_text(aes(label = count), vjust = -0.3) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
