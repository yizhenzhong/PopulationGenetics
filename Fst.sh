for i in {1..22}; do
        plink --vcf ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
        --keep-fam 20130607_YRI_CEU.pop \
        --make-bed \
        --out  ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.YRI.CEU \

        gcta64 --bfile ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.YRI.CEU \
                --thread-num 20 --fst --sub-popu subpopu.add.txt --out ./fst/20130502.genotypes.YRI.CEU.chr$i; 
done



