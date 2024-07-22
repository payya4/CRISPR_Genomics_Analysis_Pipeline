# CRISPR_Genomics_Analysis_Pipeline
This repository includes the code and steps required to conduct the CRISPR genomics project.

## Contents of the Files

### Workflow_Timeline.md

#### Introduction
Provides a brief overview of the problem being addressed and the importance of CRISPR-related research.

#### Objectives
Outlines the goals of the analysis, including:
- Quality check with BUSCO
- Genome annotation with Prokka
- Pan-genome analysis with Roary
- Genome-wide association studies with Scoary
- COG and GO enrichment analysis with eggNOG-mapper

#### Expected Outcomes
Describes the anticipated results of the project, such as identifying core and accessory genes, significant genetic variations associated with phenotypic traits, and enriched functional categories.

### Package Installation

Lists all the packages used in the project and their versions. Detailed instructions for installing each package are provided, ensuring that users can set up their environment correctly.

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


#### Genome Annotation with Prokka

- **CRISPR Genomes**: `annotate_genomes_crispr.sh`
- **Non-CRISPR Genomes**: `annotate_genomes_noncrispr.sh`

### Pan-Genome Analysis with Roary

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


### Genome-Wide Association Study with Scoary

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

#### COG and GO Enrichment Analysis with eggNOG-mapper

- **Script**: `run_eggnog_mapper.sh`
- **Annotation Extraction**: `extract_annotations.sh`

### Data Analysis

The input and output of each step are described here, along with the names of the scripts for each step.

#### Input Data
- **Genome Sequences**: FASTA format (.fna)
- **Annotation Files**: GFF3 files generated by Prokka

#### Output Data
- **BUSCO**: Genome completeness reports
- **Prokka**: Annotated genomes
- **Roary**: Pan-genome analysis results
- **Scoary**: Genome-wide association results
- **eggNOG-mapper**: COG and GO annotations

### Software_and_Tools.md

Links to websites and GitHub pages associated with the tools/software used in the project. The links contain information on usage and installation.

### Credits and Acknowledgments

This project was conducted and coded by Yasmine Alqanai (myself), with guidance and support from my supervisor, James McInerney.
