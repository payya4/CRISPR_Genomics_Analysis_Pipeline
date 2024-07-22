# Project README

## Contents of the Files

### Workflow_Timeline.md

#### Introduction
Overview of the analysis on horizontally transferred genes and CRISPR genes in prokaryotic pangenomes.

#### Objectives
Goals including:
- Genome quality assessment
- Genome annotation
- Pan-genome analysis
- Genome-wide association studies (GWAS)
- Functional annotation

#### Expected Outcomes
Results such as:
- High-quality genome identification
- Comprehensive annotations
- Core/accessory genome definitions
- Functional insights

### Package Installation

- **BUSCO**: version 5.7.1
  - **Dependencies**: 
    - Python 3.8
    - Augustus
    - HMMER
    - NCBI BLAST+
- **Prokka**: version 1.14.6
  - **Dependencies**: 
    - BioPerl
    - Prodigal
    - Aragorn
    - RNAmmer
    - SignalP
    - Infernal
- **Roary**: version 3.13
  - **Dependencies**: 
    - CD-HIT
    - PRANK
    - FastTree
    - MCL
    - Parallel
- **Scoary**: version 1.6.16
  - **Dependencies**: 
    - Python 3.8
    - SciPy
    - NumPy
    - pandas
    - statsmodels
- **eggNOG-mapper**: version 2.1.12
  - **Dependencies**: 
    - Diamond
    - HMMER
- **EMBOSS**: version 6.6
  - **Dependencies**: 
    - libxpm4
    - libpng16-16
    - libgd3
- **Python**: version 3.8
  - **Dependencies**: 
    - pip (or latest available at the time of installation)
- **R**: version 4.2.1
  - **Dependencies**: 
    - ggplot2
    - dplyr
    - tidyr
    - topGO
- **Miniconda**: latest version
- **pip**: latest version


### Script Files

#### BUSCO Quality Check

- **CRISPR Genomes**: `run_busco_CRISPR.sh`
  - **Purpose**: Assess genome quality of CRISPR genomes
  - **Input Files**: Genome FASTA files (.fna)
  - **Output Files**: BUSCO completeness reports

- **Non-CRISPR Genomes**: `run_busco_NONCRISPR.sh`
  - **Purpose**: Assess genome quality of non-CRISPR genomes
  - **Input Files**: Genome FASTA files (.fna)
  - **Output Files**: BUSCO completeness reports

#### Prokka Annotation

- **CRISPR Genomes**: `annotate_genomes_crispr.sh`
  - **Purpose**: Annotate CRISPR genomes
  - **Input Files**: Genome FASTA files (.fna)
  - **Output Files**: Annotated GFF3 and FASTA files

- **Non-CRISPR Genomes**: `annotate_genomes_noncrispr.sh`
  - **Purpose**: Annotate non-CRISPR genomes
  - **Input Files**: Genome FASTA files (.fna)
  - **Output Files**: Annotated GFF3 and FASTA files

#### Roary Pan-Genome Analysis

- **Script**: `run_roary.sh`
  - **Purpose**: Perform pan-genome analysis
  - **Input Files**: GFF3 files from Prokka
  - **Output Files**: `gene_presence_absence.csv`, pan-genome analysis results

#### Scoary GWAS

- **Script**: `run_scoary.sh`
  - **Purpose**: Conduct genome-wide association studies (GWAS)
  - **Input Files**: `gene_presence_absence.csv` from Roary, `traits_file.csv`
  - **Output Files**: Scoary analysis results

- **Traits File Creation**: `create_traits_file.R`
  - **Purpose**: Create traits file for Scoary analysis

#### eggNOG-mapper Functional Annotation

- **Extract Sequences**: `extract_gene_sequences.py`
  - **Purpose**: Extract DNA sequences of significant genes
- **Run Extraction**: `run_extraction.sh`
  - **Purpose**: SLURM script to run `extract_gene_sequences.py`
- **Run eggNOG-mapper**: `run_eggnog_mapper.sh`
  - **Purpose**: Run eggNOG-mapper on translated protein sequences
- **Extract Annotations**: 
  - `extract_cog_annotations.py`
    - **Purpose**: Extract COG annotations from eggNOG-mapper output
  - `extract_go_annotations.py`
    - **Purpose**: Extract GO annotations from eggNOG-mapper output
- **Run Extraction Scripts**: `run_extract_annotations.sh`
  - **Purpose**: SLURM script to run annotation extraction scripts

### Data Analysis

#### Input and Output Files

- **BUSCO**:
  - **Input**: Genome files
  - **Output**: Completeness reports

- **Prokka**:
  - **Input**: Genome files
  - **Output**: Annotated genomes

- **Roary**:
  - **Input**: Annotated genomes
  - **Output**: Pan-genome results

- **Scoary**:
  - **Input**: Gene data, traits file
  - **Output**: GWAS results

- **eggNOG-mapper**:
  - **Input**: Protein sequences
  - **Output**: COG and GO annotations

### Figures

#### Figure 1: Distribution of Gene Categories
- **Script**: `roary_bar_chart.R`
  - **Purpose**: Generate a bar chart showing the distribution of gene categories (Core genes, Soft core genes, Shell genes, Cloud genes) with a log scale on the y-axis.
  - **Dependencies**: R, ggplot2, dplyr
  - **Input**: None (data is hardcoded within the script)
  - **Output**: `gene_category_distribution.png`

#### Figure 2: Roary Accessory Binary Genes Tree
- **Script**: `plot_roary.py`
  - **Purpose**: Generate the accessory binary genes tree.
  - **Dependencies**: Python, matplotlib, pandas, biopython
  - **Input**: `roary_25_1.4_1719619195/accessory_binary_genes.fa.newick`, `roary_25_1.4_1719619195/gene_presence_absence.csv`
  - **Output**: `accessory_binary_genes_tree.png`
  - **Steps**:
    1. Download the script from the official repository:
        ```sh
        wget https://raw.githubusercontent.com/sanger-pathogens/Roary/master/contrib/roary_plots/roary_plots.py
        ```
    2. Ensure you have the required dependencies installed:
        ```sh
        pip install matplotlib pandas biopython
        ```
    3. Save the `plot_roary.py` script locally.
    4. Run the script to generate the plots:
        ```sh
        python plot_roary.py roary_25_1.4_1719619195/accessory_binary_genes.fa.newick roary_25_1.4_1719619195/gene_presence_absence.csv accessory_binary_genes_tree.png
        ```

#### Figures 3 and 4: COG Category Counts and Significant COG Categories
- **Script**: `visualize_cogs.py`
  - **Purpose**: Generate visualizations of the COG category counts and significant COG categories.
  - **Dependencies**: R, ggplot2, dplyr
  - **Input**: `~/Desktop/eggnog_output/gene2cog.map`, `~/Desktop/eggnog_output/significant_cogs_combined.csv`
  - **Outputs**: `~/Desktop/eggnog_output/cog_category_counts_filtered.png`, `~/Desktop/eggnog_output/significant_cog_categories_filtered.png`

#### Figure 5: R Script for Visualization of GO Enrichment
- **Script**: `visualize_go_enrichment.R`
  - **Purpose**: Generate a bar chart of the top GO terms enriched in significant genes.
  - **Dependencies**: R, ggplot2, dplyr
  - **Input**: `~/Desktop/go_enrichment_results.csv`
  - **Output**: `~/Desktop/top_go_terms_enriched.png`

### Software_and_Tools.md

Provides usage and installation information for all tools and software used.

### Credits and Acknowledgments

Project conducted by Yasmine Alqanai, with guidance from supervisor James McInerney.
