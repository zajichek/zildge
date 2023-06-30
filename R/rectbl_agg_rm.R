#' Remove text from cells in a {reactable} aggregation
#'
#' @description
#' Removes the text from cells in which a specified column in that row exceeds a threshold
#'
#' @param col A string indicating the column to evaluate
#' @param threshold The threshold for `col` to remove text from the current cell
#'
#' @return A javascript function to be used in the `style` argument of \code{\link[reactable]{colDef}}
#' @export
#'
#' @examples
#' if(require("reactable")) {
#'
#'   # Make data set
#'   set.seed(123)
#'   n <- 10
#'   dat <-
#'     tibble::tibble(
#'       Group = rep(c("A", "B"), n / 2),
#'       Weight = rbinom(n, size = 500, prob = 1 / (1:n + 1)),
#'       `Mean of Groups` = rnorm(n, mean = 1:n),
#'       `Sum of Groups` = `Mean of Groups`
#'     )
#'
#'   # Make table
#'   reactable(
#'     data = dat,
#'     groupBy = "Group",
#'     columns =
#'       list(
#'         Weight = colDef(style = rectbl_agg_rm("Weight", 400), aggregate = "sum"),
#'         `Mean of Groups` = colDef(style = rectbl_agg_rm("Weight", 400), aggregate = "mean"),
#'         `Sum of Groups` = colDef(aggregate = "sum")
#'       )
#'   )
#'
#' }
#'
rectbl_agg_rm <-
  function(col, threshold) {
    htmlwidgets::JS(
      paste0(
        "function(rowInfo) {
          if(rowInfo.row['", col, "'] > ", threshold, ") {
            return {fontSize:0}
          }
        }"
      )
    )
  }
