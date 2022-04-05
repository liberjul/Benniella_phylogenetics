yes | conda install -c bioconda muscle itsx raxml-ng modeltest-ng

conda create -n aaftf "python>=3.6" bbmap trimmomatic bowtie2 bwa pilon sourmash \
    blast minimap2 spades megahit novoplasty biopython
conda activate aaftf
python -m pip install git+https://github.com/stajichlab/AAFTF.git
python -m pip install funannotate
