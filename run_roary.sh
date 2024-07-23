#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=100:00:00
#SBATCH --job-name=roary_25_new
#SBATCH --output=/gpfs01/home/payya4/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=payya4@exmail.nottingham.ac.uk

# Load the Conda initialization script
source /gpfs01/home/payya4/miniconda3/etc/profile.d/conda.sh

# Activate the conda environment
conda activate /gpfs01/home/payya4/miniconda3/envs/roary_env

# Create directories for each analysis
mkdir -p roary_25_1.5 roary_25_1.4 roary_25_1.3

# Path to GFF files excluding specified archaea
GFF_PATH="/gpfs01/home/payya4/gff_all_new"
EXCLUDE=("Acidianus_ambivalens_output_GCF_009729015.1_ASM972901v1_genomic_PROKKA_06022024.gff"
         "Acidianus_brierleyi_output_GCF_003201835.2_ASM320183v2_genomic_PROKKA_06022024.gff"
         "Acidianus_hospitalis_output_GCF_000213215.1_ASM21321v1_genomic_PROKKA_06022024.gff"
         "Acidianus_manzaensis_output_GCF_002116695.1_ASM211669v1_genomic_PROKKA_06022024.gff"
         "Acidianus_sulfidivorans_output_GCF_003201765.2_ASM320176v2_genomic_PROKKA_06022024.gff")

# Filter GFF files
GFF_FILES=$(find $GFF_PATH -name "*.gff" | grep -v -E "$(IFS=\|; echo "${EXCLUDE[*]}")")

# Run Roary at 25% with MCL inflation value 1.5
echo "Running Roary at 25% with MCL inflation value 1.5..."
roary -p 16 -i 25 -iv 1.5 -f roary_25_1.5 $GFF_FILES

# Run Roary at 25% with MCL inflation value 1.4
echo "Running Roary at 25% with MCL inflation value 1.4..."
roary -p 16 -i 25 -iv 1.4 -f roary_25_1.4 $GFF_FILES

# Run Roary at 25% with MCL inflation value 1.3
echo "Running Roary at 25% with MCL inflation value 1.3..."
roary -p 16 -i 25 -iv 1.3 -f roary_25_1.3 $GFF_FILES

echo "Roary 25% identity analysis completed."

# Script fully made by Yasmine Alqanai.
