raxml-ng --threads 120 --force perf_threads -msa ../alignments/with_UNITE_env/concat_Ben_UNI_filt.phy \
--workers 20 --bs-trees autoMRE{1000} --seed 52354 --all \
--model ../alignments/with_UNITE_env/concat_mtngaic_Ben_UNI_filt_part_file.txt \
--prefix raxml_mtngaic_Ben+UNITE_S-L_2021_06_22_+G --outgroup Modicella_sp_MES2146
