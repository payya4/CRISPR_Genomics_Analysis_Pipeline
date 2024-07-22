import os

# Define paths
gene2go_file = os.path.expanduser("~/eggnog_output/gene2go.map")
corrected_gene2go_file = os.path.expanduser("~/eggnog_output/corrected_gene2go.map")

# Read and correct the gene2go map
with open(gene2go_file, 'r') as infile, open(corrected_gene2go_file, 'w') as outfile:
    for line in infile:
        parts = line.strip().split()
        if len(parts) == 2:
            gene_id = parts[0].rstrip('_1')  # Remove _1 suffix
            go_terms = parts[1].replace(';', ',')
            outfile.write(f"{gene_id}\t{go_terms}\n")
        else:
            print(f"Skipping malformed line: {line}")

print(f"Corrected gene2go map saved to: {corrected_gene2go_file}")
