import pandas as pd
import matplotlib.pyplot as plt

# Load COG counts
cog_counts = pd.read_csv('~/Desktop/eggnog_output/gene2cog.map', sep=' ', header=None, names=['gene', 'cog'])

# Filter out the dash category
cog_counts = cog_counts[cog_counts['cog'] != '-']

# Bar chart for COG category counts
cog_count_summary = cog_counts['cog'].value_counts().reset_index()
cog_count_summary.columns = ['cog', 'count']
plt.figure(figsize=(14, 8))
plt.bar(cog_count_summary['cog'], cog_count_summary['count'])
plt.title('COG Category Counts')
plt.xlabel('COG Category')
plt.ylabel('Count')
plt.xticks(rotation=90)
plt.grid(axis='y')
plt.savefig("~/Desktop/eggnog_output/cog_category_counts_filtered.png")
plt.show()

# Load significant COGs
significant_cogs = pd.read_csv('~/Desktop/eggnog_output/significant_cogs_combined.csv')

# Filter out the dash category
significant_cogs = significant_cogs[significant_cogs['cog'] != '-']

# Enrichment plot
plt.figure(figsize=(10, 6))
plt.bar(significant_cogs['cog'], significant_cogs['adj_p_value'])
plt.axhline(y=0.05, color='r', linestyle='--')  # Significance threshold
plt.title('Significant COG Categories')
plt.xlabel('COG Category')
plt.ylabel('Adjusted p-value')
plt.xticks(rotation=45)
plt.savefig("Desktop/eggnog_output/significant_cog_categories_filtered.png")
plt.show()
