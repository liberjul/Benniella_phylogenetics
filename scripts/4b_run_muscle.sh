for i in ../alignments/with_UNITE_env/unaligned\.*.fasta
do
  if [ "$i" != *"full"* ]
  then
    outname=$(basename -- $i)
    echo ../alignments/with_UNITE_env/aligned${outname#?????????}
    muscle -in $i -out ../alignments/with_UNITE_env/aligned${outname#?????????}
  fi
done
if [ -f ../alignments/with_UNITE_env/aligned.full.fasta ]
then
  rm ../alignments/with_UNITE_env/aligned.full.fasta
fi
