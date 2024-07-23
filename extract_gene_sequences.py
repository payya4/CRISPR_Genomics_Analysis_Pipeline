import os
from Bio import SeqIO
from BCBio import GFF

# Directory paths
gff_dir = "/gpfs01/home/payya4/gff_all_new/"
crispr_fna_dir = "/gpfs01/home/payya4/genomes/CRISPR/"
non_crispr_fna_dir = "/gpfs01/home/payya4/genomes/NON-CRISPR/"
output_file = "/gpfs01/home/payya4/significant_genes_sequences.fasta"

# Read significant genes
significant_genes_file = "/gpfs01/home/payya4/scoary_filtered/significant_hits.csv"
significant_genes = set()
with open(significant_genes_file, 'r') as f:
    next(f)  # Skip header
    for line in f:
        significant_genes.add(line.strip().split(',')[0])

print(f"Significant genes: {significant_genes}")

def find_fna_file(gff_file, fna_base_dirs):
    """Find the corresponding .fna file for a given .gff file."""
    # Extract the organism directory and GCF number from the .gff filename
    parts = os.path.basename(gff_file).split('_')
    organism_name = "_".join(parts[0:parts.index('output')])
    gcf_number = parts[parts.index('GCF') + 1]

    for fna_base_dir in fna_base_dirs:
        organism_dir = os.path.join(fna_base_dir, organism_name)
        if os.path.isdir(organism_dir):
            for root, dirs, files in os.walk(organism_dir):
                for file in files:
                    if file.endswith(".fna") and gcf_number in file:
                        return os.path.join(root, file)
    return None

def process_gff_files(gff_dir, fna_base_dirs):
    for root, dirs, files in os.walk(gff_dir):
        for gff_file in files:
            if gff_file.endswith(".gff"):
                gff_path = os.path.join(root, gff_file)
                fna_file = find_fna_file(gff_path, fna_base_dirs)

                if not fna_file:
                    print(f"No FNA file found for {gff_file}")
                    continue

                print(f"Processing GFF file: {gff_file}")
                print(f"Corresponding FNA file: {fna_file}")

                # Parse GFF and FNA files
                with open(gff_path) as gff_handle, open(fna_file) as fna_handle:
                    sequences = SeqIO.to_dict(SeqIO.parse(fna_handle, "fasta"))
                    for rec in GFF.parse(gff_handle, base_dict=sequences):
                        for feature in rec.features:
                            if feature.type == "CDS":
                                gene_id = feature.qualifiers.get("ID", [""])[0]
                                gene_name = feature.qualifiers.get("gene", [""])[0]
                                if gene_id in significant_genes or gene_name in significant_genes:
                                    print(f"Found significant gene: {gene_id or gene_name} in {gff_file}")
                                    gene_sequence = feature.extract(rec)
                                    gene_sequence.id = gene_id or gene_name  # Set the ID of the sequence
                                    gene_sequence.description = ""  # Clear the description
                                    print(f"Extracted sequence: {gene_sequence.seq}")
                                    with open(output_file, "a") as out_fasta:
                                        SeqIO.write(gene_sequence, out_fasta, "fasta")

# Ensure the output file is empty before writing
with open(output_file, "w") as out_fasta:
    pass

# Process all GFF files
process_gff_files(gff_dir, [crispr_fna_dir, non_crispr_fna_dir])

# Script fully made by Yasmine Alqanai.
