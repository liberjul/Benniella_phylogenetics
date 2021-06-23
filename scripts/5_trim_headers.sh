for i in ../alignments/with_UNITE_env/aligned\.*.fasta
do
  python remove_annot_from_headers.py -i $i -o ${i%.fasta}_trimmed.fasta -e "_SSU-LSU"
done
