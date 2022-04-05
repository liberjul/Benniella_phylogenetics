conda activate aaftf
module load SAMtools
minimap2 -x map-ont -a Mycavid_B1-EB.fna ./Kasson_genomes/ActspLightDraft_5_FD_Andro003/scaffolds.fasta > Andro003_to_B1-EB_BRE.sam
samtools view -F 0x4 -b Andro003_to_B1-EB_BRE.sam > Andro003_BRE_filt.bam
samtools sort Andro003_BRE_filt.bam > Andro003_BRE_filt.sorted.bam
samtools index -b Andro003_BRE_filt.sorted.bam
samtools fasta Andro003_BRE_filt.sorted.bam > Andro003_BRE_scaffolds.fasta
grep "^>" Andro003_BRE_scaffolds.fasta | wc -l
grep -v "^>" Andro003_BRE_scaffolds.fasta | wc
conda deactivate
