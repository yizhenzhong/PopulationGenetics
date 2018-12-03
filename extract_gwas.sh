
for i in {1..22}; do
        
        #extract GWAS variants (dbSNP b150 SNPs)
        plink \
        --bfile ../POPS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter \
        --extract gwas_catalog_v1.0.2-associations_e92_r2018-07-17_filtered_rsid_SNP_b150_rsid.txt \
        --make-bed --out ../GWAS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.gwas \
        
        #Prune GWAS variants within the popualtion background
        plink \
        --bfile ../GWAS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.gwas \
        --indep-pairwise 50 5 0.8 \
        --out ../GWAS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.gwas.0.8 \
        
        #get prune in SNPs
        plink \
        --bfile ../GWAS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.gwas \
        --extract ../GWAS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.gwas.0.8.prune.in \
        --make-bed --out ../GWAS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.gwas.0.8.prune.in;

        #get dupliacted SNPs
        cut -f 2 ../POPS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.bim | sort | uniq -d > ../POPS/$i.dups \
        
        #get all tagging SNPs of GWAS variants (r2>0.8)
        plink --bfile ../POPS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter \
        --r2 inter-chr \
        --ld-window-r2 0.8 \
        --ld-snp-list ../GWAS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.gwas.0.8.prune.in.bim \
        --threads 18 \
        --exclude ../POPS/$i.dups \


        cp plink.ld  ../GWAS/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.yri.biallelicOnly.recode.filter.gwas.0.8.prune.in.ld;
done

