#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=100:00:00  
#SBATCH --job-name=scoary_new
#SBATCH --output=/gpfs01/home/payya4/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=payya4@exmail.nottingham.ac.uk

# Load the Conda initialization script
source /gpfs01/home/payya4/miniconda3/etc/profile.d/conda.sh

# Activate the conda environment
conda activate scoary_env

# Define variables
roary_output="/gpfs01/home/payya4/roary_25_1.4_1719619195"
traits_file="/gpfs01/home/payya4/traits_file.csv"
output_directory="/gpfs01/home/payya4/scoary_25_1.4_output_new"

# Run Scoary
scoary -g $roary_output/gene_presence_absence.csv -t $traits_file -o $output_directory

# Deactivate conda environment
conda deactivate
