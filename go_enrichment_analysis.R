# Set a CRAN mirror
options(repos = c(CRAN = "https://cran.rstudio.com"))

# Install and load required packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("topGO")
library(topGO)

# Load the corrected gene-to-GO mapping file
gene2GO <- readMappings(file = "~/Desktop/eggnog_output/corrected_gene2go.map")

# Read CRISPR and non-CRISPR gene lists
crispr_genes <- read.table("~/Desktop/output_crispr_genes.txt", header = FALSE, stringsAsFactors = FALSE)$V1
non_crispr_genes <- read.table("~/Desktop/output_non_crispr_genes.txt", header = FALSE, stringsAsFactors = FALSE)$V1

# Combine and label genes
all_genes <- unique(c(crispr_genes, non_crispr_genes))
gene_list <- factor(as.integer(all_genes %in% crispr_genes))
names(gene_list) <- all_genes

# Ensure gene_list has 2 levels
if(length(levels(gene_list)) != 2){
  gene_list <- factor(gene_list, levels = c(0, 1))
}

# Create a topGOdata object
GOdata <- new("topGOdata",
              ontology = "BP",  # Choose BP, MF, or CC
              allGenes = gene_list,
              geneSelectionFun = function(x) (x == 1),
              annot = annFUN.gene2GO, 
              gene2GO = gene2GO)

# Print summary of GOdata
print(GOdata)

# Run enrichment tests
resultFisher <- runTest(GOdata, algorithm = "classic", statistic = "fisher")
resultKS <- runTest(GOdata, algorithm = "classic", statistic = "ks")
resultKS.elim <- runTest(GOdata, algorithm = "elim", statistic = "ks")

# Generate results table
allRes <- GenTable(GOdata, classicFisher = resultFisher, classicKS = resultKS, elimKS = resultKS.elim,
                   orderBy = "classicFisher", topNodes = 50)

# Print results
print(allRes)

# Save results to a CSV file
write.csv(allRes, file = "~/Desktop/go_enrichment_results.csv", row.names = FALSE)
