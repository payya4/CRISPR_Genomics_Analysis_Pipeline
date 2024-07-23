#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=10:00:00
#SBATCH --job-name=prokka_crispr
#SBATCH --output=/gpfs01/home/payya4/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=payya4@exmail.nottingham.ac.uk

# Load the Conda initialization script
source /gpfs01/home/payya4/miniconda3/etc/profile.d/conda.sh

# Activate the conda environment
conda activate /gpfs01/home/payya4/miniconda3/envs/prokka_env   

# Define an associative array to map organism names to their respective kingdom, genus, and species.
# List co-piloted by AI to expedite the process of listing this information.  
declare -A organism_info
organism_info=(
    ["Acetobacter_aceti"]="Bacteria Acetobacter aceti"
    ["Acetobacter_ascendens"]="Bacteria Acetobacter ascendens"
    ["Acetobacter_oryzifermentans"]="Bacteria Acetobacter oryzifermentans"
    ["Acetobacter_persici"]="Bacteria Acetobacter persici"
    ["Acetobacter_pomorum"]="Bacteria Acetobacter pomorum"
    ["Achromobacter_denitrificans"]="Bacteria Achromobacter denitrificans"
    ["Achromobacter_xylosoxidans"]="Bacteria Achromobacter xylosoxidans"
    ["Acidaminococcus_fermentans"]="Bacteria Acidaminococcus fermentans"
    ["Acidaminococcus_intestini"]="Bacteria Acidaminococcus intestini"
    ["Acidianus_ambivalens"]="Archaea Acidianus ambivalens"
    ["Acidianus_brierleyi"]="Archaea Acidianus brierleyi"
    ["Acidianus_hospitalis"]="Archaea Acidianus hospitalis"
    ["Acidianus_manzaensis"]="Archaea Acidianus manzaensis"
    ["Acidianus_sulfidivorans"]="Archaea Acidianus sulfidivorans"
    ["Acididesulfobacillus_acetoxydans"]="Bacteria Acididesulfobacillus acetoxydans"
    ["Aerococcus_urinae"]="Bacteria Aerococcus urinae"
    ["Aeromonas_hydrophila"]="Bacteria Aeromonas hydrophila"
    ["Amedibacterium_intestinale"]="Bacteria Amedibacterium intestinale"
    ["Bacteroides_fragilis"]="Bacteria Bacteroides fragilis"
    ["Caldicellulosiruptor_acetigenus"]="Bacteria Caldicellulosiruptor acetigenus"
    ["Caldicellulosiruptor_kronotskyensis"]="Bacteria Caldicellulosiruptor kronotskyensis"
    ["Campylobacter_coli"]="Bacteria Campylobacter coli"
    ["Carboxydocella_thermautotrophica"]="Bacteria Carboxydocella thermautotrophica"
    ["Carnobacterium_viridans"]="Bacteria Carnobacterium viridans"
    ["Chryseobacterium_gallinarum"]="Bacteria Chryseobacterium gallinarum"
    ["Citrobacter_braakii"]="Bacteria Citrobacter braakii"
    ["Citrobacter_freundii"]="Bacteria Citrobacter freundii"
    ["Clostridium_botulinum"]="Bacteria Clostridium botulinum"
    ["Corynebacterium_aurimucosum"]="Bacteria Corynebacterium aurimucosum"
    ["Corynebacterium_macginleyi"]="Bacteria Corynebacterium macginleyi"
    ["Corynebacterium_striatum"]="Bacteria Corynebacterium striatum"
    ["Corynebacterium_ulcerans"]="Bacteria Corynebacterium ulcerans"
    ["Dickeya_dadantii"]="Bacteria Dickeya dadantii"
    ["Dolosigranulum_pigrum"]="Bacteria Dolosigranulum pigrum"
    ["Elizabethkingia_anophelis"]="Bacteria Elizabethkingia anophelis"
    ["Enterobacter_bugandensis"]="Bacteria Enterobacter bugandensis"
    ["Fructilactobacillus_lindneri"]="Bacteria Fructilactobacillus lindneri"
    ["Fructilactobacillus_sanfranciscensis"]="Bacteria Fructilactobacillus sanfranciscensis"
    ["Geobacter_sulfurreducens"]="Bacteria Geobacter sulfurreducens"
    ["Helicobacter_cinaedi"]="Bacteria Helicobacter cinaedi"
    ["Lactiplantibacillus_pentosus"]="Bacteria Lactiplantibacillus pentosus"
    ["Lactobacillus_acetotolerans"]="Bacteria Lactobacillus acetotolerans"
    ["Lactobacillus_amylovorus"]="Bacteria Lactobacillus amylovorus"
    ["Lactobacillus_apis"]="Bacteria Lactobacillus apis"
    ["Lactobacillus_jensenii"]="Bacteria Lactobacillus jensenii"
    ["Latilactobacillus_curvatus"]="Bacteria Latilactobacillus curvatus"
    ["Leuconostoc_gelidum_JB7"]="Bacteria Leuconostoc gelidum"
    ["Macrococcoides_canis"]="Bacteria Macrococcoides canis"
    ["Maridesulfovibrio_hydrothermalis"]="Bacteria Maridesulfovibrio hydrothermalis"
    ["Marinitoga_piezophila"]="Bacteria Marinitoga piezophila"
    ["Megamonas_funiformis"]="Bacteria Megamonas funiformis"
    ["Mesorhizobium"]="Bacteria Mesorhizobium"
    ["Methylacidiphilum_caldifontis"]="Bacteria Methylacidiphilum caldifontis"
    ["Methylacidiphilum_kamchatkense"]="Bacteria Methylacidiphilum kamchatkense"
    ["Microbulbifer_celer"]="Bacteria Microbulbifer celer"
    ["Micrococcus_luteus"]="Bacteria Micrococcus luteus"
    ["Moraxella_catarrhalis"]="Bacteria Moraxella catarrhalis"
    ["Moritella"]="Bacteria Moritella"
    ["Neokomagataea_tanensis"]="Bacteria Neokomagataea tanensis"
    ["Neptunomonas_concharum"]="Bacteria Neptunomonas concharum"
    ["Nitrosomonas_ureae"]="Bacteria Nitrosomonas ureae"
    ["Oenococcus_kitaharae"]="Bacteria Oenococcus kitaharae"
    ["Oenococcus_sicerae"]="Bacteria Oenococcus sicerae"
    ["Paenibacillus"]="Bacteria Paenibacillus"
    ["Paenibacillus_polymyxa"]="Bacteria Paenibacillus polymyxa"
    ["Pasteurella_multocida"]="Bacteria Pasteurella multocida"
    ["Phocaeicola_dorei"]="Bacteria Phocaeicola dorei"
    ["Staphylococcus_warneri"]="Bacteria Staphylococcus warneri"
    ["Streptococcus_agalactiae"]="Bacteria Streptococcus agalactiae"
    ["Streptococcus_infantarius"]="Bacteria Streptococcus infantarius"
    ["Streptococcus_lutetiensis"]="Bacteria Streptococcus lutetiensis"
    ["Streptococcus_pyogenes"]="Bacteria Streptococcus pyogenes"
    ["Streptococcus_thermophilus"]="Bacteria Streptococcus thermophilus"
    ["Thermus_thermophilus_HB8"]="Bacteria Thermus thermophilus HB8"
    ["Thomasclavelia_spiroformis_DSM_1552"]="Bacteria Thomasclavelia spiroformis DSM 1552"
    ["Treponema_denticola_ATCC_35405"]="Bacteria Treponema denticola ATCC 35405"
    ["Trueperella_pyogenes"]="Bacteria Trueperella pyogenes"
    ["Varibaculum_cambriense"]="Bacteria Varibaculum cambriense"
    ["Zymobacter_palmae"]="Bacteria Zymobacter palmae"
    ["Zymomonas_mobilis"]="Bacteria Zymomonas mobilis"
    ["ecoli-1"]="Bacteria Escherichia coli"
)

# Set the path to the directory containing the files
input_dir="/gpfs01/home/payya4/genomes/CRISPR"

# Loop through each organism and its information
for organism in "${!organism_info[@]}"; do
    kingdom=$(echo "${organism_info[$organism]}" | awk '{print $1}')
    genus=$(echo "${organism_info[$organism]}" | awk '{print $2}')
    species=$(echo "${organism_info[$organism]}" | awk '{print $3}')
    
    # Create an output directory for the organism
    organism_out="${input_dir}/${organism}_output"
    mkdir -p "$organism_out"
    
    # Loop through each .fna file for the organism
    for fna_file in "$input_dir/$organism"/*.fna; do
        # Extract the file name without the extension
        base_name=$(basename "$fna_file" .fna)
        
        # Set the specific output directory for the current .fna file
        file_out_dir="$organism_out/$base_name"
        mkdir -p "$file_out_dir"
        
        # Run Prokka for annotation
        prokka --outdir "$file_out_dir" \
         --kingdom "$kingdom" \
         --genus "$genus" \
         --species "$species" \
         --force \
         "$fna_file"
    done
done

# Deactivate conda
conda deactivate

# Script made by Yasmine Alqanai with the exception of the list commented declaring the use of AI.
