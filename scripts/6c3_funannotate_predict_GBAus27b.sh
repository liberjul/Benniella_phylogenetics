#!/bin/bash --login
########## Define Resources Needed with SBATCH Lines ##########

#SBATCH --time=12:00:00             # limit of wall clock time - how long the job will run (same as -t)
#SBATCH --ntasks=1                 # number of tasks - how many tasks (nodes) that you require (same as -n)
#SBATCH --cpus-per-task=24          # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=10G                   # memory required per node - amount of memory (in bytes)
#SBATCH --job-name=funannotate_predict_GBA27b        # you can give your job a name for easier identification (same as -J)
#SBATCH --output=%x-%j.SLURMout

########## Command Lines to Run ##########

## Prep assemblies
conda activate aaftf
module load GCC/10.2.0  OpenMPI/4.0.5 AUGUSTUS/3.4.0 DIAMOND
cd /mnt/scratch/liberjul/Benniella_genomes/funannotate_working_dir

funannotate predict -i /mnt/home/liberjul/Bonito_Lab/LCG/GBAus27b_ref/MorGBAus27b_1_AssemblyScaffolds_Repeatmasked.fasta \
  -o ~/Bonito_Lab/LCG/GBA27b_FA_train_db_2 -s "Benniella erionia" --strain GBA27b --cpus 24 --optimize_augustus
conda deactivate

scontrol show job $SLURM_JOB_ID     ### write job information to output file
