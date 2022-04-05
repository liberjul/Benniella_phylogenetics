#!/bin/bash --login
########## Define Resources Needed with SBATCH Lines ##########

#SBATCH --time=24:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --ntasks=1                 # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=24          # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=10G                   # memory required per node - amount of memory (in bytes)
#SBATCH --job-name=funannotate_train_GBA27b        # you can give your job a name for easier identification (same as -J)
#SBATCH --output=%x-%j.SLURMout

########## Command Lines to Run ##########

## Prep assemblies
conda activate aaftf
module load GCC/10.2.0  OpenMPI/4.0.5 AUGUSTUS/3.4.0 DIAMOND hisat2/2.1.0 icc/2018.1.163-GCC-6.4.0-2.28  impi/2018.1.163 SAMtools/1.8 PASA/2.4.1 Trinity/2.8.4 kallisto/0.46.0 FASTA/36.3.8h_04-May-2020

cd /mnt/scratch/liberjul/Benniella_genomes/funannotate_working_dir

funannotate train -i ~/Bonito_Lab/LCG/GBAus27b_ref/MorGBAus27b_1_AssemblyScaffolds_Repeatmasked.fasta \
  -l ~/Bonito_Lab/LCG/GBAus27b_ref/Raw_RNA_pe_MorGBAus27b_10396.4.159972.ATCACG.1.fastq \
  -r ~/Bonito_Lab/LCG/GBAus27b_ref/Raw_RNA_pe_MorGBAus27b_10396.4.159972.ATCACG.2.fastq \
  --trinity ~/Bonito_Lab/LCG/GBAus27b_ref/MorGBAus27b_1_all_transcripts_20170422.nt.fasta \
  --species "Benniella erionia" --strain GBA27b --cpus 24 -o GBA27b_FA_train_db_2 \
  --jaccard_clip \
  --TRINITYHOME /opt/software/Trinity/2.8.4-GCCcore-6.4.0/Trinity

conda deactivate

scontrol show job $SLURM_JOB_ID     ### write job information to output file
