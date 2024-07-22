#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=100:00:00
#SBATCH --job-name=busco_noncrisper_batch1
#SBATCH --output=/gpfs01/home/payya4/slurm-busco_noncrisper_batch1-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=payya4@exmail.nottingham.ac.uk

# Load the Conda initialization script
source /gpfs01/home/payya4/miniconda3/etc/profile.d/conda.sh

# Activate the conda environment
conda activate /gpfs01/home/payya4/miniconda3/envs/busco_env

# Directory containing the genome folders
BASE_DIR="/gpfs01/home/payya4/genomes/NON-CRISPR"
START_INDEX=0  # Start index for this batch
END_INDEX=9    # End index for this batch
COUNTER=0

# List directories
DIRS=($(ls -d "$BASE_DIR"/*))

# Loop through each directory
for DIR in "${DIRS[@]}"; do
  if [[ $COUNTER -gt $END_INDEX ]]; then
    break
  fi
  if [[ $COUNTER -ge $START_INDEX ]]; then
    for FILE in "$DIR"/*.fna; do
      if [[ -f "$FILE" ]]; then
        OUTPUT_DIR="${FILE%.fna}_busco_output"
        busco -i "$FILE" -o "$OUTPUT_DIR" --auto-lineage -m genome -f
        if [[ $? -ne 0 ]]; then
          echo "BUSCO failed for $FILE"
          exit 1
        fi
      else
        echo "No .fna files found in $DIR"
      fi
    done
  fi
  COUNTER=$((COUNTER + 1))
done

# Deactivate conda environment
conda deactivate
