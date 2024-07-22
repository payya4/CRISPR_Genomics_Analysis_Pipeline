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

# Package Versions Needed

## Bioinformatics Tools

- **BUSCO:** version 5.7.1
- **Prokka:** version 1.14.6
- **Roary:** version 3.13
- **Scoary:** version 1.6.16
- **eggNOG-mapper:** version 2.1.12
- **EMBOSS:** version 6.6

## Programming Languages and Environments

- **Python:** version 3.8
- **R:** version 4.2.1

## Additional Dependencies

- **Miniconda:** latest version (installation script available)
- **pip:** latest version (used for Scoary installation)

#### Conda Installation

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

#### Additional Dependencies

- **R**: Ensure R is installed and accessible. You can install R via your package manager or from the [CRAN website](https://cran.r-project.org/).
- **Python**: Ensure Python is installed. You can install Python from the [official website](https://www.python.org/).

### Script Files

Lists the scripts used and where to find them. Links are provided to locate the scripts if not provided on this page.

## Quality Check with BUSCO

### CRISPR Genomes

- **Script**: `run_busco_CRISPR.sh`

### Non-CRISPR Genomes

- **Script**: `run_busco_NONCRISPR.sh`

**Note:** Increase the `START_INDEX` and `END_INDEX` values in the scripts until all directories are processed. This ensures that all genome files are analyzed in batches.


## Genome Annotation with Prokka

- **CRISPR Genomes**: `annotate_genomes_crispr.sh`
- **Non-CRISPR Genomes**: `annotate_genomes_noncrispr.sh`

## Pan-Genome Analysis with Roary

#### Script Used
- **Roary Script**: `run_roary.sh`

#### Parameters and Justification
1. **Identity Threshold**: 25%
   - The identity threshold was set to 25% to allow for the inclusion of more diverse genes, acknowledging the high genetic variability among the strains.

2. **MCL Inflation Value (IV)**: 1.4
   - An IV of 1.4 was chosen after evaluating multiple IV values (1.3, 1.4, and 1.5). This value provided a balance between sensitivity and specificity in detecting significant gene associations.
   - Higher IV values like 1.5 were too stringent and resulted in fewer core genes, while lower IV values like 1.3 were less specific.

3. **Exclusion of Archaea Strains**
   - Certain archaea strains were excluded from the analysis because their genetic divergence was significantly affecting the results, resulting in an unrealistically low number of core genes.
   - Excluded Strains:
     - Acidianus ambivalens
     - Acidianus brierleyi
     - Acidianus hospitalis
     - Acidianus manzaensis
     - Acidianus sulfidivorans

#### Results Overview
- The use of a 25% identity threshold and an IV of 1.4 yielded a more realistic distribution of core, soft core, shell, and cloud genes.
- **Statistics for the dataset with IV 1.4:**
  - Core genes: 41
  - Soft core genes: 22
  - Shell genes: 3373
  - Cloud genes: 113930
  - Total genes: 117366

#### Reasoning for Parameter Choices
- **High Genetic Diversity**: The strains in the study were highly diverse, which necessitated a lower identity threshold and the exclusion of highly divergent strains (archaea) to get meaningful core genome results.
- **Balanced Sensitivity and Specificity**: The chosen IV of 1.4 provided the best balance between detecting significant gene associations and avoiding false positives.

#### Running the Analysis
- Ensure all GFF files from Prokka are prepared and stored in the specified directory.
- Run the script `run_roary.sh` to perform the pan-genome analysis with the chosen parameters.


## Genome-Wide Association Study with Scoary

#### Scripts Used
- **Scoary Script**: `run_scoary.sh`
- **Traits File Creation**: `create_traits_file.R`

#### Traits File Creation
The traits file contains the genome identifiers and a binary indicator of CRISPR presence (1 for presence, 0 for absence). This file is used by Scoary to associate gene presence/absence with traits.

Refer to the `create_traits_file.R` script for details on creating the traits file.

#### Running Scoary
To perform the genome-wide association study with Scoary, use the `run_scoary.sh` script. This script activates the necessary conda environment, defines the input and output directories, and runs Scoary with the appropriate parameters.

Ensure you have the following files:
- `gene_presence_absence.csv` from Roary
- `traits_file.csv` created as described above

Place these files in the specified directories and execute the `run_scoary.sh` script to perform the analysis.

#### Results Overview
- The Scoary analysis associates the presence or absence of genes with the presence of CRISPR systems.
- Significant genes identified through this analysis can provide insights into the genetic basis of CRISPR presence.

#### Running the Analysis
- Ensure all necessary input files (`gene_presence_absence.csv` from Roary and `traits_file.csv`) are prepared and located in the specified directories.
- Execute the `run_scoary.sh` script to perform the association study.

# Functional Annotation with eggNOG-mapper

This section describes the steps and scripts used to perform functional annotation of significant genes using eggNOG-mapper. The process involves extracting DNA sequences, translating them to protein sequences, running eggNOG-mapper, and extracting COG and GO annotations.

## Scripts Used

- **Extraction of Gene Sequences**: `extract_gene_sequences.py`
- **Run Extraction**: `run_extraction.sh`
- **Run eggNOG-mapper**: `run_eggnog_mapper.sh`
- **Extract COG Annotations**: `extract_cog_annotations.py`
- **Extract GO Annotations**: `extract_go_annotations.py`
- **Run Extraction Scripts**: `run_extract_annotations.sh`

## Detailed Steps

### Extract DNA Sequences of Significant Genes

1. Use the `extract_gene_sequences.py` script to extract DNA sequences of significant genes from the annotation files.
2. This script reads the significant genes from the `significant_hits.csv` file and extracts their sequences from the GFF and FNA files.
3. The SLURM batch script `run_extraction.sh` is used to run the `extract_gene_sequences.py` script.

### Translate DNA to Protein Sequences

1. Use the `transeq` tool from EMBOSS to translate the extracted DNA sequences into protein sequences.
   
   **Command:**
   ```bash
   transeq -sequence /gpfs01/home/payya4/significant_genes_sequences.fasta -outseq /gpfs01/home/payya4/significant_genes_sequences_protein.fasta
## Run eggNOG-mapper

Use the `run_eggnog_mapper.sh` script to run eggNOG-mapper on the translated protein sequences. This script activates the necessary conda environment (`eggnog_env`) and runs eggNOG-mapper with the specified input and output directories.

## Extract COG and GO Annotations

After running eggNOG-mapper, use the `extract_cog_annotations.py` and `extract_go_annotations.py` scripts to extract COG and GO annotations from the eggNOG-mapper output. The SLURM batch script `run_extract_annotations.sh` is used to run the extraction scripts.

## Notes

- Ensure the conda environment `eggnog_env` is correctly set up and activated before running eggNOG-mapper.
- The input files should be in the correct format and located in the specified directories.
- The extraction scripts should be run in sequence to ensure that all necessary data is processed correctly.

### Software_and_Tools.md

Links to websites and GitHub pages associated with the tools/software used in the project. The links contain information on usage and installation.

### Credits and Acknowledgments

This project was conducted and coded by Yasmine Alqanai (myself), with guidance and support from my supervisor, James McInerney.
