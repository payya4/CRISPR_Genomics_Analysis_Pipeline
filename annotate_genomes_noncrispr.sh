#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=10:00:00
#SBATCH --job-name=prokka_non_crispr
#SBATCH --output=/gpfs01/home/payya4/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=payya4@exmail.nottingham.ac.uk

# Load the Conda initialization script
source /gpfs01/home/payya4/miniconda3/etc/profile.d/conda.sh

# Activate the conda environment
conda activate /gpfs01/home/payya4/miniconda3/envs/prokka_env  

# Define an associative array to map organism names to their respective kingdom, genus, and species
#List co-piloted by AI to expedite the process of listing this information 
declare -A organism_info
organism_info["Acetobacter_pasteurianus"]="Bacteria Enterobacter cloacae"
organism_info["Acinetobacter_baumannii"]="Bacteria Haemophilus influenzae"
organism_info["Acinetobacter_indicus"]="Bacteria Helicobacter pylori"
organism_info["Acinetobacter_johnsonii"]="Bacteria Histophilus somni"
organism_info["Acinetobacter_lwoffii"]="Bacteria Klebsiella pneumoniae"
organism_info["Acinetobacter_pittii"]="Bacteria Legionella pneumophila"
organism_info["Acinetobacter_schindleri"]="Bacteria Paracidovorax citrulli"
organism_info["Acinetobacter_seifertii"]="Bacteria Proteus mirabilis"
organism_info["Bacillus_amyloliquefaciens"]="Bacteria Pseudomonas aeruginosa"
organism_info["Campylobacter_volucris"]="Bacteria Shigella flexneri"
organism_info["Candidatus_Pseudomonas_adelgestsugas"]="Bacteria Vibrio parahaemolyticus"
organism_info["Chlamydia_pneumoniae"]="Bacteria Xanthomonas oryzae"
organism_info["Citrobacter_freundii"]="Bacteria Yersinia enterocolitica"
organism_info["Enterobacter_cloacae"]="Bacteria Enterobacter cloacae"
organism_info["Haemophilus_influenzae"]="Bacteria Haemophilus influenzae"
organism_info["Helicobacter_pylori"]="Bacteria Helicobacter pylori"
organism_info["Histophilus_somni"]="Bacteria Histophilus somni"
organism_info["Klebsiella_pneumoniae"]="Bacteria Klebsiella pneumoniae"
organism_info["Legionella_pneumophila"]="Bacteria Legionella pneumophila"
organism_info["Paracidovorax_citrulli"]="Bacteria Paracidovorax citrulli"
organism_info["Proteus_mirabilis"]="Bacteria Proteus mirabilis"
organism_info["Pseudomonas_aeruginosa"]="Bacteria Pseudomonas aeruginosa"
organism_info["Shigella_flexneri"]="Bacteria Shigella flexneri"
organism_info["Vibrio_parahaemolyticus"]="Bacteria Vibrio parahaemolyticus"
organism_info["Xanthomonas_oryzae"]="Bacteria Xanthomonas oryzae"
organism_info["Yersinia_enterocolitica"]="Bacteria Yersinia enterocolitica"

# Set the path to the directory containing the files
input_dir="/gpfs01/home/payya4/genomes/NON-CRISPR"

# Loop through each organism and its information
for organism in "${!organism_info[@]}"; do
    kingdom=$(echo "${organism_info[$organism]}" | awk '{print $1}')
    genus=$(echo "${organism_info[$organism]}" | awk '{print $2}')
    species=$(echo "${organism_info[$organism]}" | awk '{print $3}')

    # Create an output directory for the organism
    organism_out="${input_dir}/${organism}_output"
    mkdir -p "$organism_out"

    # Loop through each .fna file for the organism
    for fna_file in "$input_dir/$organism"/*.fna; do
        # Extract the file name without the extension
        base_name=$(basename "$fna_file" .fna)
        
        # Set the specific output directory for the current .fna file
        file_out_dir="$organism_out/$base_name"
        mkdir -p "$file_out_dir"
    
        # Run Prokka for annotation
        prokka --outdir "$file_out_dir" \
         --kingdom "$kingdom" \
         --genus "$genus" \
         --species "$species" \
         --force \
         "$fna_file"
    done
done

# Deactivate conda
conda deactivate

#Script made by Yasmine Alqanai with the exception of the list commented declaring the use of AI.
