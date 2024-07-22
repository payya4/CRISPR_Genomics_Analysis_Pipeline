# Install and load the necessary packages
if(!require(readr)) install.packages("readr", dependencies=TRUE)
library(readr)
if(!require(dplyr)) install.packages("dplyr", dependencies=TRUE)
library(dplyr)

# Replace 'gene_presence_absence.csv' with the path to your Roary CSV file
csv_file <- '~/Desktop/roary_25_1.4_1719619195/gene_presence_absence.csv'

# Read the CSV file
df <- read_csv(csv_file)

# Extract the genome names from the columns
# Assuming the genome names start from the 15th column (as in a typical Roary output)
genome_names <- colnames(df)[15:length(colnames(df))]

# List of specific names to check
specific_names <- c("Acetobacter_aceti", "Acetobacter_ascendens", "Acetobacter_oryzifermentans",
                    "Acetobacter_persici", "Acetobacter_pomorum", "Achromobacter_denitrificans",
                    "Achromobacter_xylosoxidans", "Acidaminococcus_fermentans", "Acidaminococcus_intestini",
                    "Acidianus_ambivalens", "Acidianus_brierleyi", "Acidianus_hospitalis", "Acidianus_manzaensis",
                    "Acidianus_sulfidivorans", "Acididesulfobacillus_acetoxydans", "Aerococcus_urinae",
                    "Aeromonas_hydrophila", "Amedibacterium_intestinale", "Bacteroides_fragilis",
                    "Caldicellulosiruptor_acetigenus", "Caldicellulosiruptor_kronotskyensis",
                    "Campylobacter_coli", "Carboxydocella_thermautotrophica", "Carnobacterium_viridans",
                    "Chryseobacterium_gallinarum", "Citrobacter_braakii", "Citrobacter_freundii",
                    "Clostridium_botulinum", "Corynebacterium_aurimucosum", "Corynebacterium_macginleyi",
                    "Corynebacterium_striatum", "Corynebacterium_ulcerans", "Dickeya_dadantii", "Dolosigranulum_pigrum",
                    "Elizabethkingia_anophelis", "Enterobacter_bugandensis", "Fructilactobacillus_lindneri",
                    "Fructilactobacillus_sanfranciscensis", "Geobacter_sulfurreducens", "Helicobacter_cinaedi",
                    "Lactiplantibacillus_pentosus", "Lactobacillus_acetotolerans", "Lactobacillus_amylovorus",
                    "Lactobacillus_apis", "Lactobacillus_jensenii", "Latilactobacillus_curvatus",
                    "Leuconostoc_gelidum_JB7", "Macrococcoides_canis", "Maridesulfovibrio_hydrothermalis",
                    "Marinitoga_piezophila", "Megamonas_funiformis", "Mesorhizobium", "Methylacidiphilum_caldifontis",
                    "Methylacidiphilum_kamchatkense", "Microbulbifer_celer", "Micrococcus_luteus", "Moraxella_catarrhalis",
                    "Moritella", "Neokomagataea_tanensis", "Neptunomonas_concharum", "Nitrosomonas_ureae",
                    "Oenococcus_kitaharae", "Oenococcus_sicerae", "Paenibacillus", "Paenibacillus_polymyxa",
                    "Pasteurella_multocida", "Phocaeicola_dorei", "Staphylococcus_warneri", "Streptococcus_agalactiae",
                    "Streptococcus_infantarius", "Streptococcus_lutetiensis", "Streptococcus_pyogenes",
                    "Streptococcus_thermophilus", "Thermus_thermophilus_HB8", "Thomasclavelia_spiroformis_DSM_1552",
                    "Treponema_denticola_ATCC_35405", "Trueperella_pyogenes", "Varibaculum_cambriense",
                    "Zymobacter_palmae", "Zymomonas_mobilis", "ecoli-1")

# Function to check if genome name starts with any of the specific names
check_trait <- function(genome_name) {
  any(startsWith(genome_name, specific_names))
}

# Create a data frame with genome names and traits (1 or 0)
traits_df <- data.frame(
  Name = genome_names,
  CRISPR_presence = sapply(genome_names, function(name) ifelse(check_trait(name), 1, 0))
)

# Print the traits data frame
print(traits_df)

# Save the traits data frame to a file
output_file <- '~/Desktop/traits_file.csv'
write_csv(traits_df, output_file)

cat("Genome traits have been saved to", output_file, "\n")
