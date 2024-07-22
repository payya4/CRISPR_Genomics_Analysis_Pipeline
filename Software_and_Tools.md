## File Details

This file provides details about the software, tools, and websites utilized in our step-by-step process. For websites, it includes URLs and the dates accessed. For Unix/R tools and applications, it lists the version data corresponding to the versions used, outlined below.

## Packages

### R Packages:

- **ggplot2** - Version 3.4.4
  - [GitHub Repository](https://github.com/tidyverse/ggplot2?tab=readme-ov-file)

- **dplyr** - Version 1.1.4
  - [GitHub Repository](https://github.com/tidyverse/dplyr)

- **tidyr** - Version 1.2.0
  - [GitHub Repository](https://github.com/tidyverse/tidyr)

- **topGO** - Version 2.48.0
  - [Bioconductor Package](https://bioconductor.org/packages/release/bioc/html/topGO.html)

### Tools and Software:

- **BUSCO** - Version 5.7.1
  - **Dependencies**:
    - **Python** 3.8
      - [Python Website](https://www.python.org)
    - **Augustus** 3.3.3
      - [GitHub Repository](https://github.com/Gaius-Augustus/Augustus)
    - **HMMER** 3.3.2
      - [GitHub Repository](https://github.com/EddyRivasLab/hmmer)
    - **NCBI BLAST+** 2.11.0
      - [NCBI Website](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)

- **Prokka** - Version 1.14.6
  - **Dependencies**:
    - **BioPerl** 1.7.7
      - [GitHub Repository](https://github.com/bioperl/bioperl-live)
    - **Prodigal** 2.6.3
      - [GitHub Repository](https://github.com/hyattpd/Prodigal)
    - **Aragorn** 1.2.38
      - [Website](http://130.235.244.92/ARAGORN/)
    - **RNAmmer** 1.2
      - [Website](http://www.cbs.dtu.dk/services/RNAmmer/)
    - **SignalP** 5.0
      - [Website](http://www.cbs.dtu.dk/services/SignalP/)
    - **Infernal** 1.1.3
      - [GitHub Repository](https://github.com/EddyRivasLab/infernal)

- **Roary** - Version 3.13
  - **Dependencies**:
    - **CD-HIT** 4.8.1
      - [GitHub Repository](https://github.com/weizhongli/cdhit)
    - **PRANK** 170427
      - [GitHub Repository](https://github.com/ariloytynoja/prank-msa)
    - **FastTree** 2.1.11
      - [GitHub Repository](https://github.com/tchitchek-lab/fasttree)
    - **MCL** 14-137
      - [Micans Website](https://micans.org/mcl/)
    - **Parallel** 20210622
      - [GNU Website](https://www.gnu.org/software/parallel/)

- **Scoary** - Version 1.6.16
  - **Dependencies**:
    - **Python** 3.8
      - [Python Website](https://www.python.org)
    - **SciPy** 1.7.1
      - [GitHub Repository](https://github.com/scipy/scipy)
    - **NumPy** 1.21.2
      - [GitHub Repository](https://github.com/numpy/numpy)
    - **pandas** 1.3.3
      - [GitHub Repository](https://github.com/pandas-dev/pandas)
    - **statsmodels** 0.12.2
      - [GitHub Repository](https://github.com/statsmodels/statsmodels)

- **eggNOG-mapper** - Version 2.1.12
  - **Dependencies**:
    - **Diamond** 2.0.11
      - [GitHub Repository](https://github.com/bbuchfink/diamond)
    - **HMMER** 3.3.2
      - [GitHub Repository](https://github.com/EddyRivasLab/hmmer)

- **EMBOSS** - Version 6.6
  - **Dependencies**:
    - **libxpm4** 3.5.12
      - [GitHub Repository](https://github.com/jjuranek/libxpm)
    - **libpng16-16** 1.6.37
      - [GitHub Repository](https://github.com/glennrp/libpng)
    - **libgd3** 2.3.3
      - [GitHub Repository](https://github.com/libgd/libgd)

### Programming Languages and Environments:

- **Python** - Version 3.8
  - **Dependencies**: pip (or latest available at the time of installation)
  - [Python Website](https://www.python.org)

- **R** - Version 4.2.1
  - **Dependencies**: ggplot2, dplyr, tidyr, topGO
  - [R Project Website](https://www.r-project.org)

### Conda Installation:

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

### Additional Dependencies:

- **R**: Ensure R is installed and accessible. You can install R via your package manager or from the [CRAN website](https://cran.r-project.org).
- **Python**: Ensure Python is installed. You can install Python from the [official website](https://www.python.org).
