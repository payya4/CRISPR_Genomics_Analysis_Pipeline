# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the data
allRes <- read.csv("~/Desktop/go_enrichment_results.csv")

# Check the structure of the data
str(allRes)

# Check the first few rows of the data
head(allRes)

# Function to convert classicFisher to numeric
convert_fisher <- function(x) {
  if (grepl("<", x)) {
    # Convert values like "<1e-30" to numeric
    as.numeric(sub("<", "", x))
  } else {
    as.numeric(x)
  }
}

# Apply the function to the classicFisher column
allRes$classicFisher <- sapply(allRes$classicFisher, convert_fisher)

# Check for any NA values introduced by the conversion
sum(is.na(allRes$classicFisher))

# Remove rows with NA values in classicFisher
allRes <- allRes[!is.na(allRes$classicFisher),]

# Dictionary of better labels for GO terms
# List co-piloted by AI to expedite the process of listing this information.
allRes <- allRes %>%
  mutate(Term = case_when(
    Term == "nucleic acid phosphodiester bond hydroly..." ~ "Nucleic Acid Phosphodiester Bond Hydrolysis",
    Term == "purine ribonucleotide biosynthetic proce..." ~ "Purine Ribonucleotide Synthesis",
    Term == "nucleoside triphosphate metabolic proces..." ~ "Nucleoside Triphosphate Metabolism",
    Term == "nucleoside triphosphate biosynthetic pro..." ~ "Nucleoside Triphosphate Synthesis",
    Term == "purine nucleoside triphosphate metabolic..." ~ "Purine Nucleoside Triphosphate Metabolism",
    Term == "purine nucleoside triphosphate biosynthe..." ~ "Purine Nucleoside Triphosphate Synthesis",
    Term == "ribonucleoside triphosphate metabolic pr..." ~ "Ribonucleoside Triphosphate Metabolism",
    Term == "ribonucleoside triphosphate biosynthetic..." ~ "Ribonucleoside Triphosphate Synthesis",
    Term == "purine ribonucleoside triphosphate metab..." ~ "Purine Ribonucleoside Triphosphate Metabolism",
    Term == "purine ribonucleoside triphosphate biosy..." ~ "Purine Ribonucleoside Triphosphate Synthesis",
    Term == "pyruvate metabolic process" ~ "Pyruvate Metabolism",
    Term == "glycolytic process" ~ "Glycolysis",
    Term == "ATP biosynthetic process" ~ "ATP Synthesis",
    Term == "nucleoside diphosphate metabolic process" ~ "Nucleoside Diphosphate Metabolism",
    Term == "purine nucleoside diphosphate metabolic ..." ~ "Purine Nucleoside Diphosphate Metabolism",
    Term == "purine ribonucleoside diphosphate metabo..." ~ "Purine Ribonucleoside Diphosphate Metabolism",
    Term == "ribonucleoside diphosphate metabolic pro..." ~ "Ribonucleoside Diphosphate Metabolism",
    Term == "pyruvate biosynthetic process" ~ "Pyruvate Synthesis",
    Term == "ADP metabolic process" ~ "ADP Metabolism",
    Term == "ATP metabolic process" ~ "ATP Metabolism",
    Term == "monocarboxylic acid biosynthetic process" ~ "Monocarboxylic Acid Synthesis",
    Term == "generation of precursor metabolites and ..." ~ "Generation of Precursors & Energy",
    Term == "ribonucleotide biosynthetic process" ~ "Ribonucleotide Synthesis",
    Term == "ribose phosphate biosynthetic process" ~ "Ribose Phosphate Synthesis",
    Term == "glucose 6-phosphate metabolic process" ~ "Glucose 6-Phosphate Metabolism",
    Term == "positive regulation of biological proces..." ~ "Positive Regulation of Biological Processes",
    Term == "positive regulation of cellular process" ~ "Positive Regulation of Cellular Processes",
    Term == "sulfur compound catabolic process" ~ "Sulfur Catabolism",
    Term == "protein transport by the Sec complex" ~ "Protein Transport (Sec Complex)",
    Term == "organelle assembly" ~ "Organelle Assembly",
    Term == "non-membrane-bounded organelle assembly" ~ "Non-Membrane-Bounded Organelle Assembly",
    Term == "ribonucleotide metabolic process" ~ "Ribonucleotide Metabolism",
    Term == "ribose phosphate metabolic process" ~ "Ribose Phosphate Metabolism",
    Term == "cell cycle" ~ "Cell Cycle",
    Term == "cell cycle process" ~ "Cell Cycle Process",
    Term == "double-strand break repair" ~ "Double-Strand Break Repair",
    Term == "nucleotide catabolic process" ~ "Nucleotide Catabolism",
    Term == "organophosphate catabolic process" ~ "Organophosphate Catabolism",
    Term == "nucleoside phosphate catabolic process" ~ "Nucleoside Phosphate Catabolism",
    Term == "glucose metabolic process" ~ "Glucose Metabolism",
    Term == "hexose biosynthetic process" ~ "Hexose Synthesis",
    Term == "monosaccharide biosynthetic process" ~ "Monosaccharide Synthesis",
    Term == "purine ribonucleotide metabolic process" ~ "Purine Ribonucleotide Metabolism",
    Term == "gluconeogenesis" ~ "Gluconeogenesis",
    Term == "pentose-phosphate shunt" ~ "Pentose-Phosphate Shunt",
    Term == "NADP metabolic process" ~ "NADP Metabolism",
    Term == "NADPH regeneration" ~ "NADPH Regeneration",
    Term == "regulation of secondary metabolic proces..." ~ "Regulation of Secondary Metabolism",
    Term == "regulation of pentose-phosphate shunt" ~ "Regulation of Pentose-Phosphate Shunt",
    Term == "regulation of generation of precursor me..." ~ "Regulation of Generation of Precursors",
    TRUE ~ Term
  ))

# Bar chart of top GO terms with custom colors
ggplot(allRes, aes(x=reorder(Term, -classicFisher), y=-log10(classicFisher))) +
  geom_bar(stat="identity", fill="#87CEEB") +  # Set bar color 
  coord_flip() +
  xlab("GO Term") +
  ylab("-log10(p-value)") +
  ggtitle("Top GO Terms Enriched in Significant Genes") +
  theme_minimal() +
  theme(
    text = element_text(color = "black"),  # Set text color 
    axis.text = element_text(size=8, color = "black"),  # Set axis text color and size
    axis.text.y = element_text(hjust=1),  # Align text to be fully visible
    plot.title = element_text(hjust = 0.5),  # Center the plot title
    plot.margin = unit(c(1,1,1,2), "cm")  # Increase the margin on the left side
  )

# Script made by Yasmine Alqanai with the exception of the list commented declaring the use of AI.
