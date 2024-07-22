import csv

input_file = "/gpfs01/home/payya4/eggnog_output/eggnog_results.emapper.annotations"
go_output_file = "/gpfs01/home/payya4/eggnog_output/gene2go.map"

with open(input_file, "r") as infile, open(go_output_file, "w") as outfile:
    reader = csv.reader(infile, delimiter="\t")
    header = None
    for row in reader:
        if row[0].startswith("#"):
            header = row
        elif header:
            go_index = header.index("GOs")
            gene_id = row[0]
            go_annotations = row[go_index]
            if go_annotations and go_annotations != "-":
                go_annotations = go_annotations.replace(',', ';')
                outfile.write(f"{gene_id} {go_annotations}\n")
