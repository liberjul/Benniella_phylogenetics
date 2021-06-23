#!/usr/bin/env python
import glob, os

strains = ["AP5", "JL1", "JL29", "JL58", "JL62", "JL122", "NVP85", "NVP105", "JU15B", "JU17", "JU19", "JU20", "GBAus27b", "AD185", "MES2146"]
loci = ["SSU-LSU", "1870", "EF1a", "RPB1"]

for locus in loci:
    buffer = ""
    for strain in strains:
        if os.path.exists(F"../sequence_data/{locus}/{strain}_{locus}.fasta"):
            with open(F"../sequence_data/{locus}/{strain}_{locus}.fasta", "r") as ifile:
                line = ifile.readline()
                header = line.strip()
                seq = ""
                line = ifile.readline()
                while line != "":
                    seq += line.strip()
                    line = ifile.readline()
                buffer = F"{buffer}{header}\n{seq}\n"
        else:
            buffer = F"{buffer}>{strain}_{locus}\n-\n"
    with open(F"../alignments/unaligned_{locus}.fas", "w") as ofile:
        ofile.write(buffer)
# files = glob.glob(args.input)
#
#
#
# for file in files:
#     with open(file, "r") as ifile:
#         head =
