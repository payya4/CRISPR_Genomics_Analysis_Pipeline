# Software_and_Tools.md

## File Details

This file provides details about the software, tools, and websites utilized in our step-by-step process. For websites, it includes URLs and the dates accessed. For Python/R tools and applications, it lists the version data corresponding to the versions used, outlined below.

## Programming Languages and Environments:

### **R** - Version 4.2.1
  - [R Project Website](https://www.r-project.org)

    - **ggplot2** - Version 3.5.1
      - [GitHub Repository](https://github.com/tidyverse/ggplot2?tab=readme-ov-file)
    
    - **dplyr** - Version 1.1.4
      - [GitHub Repository](https://github.com/tidyverse/dplyr)
    
    - **tidyr** - Version 1.3.1
      - [GitHub Repository](https://github.com/tidyverse/tidyr)
    
    - **topGO** - Version 2.54.0
      - [Bioconductor Package](https://bioconductor.org/packages/release/bioc/html/topGO.html)

### **Python** - Version 3.11.3
  - [Python Website](https://www.python.org)
  
    - **pip** Version 9.0.3
      - [Github Repository](https://github.com/pypa/pip)
        
    - **Pandas** Version 1.1.5
      - [Github Repository](https://github.com/pandas-dev/pandas)
        
    - **Biopython** Version 1.79
      - [Biopython Website](https://biopython.org)
        
    - **bcbio-gff** Version 0.7.1
      - [Github Repository](https://bioconda.github.io/recipes/bcbio-gff/README.html)
        
     - **Matplotlib** Version 3.9.0
      - [Github Repository](https://github.com/matplotlib/matplotlib)
        
    - **SciPy** Version 1.10.1
      - [SciPy website](https://scipy.org)
        
    - **Numpy** Version 1.24.4
      - [Github Repository](https://github.com/numpy/numpy)

### Tools and Software:

- **BUSCO** - Version 5.7.1
  -[Busco Website](https://busco.ezlab.org)

- **Prokka** - Version 1.14.6
  - [Github Repository](https://github.com/tseemann/prokka)

- **Roary** - Version 3.13
  - [Github Repository](https://github.com/sanger-pathogens/Roary)

- **Scoary** - Version 1.6.16
  -[Github Repository](https://github.com/AdmiralenOla/Scoary)
  
- **eggNOG-mapper** - Version 2.1.12
  -[Github Repository](https://github.com/eggnogdb/eggnog-mapper)
  
- **EMBOSS** - Version 6.6
  -[Anaconda Website](https://anaconda.org/bioconda/emboss)

- **Miniconda** Version 24.5.0
  -[Anaconda Website](https://docs.anaconda.com/miniconda/)
  
- **Terminal:**
    - **bash:** Version 4.4.20
 


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
        conda create -n busco_env python=3.11.3
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
        conda create -n roary_env python=3.11.3
        conda activate roary_env
        conda install -c bioconda roary
        roary -h
        conda deactivate
        ```

    - **Scoary**:
        ```bash
        conda create -n scoary_env python=3.11.3
        conda activate scoary_env
        pip install git+https://github.com/AdmiralenOla/Scoary.git
        scoary --version
        conda deactivate
        ```

    - **eggNOG-mapper**:
        ```bash
        conda create -n eggnog_env python=3.11.3
        conda activate eggnog_env
        conda install -c bioconda eggnog-mapper
        conda deactivate
        ```

