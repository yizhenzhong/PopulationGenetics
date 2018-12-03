###get vcf for speicifc population
 bcftools view -S ../1000genome_ceu.sample \
 ../ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
 >../POPS/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.vcf


#remove biallelic sites
vcftools --vcf ../POPS/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.vcf \
--min-alleles 2 --max-alleles 2 \
--out ../POPS/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.biallelicOnly --recode

##remove duplicated position
python filterPos.py ../POPS/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.biallelicOnly.recode.vcf filter \

##get map file
grep PASS  ../POPS/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.biallelicOnly.recode.filter.vcf \
| awk '{print $1, $3, 0, $2}' | tail -n +2 > ../POPS/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.biallelicOnly.recode.filter.map


#run selscan, using input file of vcf format
/projects/b1047/zhong/software/selscan/bin/linux/selscan -\
-ihs --map  ../POPS/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.biallelicOnly.recode.filter.map \
--vcf ../POPS/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.biallelicOnly.recode.filter.vcf \
--out ../selscan/ALL.chr$MOAB_JOBARRAYINDEX.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.ceu.biallelicOnly.recode.filter           

