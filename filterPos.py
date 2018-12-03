import sys
from os.path import basename


def getPosMap(map_f):
        snp_dict = {}
        for line in open(map_f):
                items = line.split()
                snp_dict[items[1]+"_"+items[3]]=[]
        return snp_dict        

def removePos(vcf, out):
        """
        remove the line with duplicated position 
        in vcf file
        """
        pos = {}
        f = open(vcf)
        out_f = open(out, "w")
        for line in f:
                if line[0] == '#':
                        out_f.write(line)
                else:
                        items = line.split()
                        if items[1] in pos:
                                continue
                        else:
                                out_f.write(line)
                                pos[items[1]] = []
        out_f.close()


def removeSNPs(vcf, out, snp_dict):
        """
        remove the SNPs in a vcf based on the SNP ID in a map file
        """
        #write_snp = {}
        f = open(vcf)
        n = 0
        out_f = open(out, "w")
        for line in f:
                if line[0] == "#":
                        out_f.write(line)
                else:
                        items = line.split()
                        if items[2]+"_"+items[1] not in snp_dict:
                                continue
                        #if items[2] in write_snp:
                        #        print(items[2])
                        #        continue
                        else:
                                out_f.write(line)
                                if n == 0:
                                        n == len(items)
                                else:
                                        if len(items) != n:
                                                print(line)
         #                       write_snp[items[2]] = []
        out_f.close()


vcf = sys.argv[1]
if sys.argv[2] == "filter":
        print("***************************")
        print("filter duplicated SNPs.....")
        print("***************************")
        out = sys.argv[1][:-4] + ".filter.vcf"
        removePos(sys.argv[1], out)
        
elif sys.argv[2] == "reorder":
        print("***************************")
        print("reorder SNPs.....")
        print("***************************")
        out = sys.argv[1][:-4] + ".reorder.vcf"
        maps = sys.argv[3]
        snp_dict = getPosMap(maps)
        print(out)
        print(vcf)

        removeSNPs(vcf, out, snp_dict)
