test_that("I get a string", {
  expect_equal(inline_count_rate(c(1,0,1,0)), "2 (50%)")
})
