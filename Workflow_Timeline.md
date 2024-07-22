# Workflow_Timeline.md

## Introduction

This document outlines the workflow timeline for the project, which aims to understand the co-occurrence of horizontally transferred genes and CRISPR genes within prokaryotic pangenomes. The analysis aims to uncover the mechanisms driving bacterial adaptation and survival in dynamic environments.

## Objectives

- To assess the quality of genomes using BUSCO.
- To annotate high-quality genomes with Prokka.
- To perform pan-genome analysis using Roary.
- To conduct genome-wide association studies (GWAS) with Scoary.
- To functionally annotate genes with eggNOG-mapper.
- To identify key genes associated with CRISPR systems and elucidate their functional roles.

## Expected Outcomes

- Identification of high-quality genomes with over 90% completeness.
- Comprehensive genome annotations.
- Definition of core and accessory genomes in the studied strains.
- Identification of genes associated with specific traits, particularly CRISPR systems.
- Functional insights into significant genes through COG and GO annotations.

### Package Installation

Lists all the packages used in the project and their versions. Detailed instructions for installing each package are provided, ensuring that users can set up their environment correctly.

## Package Versions Needed

### Bioinformatics Tools

- **BUSCO:** version 5.7.1
  - **Dependencies:**
    - Python 3.8
    - Augustus 
    - HMMER 
    - NCBI BLAST+ 

- **Prokka:** version 1.14.6
  - **Dependencies:**
    - BioPerl 
    - Prodigal 
    - Aragorn 
    - RNAmmer 
    - SignalP 
    - Infernal 

- **Roary:** version 3.13
  - **Dependencies:**
    - CD-HIT 
    - PRANK 
    - FastTree 
    - MCL 
    - Parallel 

- **Scoary:** version 1.6.16
  - **Dependencies:**
    - Python 3.8
    - SciPy 
    - NumPy 
    - pandas 
    - statsmodels 

- **eggNOG-mapper:** version 2.1.12
  - **Dependencies:**
    - Diamond 
    - HMMER 

- **EMBOSS:** version 6.6
  - **Dependencies:**
    - libxpm4
    - libpng16-16
    - libgd3

### Programming Languages and Environments

- **Python:** version 3.8
  - **Dependencies:**
    - pip (or latest available at the time of installation)

- **R:** version 4.2.1
  - **Dependencies:**
    - ggplot2 
    - dplyr 
    - topGO
      
### Conda Installation

1. **Download and install Miniconda**:
    ```bash
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh
    conda config --set auto_activate_base false
    conda deactivate
    ```

2. **Set up Conda environments for each tool**:
    - **BUSCO**:
        ```bash
        conda create -n busco_env python=3.8
        conda activate busco_env
        conda config --add channels defaults
        conda config --add channels bioconda
        conda config --add channels conda-forge
        conda install busco
        busco --help
        conda deactivate
        ```

    - **Prokka**:
        ```bash
        conda create -n prokka_env
        conda activate prokka_env
        conda config --add channels defaults
        conda config --add channels bioconda
        conda config --add channels conda-forge
        conda install prokka
        prokka --version
        conda deactivate
        ```

    - **Roary**:
        ```bash
        conda create -n roary_env python=3.7
        conda activate roary_env
        conda install -c bioconda roary
        roary -h
        conda deactivate
        ```

    - **Scoary**:
        ```bash
        conda create -n scoary_env python=3.8
        conda activate scoary_env
        pip install git+https://github.com/AdmiralenOla/Scoary.git
        scoary --version
        conda deactivate
        ```

    - **eggNOG-mapper**:
        ```bash
        conda create -n eggnog_env python=3.8
        conda activate eggnog_env
        conda install -c bioconda eggnog-mapper
        conda deactivate
        ```

### Additional Dependencies

