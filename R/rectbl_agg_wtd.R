#' Compute a weighted mean (or sum) in a {reactable} aggregation
#'
#' @param wt_col A string indicating the column to use for weighting
#' @param result Should the calculation return the weighted mean or sum?
#'
#' @return A javascript function to be used in the `agg` argument of `colDef`
#' @export
#'
#' @examples
#' if(require("reactable")) {
#' set.seed(123)
#' n <- 10
#' reactable(
#'  data =
#'    tibble::tibble(
#'      Group = rep(c("A", "B"), n / 2),
#'      Weight = rbinom(n, size = 500, prob = 1 / (1:n + 1)),
#'      `Mean of Groups` = rnorm(n, mean = 1:n),
#'      `Weighted Mean` = `Mean of Groups`,
#'      `Sum of Groups` = `Mean of Groups`,
#'      `Weighted Sum` = `Mean of Groups`
#'    ),
#'  groupBy = "Group",
#'  columns =
#'    list(
#'      Weight = colDef(aggregate = "sum"),
#'      `Mean of Groups` = colDef(aggregate = "mean"),
#'      `Weighted Mean` = colDef(aggregate = rectbl_agg_wtd("Weight")),
#'      `Sum of Groups` = colDef(aggregate = "sum"),
#'      `Weighted Sum` = colDef(aggregate = rectbl_agg_wtd("Weight", result = "sum"))
#'    )
#')
#'}
#'
rectbl_agg_wtd <-
  function(
    wt_col,
    result = c("mean", "sum")
  ) {

    # Check for a weight column
    if(missing(wt_col))
      stop("Please supply a column in the table to weight by.")

    # Get the result type
    result <- match.arg(result)

    # Build the string template of the JS function
    js_string <-
      paste0(
        "function(values, rows) {
            var numerator = 0
            var denominator = 0

            rows.forEach(function(row, index) {
                numerator += row['", wt_col, "'] * values[index]
                denominator += row['", wt_col, "']
            })

            if('", result, "' == 'mean') {
                return numerator / denominator
            } else {
                return numerator
            }
        }"
      )

    # Parse the string to a formal javascript function
    htmlwidgets::JS(js_string)

  }
