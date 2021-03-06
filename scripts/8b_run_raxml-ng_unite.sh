sed -i 's/$/;/' ../modeltest_results/multilocus/modeltest_ng_ben_multilocus_$(date -u +%Y_%m_%d)_+G.part.aic

raxml-ng --threads 120 --force perf_threads -msa ../alignments/with_UNITE_env/concat_Ben_UNI_filt.phy \
--workers 20 --bs-trees autoMRE{1000} --seed 52354 --all \
--model ../modeltest_results/multilocus/modeltest_ng_ben_multilocus_$(date -u +%Y_%m_%d)_+G.part.aic \
--prefix raxml_mtngaic_Ben+UNITE_S-L_$(date -u +%Y_%m_%d)_+G --outgroup Modicella_sp_MES2146
