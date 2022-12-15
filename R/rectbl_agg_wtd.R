#' Compute a weighted mean (or sum) in a {reactable} aggregation
#'
#' @param wt_col A string indicating the column to use for weighting
#' @param result Should the calculation return the weighted mean or sum?
#'
#' @return A javascript function to be used in the `agg` argument of `colDef`
#' @export
#'
#' @examples
#' rectbl_agg_wtd("my_col")
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
