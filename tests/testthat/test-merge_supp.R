testthat::test_that("SUPPAE merges into AE when path is NULL", {

  # Load packaged data
  data(AE, SUPPAE, package = "suppmerge")

  # Explicitly bind into test environment
  AE <- AE
  SUPPAE <- SUPPAE

  result <- merge_supp(
    path   = NULL,
    domain = 'AE'
  )

  testthat::expect_true("AESPID" %in% names(result))
  testthat::expect_true("USUBJID" %in% names(result))
  testthat::expect_true("STUDYID" %in% names(result))
  testthat::expect_true("AESOC" %in% names(result))
  testthat::expect_true("AESOCCD" %in% names(result))
  testthat::expect_equal(nrow(result), nrow(AE))
})

testthat::test_that("unsupported extension errors", {

  testthat::expect_error(
    merge_supp(path = "dummy/", domain = 'AE', ext = ".BAD"),
    "SUPP or Main Domain File not found dummy/AE.BAD"
  )

})

# testthat::test_that("messages 1", {
#
#   testthat::expect_error(
#     merge_supp(path = "data/", domain = 'AE', ext = ".rda"),
#     "File exists data/AE.rda"
#   )
#
# })

testthat::test_that("message 2", {

  testthat::expect_message(  result <- merge_supp(
    path   = NULL,
    domain = 'AE'
  ), 'Succefully merged')
})

testthat::test_that("no SUPP rows returns main domain unchanged", {

  data(AE, SUPPAE, package = "suppmerge")

  AE <- AE
  SUPPAE <- SUPPAE[0, ]

  result <- merge_supp(path = NULL, domain = AE)

  testthat::expect_equal(names(result), names(AE))
})


