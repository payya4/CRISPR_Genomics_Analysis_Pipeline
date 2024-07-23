#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=100:00:00  
#SBATCH --job-name=eggnog_mapper
#SBATCH --output=/gpfs01/home/payya4/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=payya4@exmail.nottingham.ac.uk

# Load necessary modules or activate your conda environment
source /gpfs01/home/payya4/miniconda3/etc/profile.d/conda.sh
conda activate eggnog_env

# Run eggNOG-mapper
emapper.py -i /gpfs01/home/payya4/significant_genes_sequences_protein.fasta -o /gpfs01/home/payya4/eggnog_output/eggnog_results --data_dir /gpfs01/home/payya4/eggnog-mapper/data

# Script fully made by Yasmine Alqanai.
