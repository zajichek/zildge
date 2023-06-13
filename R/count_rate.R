#' Make an inline count/rate calculation
#'
#' @param x A (typically logical) vector
#' @param count_fun A function to compute the count. Defaults to \code{sum}.
#' @param rate_fun A function to compute the rate. Defaults to \code{mean},
#' @param digits Round the rate digits
#'
#' @return A string with formatted count/rate
#' @export
#'
#' @examples
#' set.seed(123)
#' x <- rbinom(500, 1, 0.25)
#' inline_count_rate(x)
inline_count_rate <-
  function(x, count_fun = sum, rate_fun = mean, digits = 1) {
    paste0(count_fun(x), " (", round(rate_fun(x) * 100, digits = digits), "%)")
  }
