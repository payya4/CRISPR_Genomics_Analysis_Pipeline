#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=100:00:00  # Adjust time limit if necessary
#SBATCH --job-name=extract_annotations
#SBATCH --output=/gpfs01/home/payya4/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=payya4@exmail.nottingham.ac.uk

# Load necessary modules or activate your conda environment
source /gpfs01/home/payya4/miniconda3/etc/profile.d/conda.sh
conda activate eggnog_env

# Run the Python scripts
python /gpfs01/home/payya4/extract_cog_annotations.py
python /gpfs01/home/payya4/extract_go_annotations.py

# Script fully made by Yasmine Alqanai.
