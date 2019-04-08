import sys
import gzip

def convert_geno(geno):
    for i in range(len(geno)):
        if geno[i][0]=="." or geno[i][2] == ".":
            geno[i] = "NA"
        else:
            geno[i] =  str(int(geno[i][0])+int(geno[i][2]))
        return geno


def convert_dosage(geno):
        for i in range(len(geno)):
            temp = geno[i].split(":")[1].split(",")
            geno[i] = str(float(temp[1])+float(temp[2])*2)
        return geno
            
            
def write_geno(vcf, offset, convert):
        if vcf.endswith(".gz"):
            f = gzip.open(vcf)
            fname = '.'.join(vcf.split('.')[:-2])
        else:
            f = open(vcf)
            fname = '.'.join(vcf.split('.')[:-1])            
        f_new = open(fname+".geno.txt","w")
        for line in f:
            if line[0:5] == "#CHRO":
                items = line.split()
                f_new.write(items[2]+" ")
                f_new.write(" ".join(items[offset:])+"\n")
            elif line[0] == "#":
                continue
            else:
                items = line.split()
                f_new.write(items[2]+" ")
                geno = items[offset:]
                if convert == "genotype":                           
                    new_geno = convert_geno(geno) 
                elif convert == "dosage":
                    new_geno = convert_dosage(geno)
                    f_new.write(" ".join(new_geno)+"\n")
        f_new.close()                                                       


import sys
f = sys.argv[1]
offset = int(sys.argv[2])
convert = sys.argv[3]
write_geno(f, offset, convert)

