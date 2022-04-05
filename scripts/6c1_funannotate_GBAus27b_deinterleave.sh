#!/bin/bash --login
########## Define Resources Needed with SBATCH Lines ##########

#SBATCH --time=01:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --ntasks=1                 # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=1          # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=10G                   # memory required per node - amount of memory (in bytes)
#SBATCH --job-name=deinterleave_GBAus27b        # you can give your job a name for easier identification (same as -J)
#SBATCH --output=%x-%j.SLURMout

########## Command Lines to Run ##########

cd ~/Bonito_Lab/LCG/GBAus27b_ref

paste - - - - - - - - < Raw_RNA_pe_MorGBAus27b_10396.4.159972.ATCACG.fastq \
    | tee >(cut -f 1-4 | tr "\t" "\n" > Raw_RNA_pe_MorGBAus27b_10396.4.159972.ATCACG.1.fastq) \
    | cut -f 5-8 | tr "\t" "\n" > Raw_RNA_pe_MorGBAus27b_10396.4.159972.ATCACG.2.fastq

scontrol show job $SLURM_JOB_ID     ### write job information to output file
