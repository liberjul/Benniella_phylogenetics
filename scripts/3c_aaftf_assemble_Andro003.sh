#!/bin/bash --login
########## Define Resources Needed with SBATCH Lines ##########

#SBATCH --time=06:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --ntasks=1                 # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=24          # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=64G                   # memory required per node - amount of memory (in bytes)
#SBATCH --job-name=assemble_Actsp_reads_Andro003        # you can give your job a name for easier identification (same as -J)
#SBATCH --output=%x-%j.SLURMout

########## Command Lines to Run ##########

CPU=24
MEM=64
WORKDIR=/mnt/scratch/liberjul/Kasson_genomes/working_AAFTF_pe
OUTDIR=./Kasson_genomes
mkdir -p $WORKDIR $OUTDIR
conda activate aaftf
for i in ActspLightDraft_*/Filtered_Raw_Data/*.fastq.gz
do
  BASE=$(basename ${i%.fastq.gz})
  if [ $(echo $i | cut -d'/' -f1) == "ActspLightDraft_5_FD_Andro003" ]
  then
    TRIMREAD=$(echo $i | cut -d'/' -f1)/Filtered_Raw_Data
    INTERLEAVED=$TRIMREAD/${BASE}.fastq.gz
    ASMFILE=$OUTDIR/${BASE}.spades.fasta

    echo $TRIMREAD/${BASE}

    spades.py --threads $CPU --mem $MEM --12 $INTERLEAVED -o $WORKDIR/spades_$BASE

    cp $WORKDIR/spades_$BASE/*.fasta $OUTDIR
  fi
done
conda deactivate

scontrol show job $SLURM_JOB_ID     ### write job information to output file