- **R**: Ensure R is installed and accessible. You can install R via your package manager or from the [CRAN website](https://cran.r-project.org/).
- **Python**: Ensure Python is installed. You can install Python from the [official website](https://www.python.org/).

### Script Files

Lists the scripts used and where to find them. Links are provided to locate the scripts if not provided on this page.

## Quality Check with BUSCO

### CRISPR Genomes

- **Script**: `run_busco_CRISPR.sh`
- **Input Files**: Genome FASTA files (.fna)
- **Output Files**: BUSCO completeness reports

### Non-CRISPR Genomes

- **Script**: `run_busco_NONCRISPR.sh`
- **Input Files**: Genome FASTA files (.fna)
- **Output Files**: BUSCO completeness reports

**Note:** Increase the `START_INDEX` and `END_INDEX` values in the scripts until all directories are processed. This ensures that all genome files are analyzed in batches.

## Genome Annotation with Prokka

### CRISPR Genomes

- **Script**: `annotate_genomes_crispr.sh`
- **Input Files**: Genome FASTA files (.fna)
- **Output Files**: Annotated GFF3 and FASTA files

### Non-CRISPR Genomes

- **Script**: `annotate_genomes_noncrispr.sh`
- **Input Files**: Genome FASTA files (.fna)
- **Output Files**: Annotated GFF3 and FASTA files

## Pan-Genome Analysis with Roary

### Script Used

- **Roary Script**: `run_roary.sh`
- **Input Files**: GFF3 files from Prokka
- **Output Files**: `gene_presence_absence.csv`, pan-genome analysis results

### Parameters and Justification

1. **Identity Threshold**: 25%
   - Allows for the inclusion of more diverse genes, acknowledging the high genetic variability among the strains.

2. **MCL Inflation Value (IV)**: 1.4
   - Provides a balance between sensitivity and specificity in detecting significant gene associations.

3. **Exclusion of Archaea Strains**
   - Certain archaea strains were excluded due to high genetic divergence affecting the results.
   - **Excluded Strains:**
     - Acidianus ambivalens
     - Acidianus brierleyi
     - Acidianus hospitalis
     - Acidianus manzaensis
     - Acidianus sulfidivorans

### Results Overview

- **Statistics for the dataset with IV 1.4:**
  - Core genes: 41
  - Soft core genes: 22
  - Shell genes: 3373
  - Cloud genes: 113930
  - Total genes: 117366

### Reasoning for Parameter Choices

- **High Genetic Diversity**: Required a lower identity threshold and exclusion of highly divergent strains for meaningful core genome results.
- **Balanced Sensitivity and Specificity**: IV of 1.4 provided the best balance.

### Running the Analysis

- Ensure all GFF files from Prokka are prepared and stored in the specified directory.
- Run the script `run_roary.sh` to perform the pan-genome analysis with the chosen parameters.

### Figure 1: Distribution of Gene Categories
Use the `roary_bar_chart.R` script to make the graph in Figure 1. This script generates a bar chart showing the distribution of gene categories (Core genes, Soft core genes, Shell genes, Cloud genes) with a log scale on the y-axis.

**Dependencies**:
- R
- ggplot2
- dplyr

**Input**: 
- None (data is hardcoded within the script)

**Output**:
- `gene_category_distribution.png`

### Figure 2: Roary Accessory Binary Genes Tree
Use the `plot_roary.py` script to make the graph in Figure 2. This script is part of the Roary plots package, which is developed and maintained by the EMBL-European Bioinformatics Institute.

#### How to Use `plot_roary.py`

**Dependencies**:
- Python
- matplotlib
- pandas
- seaborn

**Input**:
- `roary_25_1.4_1719619195/accessory_binary_genes.fa.newick`
- `roary_25_1.4_1719619195/gene_presence_absence.csv`

**Output**:
- `accessory_binary_genes_tree.png`

1. Download the script from the official repository:

    ```sh
    wget https://raw.githubusercontent.com/sanger-pathogens/Roary/master/contrib/roary_plots/roary_plots.py
    ```

2. Ensure you have the required dependencies installed:

    ```sh
    pip install matplotlib pandas seaborn
    ```

3. Run the script to generate the plots:

    ```sh
    python roary_plots.py roary_25_1.4_1719619195/accessory_binary_genes.fa.newick roary_25_1.4_1719619195/gene_presence_absence.csv
    ```

#### License and Attribution
This script is distributed under the GNU General Public License v3.0. You can redistribute it and/or modify it under the terms of the GPL as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. The script is provided without any warranty; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

For any queries or permissions beyond the scope of the license, please contact the developers at <marco@ebi.ac.uk>.

The original script and its documentation can be found [here](https://github.com/sanger-pathogens/Roary/blob/master/contrib/roary_plots/roary_plots.py).

## Genome-Wide Association Study with Scoary

### Scripts Used

- **Scoary Script**: `run_scoary.sh`
- **Traits File Creation**: `create_traits_file.R`
- **Input Files**: 
  - `gene_presence_absence.csv` from Roary
  - `traits_file.csv` created with `create_traits_file.R`
- **Output Files**: Scoary analysis results

### Traits File Creation

The traits file contains the genome identifiers and a binary indicator of CRISPR presence (1 for presence, 0 for absence). This file is used by Scoary to associate gene presence/absence with traits.

### Running Scoary

To perform the genome-wide association study with Scoary, use the `run_scoary.sh` script. Ensure you have the necessary input files (`gene_presence_absence.csv` and `traits_file.csv`) and place them in the specified directories.

### Results Overview

- Associates the presence or absence of genes with CRISPR systems.
- Identifies significant genes providing insights into the genetic basis of CRISPR presence.

## Functional Annotation with eggNOG-mapper

### Scripts Used

- **Extraction of Gene Sequences**: `extract_gene_sequences.py`
- **Run Extraction**: `run_extraction.sh`
- **Run eggNOG-mapper**: `run_eggnog_mapper.sh`
- **Extract COG Annotations**: `extract_cog_annotations.py`
- **Extract GO Annotations**: `extract_go_annotations.py`
- **Run Extraction Scripts**: `run_extract_annotations.sh`

### Detailed Steps

#### Extract DNA Sequences of Significant Genes

1. Use the `extract_gene_sequences.py` script to extract DNA sequences of significant genes from the annotation files.
2. The script reads significant genes from the `significant_hits.csv` file and extracts sequences from the GFF and FNA files.
3. The SLURM batch script `run_extraction.sh` runs the `extract_gene_sequences.py` script.

#### Translate DNA to Protein Sequences

1. Use the `transeq` tool from EMBOSS to translate the extracted DNA sequences into protein sequences.
   
   **Command:**
   ```bash
   transeq -sequence /path/to/significant_genes_sequences.fasta -outseq /path/to/significant_genes_sequences_protein.fasta



## Run eggNOG-mapper

Use the `run_eggnog_mapper.sh` script to run eggNOG-mapper on the translated protein sequences. This script activates the necessary conda environment (`eggnog_env`) and runs eggNOG-mapper with the specified input and output directories.

## Extract COG and GO Annotations

After running eggNOG-mapper, use the `extract_cog_annotations.py` and `extract_go_annotations.py` scripts to extract COG and GO annotations from the eggNOG-mapper output. The SLURM batch script `run_extract_annotations.sh` is used to run the extraction scripts.
# Gene Annotation and Enrichment Analysis Workflow

## Run eggNOG-mapper

Use the `run_eggnog_mapper.sh` script to run eggNOG-mapper on the translated protein sequences. This script activates the necessary conda environment (`eggnog_env`) and runs eggNOG-mapper with the specified input and output directories.

## Extract COG and GO Annotations

After running eggNOG-mapper, use the `extract_cog_annotations.py` and `extract_go_annotations.py` scripts to extract COG and GO annotations from the eggNOG-mapper output. The SLURM batch script `run_extract_annotations.sh` is used to run the extraction scripts.

### Python Script to Extract COG Annotations

- **Script**: `extract_cog_annotations.py`
- **Description**: This script reads the eggNOG-mapper annotations file and extracts the COG annotations for each gene, saving the results to a file.

### Python Script to Extract GO Annotations

- **Script**: `extract_go_annotations.py`
- **Description**: This script reads the eggNOG-mapper annotations file and extracts the GO annotations for each gene, saving the results to a file.

### SLURM Batch Script to Run the Python Scripts

- **Script**: `run_extract_annotations.sh`
- **Description**: This SLURM script is used to run the `extract_cog_annotations.py` and `extract_go_annotations.py` scripts on a computing cluster.

## Categorize Genes

### Python Script to Categorize Genes

- **Script**: `categorize_genes.py`
- **Description**: This script parses GFF files, matches gene names against significant genes, and collects the corresponding gene IDs. The script differentiates between CRISPR and non-CRISPR strains and saves the gene IDs to separate files.

## Enrichment Analysis for COGs

### Combine Gene IDs

- **Command**: `cat ~/output_crispr_genes.txt ~/output_non_crispr_genes.txt > ~/combined_gene_ids.txt`
- **Description**: This command concatenates the CRISPR and non-CRISPR gene ID files into a single file for combined analysis.

### Python Script for COG Enrichment Analysis

- **Script**: `cog_enrichment_analysis_combined.py`
- **Description**: This script performs COG enrichment analysis on the combined gene IDs using Fisher's exact test and adjusts p-values for multiple testing. Significant COG categories are identified and saved to a file.

#### Combined Analysis

In the combined analysis of CRISPR and non-CRISPR genes, two significant COG categories were identified:

- `MU`: Adjusted p-value = 0.020681
- `TZ`: Adjusted p-value = 0.041364


## GO Enrichment Analysis

Use topGO to perform GO enrichment analysis in R.

### Conda Environment Activation

- **Command**: `conda activate scoary_analysis`
- **Description**: Activate the conda environment used for the analysis.

### Python Script to Correct `gene2go.map`

- **Script**: `correct_gene2go.py`
- **Description**: This script corrects the `gene2go.map` file by replacing semicolons with commas and removing the `_1` suffix from gene IDs.

### R Script for GO Enrichment Analysis

- **Script**: `go_enrichment_analysis.R`
- **Description**: This R script uses the topGO package to perform GO enrichment analysis on the corrected `gene2go.map` file. It generates a results table and saves it to a CSV file.

### Figures 3 and 4: COG Category Counts and Significant COG Categories

**Dependencies**:
- R
- ggplot2
- dplyr

**Inputs**:
- `~/Desktop/eggnog_output/gene2cog.map`
- `~/Desktop/eggnog_output/significant_cogs_combined.csv`

**Outputs**:
- `~/Desktop/eggnog_output/cog_category_counts_filtered.png`
- `~/Desktop/eggnog_output/significant_cog_categories_filtered.png`


- **Script**: `visualize_cogs.py`
- **Description**: This script generates visualizations of the COG category counts and significant COG categories using matplotlib.

### Figure 5: R Script for Visualization of GO Enrichment

**Dependencies**:
- R
- ggplot2
- dplyr

**Input**:
- `~/Desktop/go_enrichment_results.csv`

**Output**:
- `~/Desktop/top_go_terms_enriched.png`

- **Script**: `visualize_go_enrichment.R`
- **Description**: This script generates a bar chart of the top GO terms enriched in significant genes using ggplot2.

## Notes

- Ensure the conda environment `eggnog_env` is correctly set up and activated before running eggNOG-mapper.
- The input files should be in the correct format and located in the specified directories.
- The extraction scripts should be run in sequence to ensure that all necessary data is processed correctly.



### Supplementary Figures




