#!/usr/bin/env python
import glob, os, argparse

def external_unknown(seq, char="N"):
    first_char_pos = len(seq)
    last_char_pos = -1
    for i in range(len(seq)):
        if seq[i] != "-":
            first_char_pos = i
            break
    for i in range(len(seq)):
        if seq[len(seq) - i - 1] != "-":
            last_char_pos = len(seq) - i - 1
            break
    out_seq = ""
    for i in range(len(seq)):
        if i < first_char_pos or i > last_char_pos:
            out_seq += char
        else:
            out_seq += seq[i]
    return out_seq

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", type=str, help="input FASTA")
parser.add_argument("-o", "--output", type=str, help="output files path and prefix")
args = parser.parse_args()

fastas = glob.glob(args.input)

header_list = []
seq_dict = {}
len_dict = {}

for f in fastas:
    seq_dict[f] = {}
    with open(f, "r") as ifile:
        line = ifile.readline()
        seq = ""
        while line != "":
            if line[0] == ">":
                if line not in header_list:
                    header_list.append(line)
                header = line
                seq = ""
                line = ifile.readline()
                while line != "" and line[0] != ">":
                    seq += line.strip()
                    line = ifile.readline()
                seq_dict[f][header] = seq
                len_dict[f] = len(seq)

for f in fastas:
    buffer = ""
    for rec in header_list:
        if rec in seq_dict[f]:
            buffer += F"{rec}{seq_dict[f][rec]}\n"
        else:
            buffer += F"{rec}{'-'*len_dict[f]}\n"
    out_name = ".." + f.strip(".fasta") + "_sorted.fasta"
    with open(out_name, "w") as ofile:
        ofile.write(buffer)

char_sum = 0
for i in len_dict:
    print(F"{i} {len_dict[i]}")
    char_sum += len_dict[i]

### Make PHYLIP file for RAxML

buffer = F"{len(header_list)} {char_sum}\n"
fastas.sort()
for i in header_list:
    buffer += F"{i.strip().strip('>')}                           "
    for locus in fastas:
        if i in seq_dict[locus]:
            buffer += F"{external_unknown(seq_dict[locus][i])}"
        else:
            buffer += F"{'N'*len_dict[locus]}"
    buffer += "\n"

with open(F"{args.output}.phy", "w") as ofile:
    ofile.write(buffer)

with open(F"{args.output}_part_file.txt", "w") as ofile:
    start = 1
    for locus in fastas:
        out_locus = locus.split("/")[-1].strip("aligned.").strip("_trimmed.fasta")
        if "SSU-LSU." in out_locus:
            out_locus = out_locus.split("SSU-LSU.")[1]
        stop = start + len_dict[locus] - 1
        ofile.write(F"DNA, {out_locus} = {start}-{stop}\n")
        start = stop + 1

### Make NEXUS for Mr. Bayes

max_len = 0
for i in header_list:
    if len(header_list) > max_len:
        max_len = len(header_list)

buffer = F"#NEXUS\n\nBEGIN DATA;\n\tDIMENSIONS  NTAX={len(header_list)} NCHAR={char_sum};\n"
buffer += F"\tFORMAT DATATYPE = DNA GAP = - MISSING = ?;\n\tMATRIX\n"

for i in header_list:
    head_len = i.strip().strip('>')
    buffer += F"\t{head_len + (max_len-len(head_len))*' '}"
    for locus in fastas:
        if i in seq_dict[locus]:
            buffer += F"{external_unknown(seq_dict[locus][i], char='?')}"
        else:
            buffer += F"{'?'*len_dict[locus]}"
    buffer += "\n"
buffer += "\n;\n\nEND;\n\nbegin mrbayes;\n\tset autoclose=yes nowarn=yes;  \n\n\n"
out_locus_list = []
start = 1
for locus in fastas:
    out_locus = locus.split("/")[-1].strip("aligned.").strip("_trimmed.fasta")
    stop = start + len_dict[locus] - 1
    buffer += F"\tcharset {out_locus} =  {start} - {stop};\n"
    out_locus_list.append(out_locus)
    start = stop + 1

buffer += F"\tpartition currentPartition = {len(out_locus_list)}: {', '.join(out_locus_list)};\n"
buffer += F"\tlset applyto=({str(list(range(len(out_locus_list) +1)))[1:-1]});\n\n"
buffer += "\tlset nst = 6 rates=invgamma;\n\tunlink statefreq=(all) revmat=(all) shape=(all) pinvar=(all);\n"
buffer += "\tprset applyto=(all) ratepr=variable;\n\tmcmcp ngen= 10000000 relburnin=yes burninfrac=0.25 printfreq=1000  samplefreq=1000 nchains=4 savebrlens=yes;\n"
buffer += "\tmcmc;\n\tsumt;\nend;\n"

with open(F"{args.output}.nex", "w") as ofile:
    ofile.write(buffer)
