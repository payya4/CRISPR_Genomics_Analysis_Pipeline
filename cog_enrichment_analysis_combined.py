import pandas as pd
from scipy.stats import fisher_exact

# Function to normalize and adjust gene IDs
def adjust_gene_ids(gene_ids):
    return gene_ids.str.strip().str.upper() + '_1'

# Load gene to COG mapping and combined gene IDs
gene2cog = pd.read_csv('/gpfs01/home/payya4/eggnog_output/gene2cog.map', sep=' ', header=None, names=['gene', 'cog'])
combined_gene_ids = pd.read_csv('/gpfs01/home/payya4/combined_gene_ids.txt', header=None, names=['gene'])

# Adjust gene IDs to match format in gene2cog.map
gene2cog['gene'] = gene2cog['gene'].str.strip().str.upper()
combined_gene_ids['gene'] = adjust_gene_ids(combined_gene_ids['gene'])

# Check the number of genes and adjusted gene IDs
print(f"Total genes in gene2cog: {gene2cog['gene'].nunique()}")
print(f"Total combined gene IDs: {combined_gene_ids['gene'].nunique()}")

# Ensure there is overlap between adjusted gene IDs and gene2cog mapping
overlap_genes = gene2cog[gene2cog['gene'].isin(combined_gene_ids['gene'])]
print(f"Overlap genes count: {overlap_genes['gene'].nunique()}")

# If no overlap genes, check why
if overlap_genes.empty:
    print("No overlap found between combined gene IDs and gene2cog map. Possible reasons:")
    print("- Gene names in combined_gene_ids.txt do not match those in gene2cog.map.")
    print("- Gene names might have different identifiers or formats.")

# Create a table of COG category counts
cog_counts = gene2cog['cog'].value_counts().reset_index()
cog_counts.columns = ['cog', 'count']

# Count COG categories in adjusted gene IDs
adjusted_cog_counts = gene2cog[gene2cog['gene'].isin(combined_gene_ids['gene'])]['cog'].value_counts().reset_index()
adjusted_cog_counts.columns = ['cog', 'combined_count']

# Print the counts for debugging
print("COG counts for all genes:")
print(cog_counts)
print("COG counts for combined gene IDs:")
print(adjusted_cog_counts)

# Merge and fill missing values with 0
cog_enrichment = pd.merge(cog_counts, adjusted_cog_counts, on='cog', how='left').fillna(0)

# Perform Fisher's exact test
def fisher_test(row, total_genes, total_combined):
    table = [
        [row['combined_count'], total_combined - row['combined_count']],
        [row['count'], total_genes - row['count']]
    ]
    _, p_value = fisher_exact(table, alternative='greater')
    return p_value

total_genes = gene2cog['gene'].nunique()
total_combined = combined_gene_ids['gene'].nunique()
cog_enrichment['p_value'] = cog_enrichment.apply(fisher_test, axis=1, total_genes=total_genes, total_combined=total_combined)

# Adjust p-values for multiple testing (Benjamini-Hochberg)
cog_enrichment['adj_p_value'] = cog_enrichment['p_value'].rank(method='first') * cog_enrichment['p_value'] / len(cog_enrichment)

# Filter significant COG categories
significant_cogs = cog_enrichment[cog_enrichment['adj_p_value'] < 0.05]

# Print significant COG categories
print("Significant COG categories:")
print(significant_cogs)

# Save results to a file
significant_cogs.to_csv('/gpfs01/home/payya4/eggnog_output/significant_cogs_combined.csv', index=False)
