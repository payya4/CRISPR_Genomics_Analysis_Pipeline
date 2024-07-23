#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=100:00:00  # Adjust time limit if necessary
#SBATCH --job-name=extracting_gene_sequences
#SBATCH --output=/gpfs01/home/payya4/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=payya4@exmail.nottingham.ac.uk

# Load the Conda initialization script
source /gpfs01/home/payya4/miniconda3/etc/profile.d/conda.sh

# Activate the new Conda environment
conda activate gene_extraction_env

# Run the Python script
python /gpfs01/home/payya4/extract_gene_sequences.py

# Script fully made by Yasmine Alqanai.
