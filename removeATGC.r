list.of.packages <- c("data.table")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos = "http://cran.us.r-project.org")
library(data.table)
read.bim <- function(f){
        bim <- fread(paste0(f,".bim"), header = F, stringsAsFactors = F)
        return(bim)
}


get_ATGC <- function(bim){
        index1=which(bim$V5=="A" & bim$V6=="T")
        index2=which(bim$V5=="T" & bim$V6=="A")
        index3=which(bim$V5=="G" & bim$V6=="C")
        index4=which(bim$V5=="C" & bim$V6=="G")
        return(c(index1, index2, index3, index4))
}


snp.list <- function(index, bim){
        
        print(paste0("remove " ,length(index), " SNPS"))
        write.table(bim$V2[index], "temp.txt", col.names = F, row.names = F, quote = F)
}


subset.plink <- function(f){
        script = paste0("plink --bfile ",f," --exclude temp.txt --make-bed --out ", f,".removeATGC")
        system(script)
        unlink("temp.txt")
}



args = commandArgs(trailingOnly=TRUE)
f = args[1]
print(f)
bim = read.bim(f)
index = get_ATGC(bim)
snp.list(index, bim)
subset.plink(f)
