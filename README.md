# Project README

## Contents of the Files

### Workflow_Timeline.md

- **Introduction:** Overview of the analysis on horizontally transferred genes and CRISPR genes in prokaryotic pangenomes.
- **Objectives:** Goals including genome quality assessment, annotation, pan-genome analysis, GWAS, and functional annotation.
- **Expected Outcomes:** Results such as high-quality genome identification, comprehensive annotations, core/accessory genome definitions, and functional insights.

### Package Installation

- **BUSCO:** version 5.7.1
- **Prokka:** version 1.14.6
- **Roary:** version 3.13
- **Scoary:** version 1.6.16
- **eggNOG-mapper:** version 2.1.12
- **EMBOSS:** version 6.6
- **Python:** version 3.8
- **R:** version 4.2.1
- **Miniconda:** latest version
- **pip:** latest version

### Script Files

- **BUSCO Quality Check:**
  - CRISPR Genomes: `run_busco_CRISPR.sh`
  - Non-CRISPR Genomes: `run_busco_NONCRISPR.sh`
- **Prokka Annotation:**
  - CRISPR Genomes: `annotate_genomes_crispr.sh`
  - Non-CRISPR Genomes: `annotate_genomes_noncrispr.sh`
- **Roary Pan-Genome Analysis:**
  - Script: `run_roary.sh`
- **Scoary GWAS:**
  - Script: `run_scoary.sh`
  - Traits File Creation: `create_traits_file.R`
- **eggNOG-mapper Functional Annotation:**
  - Extract Sequences: `extract_gene_sequences.py`
  - Run Extraction: `run_extraction.sh`
  - Run eggNOG-mapper: `run_eggnog_mapper.sh`
  - Extract Annotations: `extract_cog_annotations.py`, `extract_go_annotations.py`
  - Run Extraction Scripts: `run_extract_annotations.sh`

**Note:** Links to scripts, if not included here, will be provided separately.

### Data Analysis

- **Input and Output Files:**
  - **BUSCO:** Input: Genome files. Output: Completeness reports.
  - **Prokka:** Input: Genome files. Output: Annotated genomes.
  - **Roary:** Input: Annotated genomes. Output: Pan-genome results.
  - **Scoary:** Input: Gene data, traits file. Output: GWAS results.
  - **eggNOG-mapper:** Input: Protein sequences. Output: COG and GO annotations.

### Software_and_Tools.md

- **Links:** Provides usage and installation information for all tools and software used.

### Credits and Acknowledgments

- Project conducted by Yasmine Alqanai, with guidance from supervisor James McInerney.








