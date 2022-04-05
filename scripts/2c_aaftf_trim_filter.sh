#!/bin/bash --login
########## Define Resources Needed with SBATCH Lines ##########

#SBATCH --time=02:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --ntasks=1                 # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=8          # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=16G                   # memory required per node - amount of memory (in bytes)
#SBATCH --job-name=trim_filter_ben_reads        # you can give your job a name for easier identification (same as -J)
#SBATCH --output=%x-%j.SLURMout

########## Command Lines to Run ##########

MEM=16 # 16gb
CPU=8

for i in BenspLightDraft_*/Filtered_Raw_Data/*.fastq.gz
do

  BASE=$(basename ${i%.fastq.gz})
  if true #[ $(echo $i | cut -d'/' -f1) != "BenspLightDraft_FD_NVP103" ]
  then
    READSDIR=$(echo $i | cut -d'/' -f1)/Filtered_Raw_Data
    TRIMREAD=$(echo $i | cut -d'/' -f1)/reads_trimmed

    echo $BASE
    echo $READSDIR
    conda activate aaftf

    AAFTF trim --method bbduk --memory $MEM -c $CPU \
     --left $READSDIR/${BASE}.fastq.gz \
      -o $TRIMREAD/${BASE}
  fi
done
# this step make take a lot of memory depending on how many filtering libraries you use
# AAFTF filter -c $CPU --memory $MEM --aligner bbduk \
# 	  -o $TRIMREAD/${BASE} --left $TRIMREAD/${BASE}_1P.fastq.gz --right $TRIMREAD/${BASE}_2P.fastq.gz
