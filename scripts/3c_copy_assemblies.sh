# Benniellas
WORKDIR=/mnt/scratch/liberjul/Benniella_genomes/working_AAFTF_pe
OUTDIR=genomes
for i in BenspLightDraft_*/Filtered_Raw_Data/*.fastq.gz
do
  BASE=$(basename ${i%.fastq.gz})
  if ! [ -d $OUTDIR/$(echo $i | cut -d'/' -f1) ]
  then
    mkdir $OUTDIR/$(echo $i | cut -d'/' -f1)
  fi
  cp $WORKDIR/spades_${BASE}/*.fasta $OUTDIR/$(echo $i | cut -d'/' -f1)
done

# Kasson isolates
WORKDIR=/mnt/scratch/liberjul/Kasson_genomes/working_AAFTF_pe
OUTDIR=Kasson_genomes
for i in *LightDraft_*/Filtered_Raw_Data/*.fastq.gz
do
  BASE=$(basename ${i%.fastq.gz})
  if ! [ -d $OUTDIR/$(echo $i | cut -d'/' -f1) ]
  then
    mkdir $OUTDIR/$(echo $i | cut -d'/' -f1)
  fi
  cp $WORKDIR/spades_${BASE}/*.fasta $OUTDIR/$(echo $i | cut -d'/' -f1)
done
