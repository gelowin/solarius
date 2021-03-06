### inc
#library(solarius)
library(devtools)
load_all(".")

library(gait1)

### par
cores <- 64

#pdir <- "/home/datasets/GAIT1/GWAS/SFBR"
#pdir <- "/home/andrey/Datasets/GAIT1/SFBR/subset"

pdir <- "/home/datasets/GAIT1/GWAS/SFBR/"
phefile <- file.path(pdir, "gait1.phe")
pedfile <- file.path(pdir, "gait1.ped")

#gdir1 <- file.path(pdir, "Impute/c1.1.500/")
#gdir2 <- file.path(pdir, "Impute/c1.501.1000/")

### var
#gait1.snpfiles <- gait1.snpfiles(chr = 1, num.snpdirs = 2)
#gait1.snpfiles <- gait1.snpfiles(chr = 22)
#gait1.snpfiles <- gait1.snpfiles(chr = 1)


#AQUI!!!
gait1.snpfiles <- gait1.snpfiles()
#gait1.snpfiles <- gait1.snpfiles(chr = 21:22)

### read phen. data
pdat <- readPhen(phefile, sep.phen = "\t", ped.file = pedfile)

### polygenic model
#M <- solarPolygenic(bmi ~ 1, pdat)
pdat$newTrait <- pdat$FXI_T*5.1
M <- solarPolygenic(newTrait ~ AGE, pdat, covtest=T)


#M <- solarPolygenic(FXI_T ~ AGE+SEX, pdat, covtest=T)
## assoc. model
#genocov.files <- c(file.path(gdir1, "snp.genocov"), file.path(gdir2, "snp.genocov"))
#snplists.files <- c(file.path(gdir1, "snp.geno-list"), file.path(gdir2, "snp.geno-list"))
#snpmap.files <- c(file.path(gdir1, "map.c1.1.500"), file.path(gdir2, "map.c1.501.1000"))

#A <- solarAssoc(bmi ~ 1, pdat, genocov.files = genocov.files[1], snplists.files = snplists.files[1], snpind = 1:4)
#A <- solarAssoc(bmi ~ 1, pdat, genocov.files = genocov.files[1], snplists.files = snplists.files[1], cores = 2)
#A <- solarAssoc(bmi ~ 1, pdat, genocov.files = genocov.files, snplists.files = snplists.files)
#A <- solarAssoc(bmi ~ 1, pdat, genocov.files = genocov.files, snplists.files = snplists.files, snpmap.files = snpmap.files, cores = 2)
A <- solarAssoc(newTrait ~ AGE, pdat, genocov.files = gait1.snpfiles$genocov.files, snplists.files = gait1.snpfiles$snplists.files, snpmap.files = gait1.snpfiles$snpmap.files, cores = cores)
#A <- solarAssoc(bmi ~ 1, pdat, genocov.files = gait1.snpfiles$genocov.files, snplists.files = gait1.snpfiles$snplists.files, snpmap.files = gait1.snpfiles$snpmap.files, cores = cores)
