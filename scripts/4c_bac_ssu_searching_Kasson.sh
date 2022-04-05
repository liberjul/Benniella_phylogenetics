#!/bin/bash -login

genome_folder=Kasson_genomes
for i in $genome_folder/*/scaffolds.fasta
do
  ~/bin/hmmer/src/nhmmer --tblout ${i%.fasta}_16S_hmm.out -T 70 ~/bin/rRNA_prediction/rRNA_hmm_fs_wst_v0/HMM3/bac_ssu.hmm $i > /dev/null
  python ../Benniellas/pull_hmm_hits.py -f $i -m ${i%.fasta}_16S_hmm.out -o ${i%.fasta}_16S.fasta
  taxa=$(echo $i | cut -d"/" -f2)
  sed -i "s/>/>${taxa}|/" ${i%.fasta}_16S.fasta
done
cat $genome_folder/*/scaffolds_16S.fasta > 16S_combined.fasta
SINTAXPATH=/mnt/research/rdp/public/thirdParty/usearch10.0.240_i86linux64
"$SINTAXPATH" -sintax 16S_combined.fasta \
  -db /mnt/ufs18/rs-022/bonito_lab/CONSTAX_May2020/SILVA_Bacteria_tf/sintax.db \
  -tabbedout 16S_combined.sintax -strand both -sintax_cutoff .8 -threads 12

grep "Mollicutes" 16S_combined.sintax > Kasson_isolates_Mollicutes.sintax

> Kasson_isolates_Mollicutes_scaffolds.fasta
> Kasson_isolates_Mollicutes_16S.fasta
while read -r line
do
  genome=$(echo $line | cut -d"|" -f1)
  contig=$(echo $line | cut -d"|" -f2 | sed 's/_\[.*//')
  awk "/>${contig}/{f=1; c=0} f; />/ && ++c==2{f=0}" ./$genome_folder/$genome/scaffolds.fasta | sed "s/>/>${genome}|/g" | head -n-1 >> Kasson_isolates_Mollicutes_scaffolds.fasta
  awk "/${contig}/{f=1; c=0} f; />/ && ++c==2{f=0}" 16S_combined.fasta | head -n-1 >> Kasson_isolates_Mollicutes_16S.fasta
done < Kasson_isolates_Mollicutes.sintax

grep "Burkholderiaceae" 16S_combined.sintax > Kasson_isolates_BRE.sintax

> Kasson_isolates_BRE_scaffolds.fasta
> Kasson_isolates_BRE_16S.fasta
while read -r line
do
  genome=$(echo $line | cut -d"|" -f1)
  contig=$(echo $line | cut -d"|" -f2 | sed 's/_\[.*//')
  awk "/>${contig}/{f=1; c=0} f; />/ && ++c==2{f=0}" ./$genome_folder/$genome/scaffolds.fasta | sed "s/>/>${genome}|/g" | head -n-1 >> Kasson_isolates_BRE_scaffolds.fasta
  awk "/${contig}/{f=1; c=0} f; />/ && ++c==2{f=0}" 16S_combined.fasta | head -n-1 >> Kasson_isolates_BRE_16S.fasta
done < Kasson_isolates_BRE.sintax
# python pull_sintax_hits.py -g ./genomes -s Kasson_isolates_Mollicutes.sintax -o Kasson_isolates_Mollicutes.fasta
