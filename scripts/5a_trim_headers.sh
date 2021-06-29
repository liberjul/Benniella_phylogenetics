for i in 5_8S ITS1 ITS2 LSU SSU
do
  python remove_annot_from_headers.py -i ../alignments/multilocus/aligned_SSU-LSU."$i".fasta \
   -o ../alignments/multilocus/aligned_SSU-LSU."$i"_trimmed.fasta -e "_SSU-LSU"
done

for i in EF1a RPB1 1870
do
  python remove_annot_from_headers.py -i ../alignments/multilocus/aligned_"$i".fasta \
  -o ../alignments/multilocus/aligned_"$i"_trimmed.fasta -e "_$i"
done
