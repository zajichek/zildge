test_that("I get a JS object", {
  expect_equal(class(rectbl_agg_wtd("my_col")), "JS_EVAL")
})
