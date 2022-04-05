#!/bin/bash --login
########## Define Resources Needed with SBATCH Lines ##########

#SBATCH --time=4:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --ntasks=1                 # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=1          # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=1G                   # memory required per node - amount of memory (in bytes)
#SBATCH --job-name=funannotate_prep_ben        # you can give your job a name for easier identification (same as -J)
#SBATCH --output=%x-%j.SLURMout

########## Command Lines to Run ##########

## Prep assemblies
conda activate aaftf
for i in genomes/Bensp*/scaffolds.fasta
do
  funannotate clean -i $i -o ${i%.fasta}_clean.fasta
  funannotate sort -i ${i%.fasta}_clean.fasta -o ${i%.fasta}_clean_sorted.fasta
  funannotate mask -i ${i%.fasta}_clean_sorted.fasta -o ${i%.fasta}_clean_sorted_masked.fasta
done

conda deactivate

scontrol show job $SLURM_JOB_ID     ### write job information to output file
