conda activate aaftf
module load SAMtools
minimap2 -x map-ont -a ../../MRE_genomes/GBAus27b-MRE-ap.1104331.scaffolds.fa ./genomes/BenspLightDraft_4_FD_JL58/scaffolds.fasta > JL58_MRE_to_GBAus27b_MRE.sam
samtools view -F 0x4 -b JL58_MRE_to_GBAus27b_MRE.sam > JL58_MRE_filt.bam
samtools sort JL58_MRE_filt.bam > JL58_MRE_filt.sorted.bam
samtools index -b JL58_MRE_filt.sorted.bam
samtools fasta JL58_MRE_filt.sorted.bam > JL58_MRE_scaffolds.fasta
grep "^>" JL58_MRE_scaffolds.fasta | wc -l
grep -v "^>" JL58_MRE_scaffolds.fasta | wc
conda deactivate
