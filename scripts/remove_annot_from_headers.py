#!/usr/bin/env python
importargparse

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", type=str, help="input FASTA")
parser.add_argument("-o", "--output", type=str, help="output FASTA")
parser.add_argument("-e", "--extra", type=str, default="", help="extra characters to strip")
args = parser.parse_args()

with open(args.input, "r") as ifile:
    with open(args.output, "w") as ofile:
        line = ifile.readline()
        while line != "":
            if line[0] == ">":
                out_line = line.split("|")[0].strip(args.extra) + "\n"
            else:
                out_line = line
            ofile.write(out_line)
            line = ifile.readline()
