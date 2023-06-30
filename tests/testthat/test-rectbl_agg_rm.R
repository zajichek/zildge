test_that("I get a JavaScript function", {
  expect_equal(class(rectbl_agg_rm("my_col", 10)), "JS_EVAL")
})
