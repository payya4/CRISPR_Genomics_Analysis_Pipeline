import csv

input_file = "/gpfs01/home/payya4/eggnog_output/eggnog_results.emapper.annotations"
cog_output_file = "/gpfs01/home/payya4/eggnog_output/gene2cog.map"

with open(input_file, "r") as infile, open(cog_output_file, "w") as outfile:
    reader = csv.reader(infile, delimiter="\t")
    header = None
    for row in reader:
        if row[0].startswith("#"):
            header = row
        elif header:
            cog_index = header.index("COG_category")
            gene_id = row[0]
            cog_annotation = row[cog_index]
            if cog_annotation:
                outfile.write(f"{gene_id} {cog_annotation}\n")

# Script fully made by Yasmine Alqanai.
