for i in ../alignments/multilocus/unaligned_SSU-LSU\.*.fasta
do
  if [[ "$i" != *"full"* ]]
  then
    outname=$(basename -- $i)
    echo ../alignments/multilocus/aligned${outname#?????????}
    muscle -in $i -out ../alignments/multilocus/aligned${outname#?????????}
  fi
done

for i in EF1a RPB1 1870
do
  if [[ "$i" != *"full"* ]]
  then
    outname=$(basename -- $i)
    echo ../alignments/multilocus/aligned_"$i".fasta
    muscle -in ../alignments/multilocus/unaligned_"$i".fasta -out ../alignments/multilocus/aligned_"$i".fasta
  fi
done
