sed -i 's/$/;/' ../modeltest_results/multilocus/modeltest_ng_ben_multilocus_$(date -u +%Y_%m_%d)_+G.part.aic

raxml-ng --threads 120 --force perf_threads -msa ../alignments/multilocus/concat_Ben_multilocus.phy \
--workers 20 --bs-trees autoMRE{1000} --seed 52354 --all \
--model ../modeltest_results/multilocus/modeltest_ng_ben_multilocus_$(date -u +%Y_%m_%d)_+G.part.aic \
--prefix raxml_mtngaic_Ben_multilocus_$(date -u +%Y_%m_%d)_+G --outgroup MES2146
