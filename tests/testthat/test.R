# Test CompanyInfo()

context("Data output dimensions")

skip_on_cran()

test_that("CompanyInfo returning correct dimensions", {
     expect_equal(dim(CompanyInfo("GOOG")), c(1, 8))
     expect_equal(dim(CompanyInfo("TSLA")), c(1, 8))
     expect_equal(dim(CompanyInfo("FB")), c(1, 8))
})