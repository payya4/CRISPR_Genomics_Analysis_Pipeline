import os
from BCBio import GFF
import pandas as pd

# Define paths
gff_dir = os.path.expanduser("~/gff_all_new")
traits_file = os.path.expanduser("~/traits_file.csv")
output_crispr_genes = os.path.expanduser("~/output_crispr_genes.txt")
output_non_crispr_genes = os.path.expanduser("~/output_non_crispr_genes.txt")
significant_genes_file = os.path.expanduser("~/significant_genes.txt")

# Load the traits file
traits_df = pd.read_csv(traits_file)

# Load significant genes
with open(significant_genes_file, 'r') as f:
    significant_genes = set(line.strip() for line in f)

# Identify CRISPR and non-CRISPR strains
crispr_strains = traits_df[traits_df['CRISPR_Presence'] == 1]['Name'].tolist()
non_crispr_strains = traits_df[traits_df['CRISPR_Presence'] == 0]['Name'].tolist()

# Function to parse GFF files and collect gene IDs by matching significant gene names
def parse_gff(gff_file):
    ids = set()
    try:
        with open(gff_file) as handle:
            for rec in GFF.parse(handle):
                for feature in rec.features:
                    if feature.type == "CDS":
                        gene_id = feature.qualifiers.get("ID", [""])[0]
                        gene_name = feature.qualifiers.get("gene", [""])[0]
                        if gene_name in significant_genes:
                            ids.add(gene_id)
    except Exception as e:
        print(f"Error parsing {gff_file}: {e}")
    return ids

# Collect gene IDs for CRISPR and non-CRISPR strains
crispr_ids = set()
non_crispr_ids = set()

for root, dirs, files in os.walk(gff_dir):
    for file in files:
        if file.endswith(".gff"):
            gff_path = os.path.join(root, file)
            strain_id = os.path.splitext(file)[0]
            if strain_id in crispr_strains:
                crispr_ids.update(parse_gff(gff_path))
            elif strain_id in non_crispr_strains:
                non_crispr_ids.update(parse_gff(gff_path))

# Save the gene IDs to files
with open(output_crispr_genes, 'w') as f:
    for gene_id in crispr_ids:
        f.write(f"{gene_id}\n")

with open(output_non_crispr_genes, 'w') as f:
    for gene_id in non_crispr_ids:
        f.write(f"{gene_id}\n")

# Verify the output
print(f"Number of significant CRISPR gene IDs collected: {len(crispr_ids)}")
print(f"Number of significant non-CRISPR gene IDs collected: {len(non_crispr_ids)}")

# Script fully made by Yasmine Alqanai. 
