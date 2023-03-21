#' Personalized ggplot theme
#'
#' @return A ggplot theme
#' @export
#'
#' @examples
#' theme_zildge()
theme_zildge <-
  function() {

    ggplot2::theme(
      panel.background = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_line(color = "gray")
    )

  }
