# author: Matt Crump
#' compile with minimal html template
#'
#' @param css string, paths to css files
#'
#' @return compiled html document
#' @export
#'
#' @description Useful for creating external htmls in jspsych
#'
#' @examples
#'
#'
basic_html <- function(...){

  template <- system.file("rmarkdown/basic_template.html",package="jspsychr")

  rmarkdown::html_document(
    template = template,
    ...
  )
}
