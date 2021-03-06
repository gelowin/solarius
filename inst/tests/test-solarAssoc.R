
context("solarAssoc")

# input data
test_that("input data parameters `genocovdata` and `genodata`", {
  data(dat50)
  snps <- 1:2
  
  mod1 <- solarAssoc(trait ~ 1, phenodata, snpdata = genodata[, snps], kinship = kin)
  mod2 <- solarAssoc(trait ~ 1, phenodata, snpcovdata = genocovdata[, snps], kinship = kin)
  
  expect_equal(mod1$snpf$pSNP, mod2$snpf$pSNP)
})

test_that("different results for different kinship matrices", {
  data(dat50)
  snps <- 1:2
  
  mod1 <- solarAssoc(trait ~ 1, phenodata, snpdata = genodata[, snps], kinship = kin)
  mod2 <- solarAssoc(trait ~ 1, phenodata, snpcovdata = genocovdata[, snps], kinship = 2*kin)
  
  expect_true(all((mod1$snpf$pSNP != mod2$snpf$pSNP)))
})

