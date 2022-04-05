# Benniella_phylogenetics

### Benniella multi-locus trees

Using the loci RPB1, EF1a, Xanthine Dehydrogenase (1870, from Linnemannia elongata AG77 gene numbers), in addition to SSU, ITS1, 5.8S, ITS2, and LSU loci, phylogenetic trees were inferred.

Each locus was independently aligned, then concatenated, then codon positions were used for partition for protein-coding genes. ModelTest-NG was used to assess substitution models.

Trees were inferred with RAxML-NG (with the suggested substitution models by AIC score) or Mr. Bayes with the supplied partition. Mr. Bayes can be executed using the `.nex` file which includes data and execution parameters. These were run on the [CIPRES](https://www.phylo.org/) platform. Mr. Bayes was implemented with BEAGLE enabled.

### Benniella + Environmental Sequences

The workflow follows the order of the scripts. Running 1->2b->**manual filter**->3b->4b->5b->6b->7b->8b will replicate the analysis.

Note: After UNITE database search, a limited set of taxa were determined to fall within the Benniella clade and were added to the SSU-LSU alignment. This filtering takes place between scripts 2b and 3b.

ITSx was then used to pull out individual regions, which were aligned separately then concatenated.

ModelTest-NG was used to assess the best nucleotide substitution models for each region.

As above RAxML-NG and Mr. Bayes were used for inference with corresponding inputs.

File name outputs of modeltest-ng and raxml-ng include dates, so check that 7b and 8b are run on the same day.

### Benniella genomes

Scripts are numbered <number>c<script_name>.sh, to be run in order. This pipeline requires that genome sequencing reads be downloaded from the [JGI Genome Portal](https://genome.jgi.doe.gov/portal/). 2c can be skipped because reads are already trimmed and filtered when downloaded.
