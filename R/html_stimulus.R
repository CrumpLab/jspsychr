# file: html_stimulus.R
# author: Matt Crump

#' Write html stimulus description from dataframe
#'
#' @param df data.frame containing stimulus information and css codes in columns
#' @param html_content character column name containing html content to be placed between html element tags
#' @param html_element character the html element tag to use
#' @param column_names vector of column names containing css attribute definitions
#' @param css vector of names containing valid css attribute names
#' @param id character to set the id of the html element, defaults to "my_stim"
#'
#' @return vector of html code defining each stimulus
#' @export
#'
#' @examples
#'
#' # define a data frame with stimulus info
#' stroop_stim <- data.frame(stimulus = length(16),
#'   word = rep(c("red","green","blue","yellow"), each=4),
#'   color = rep(c("red","green","blue","yellow"), 4),
#'   response = rep(c("r","g","b","y"), 4),
#'   id = "stroop_stim",
#'   fontsize = "16pt")
#'
#'   head(stroop_stim)
#'
#' # create html stimulus definition
#' html_stimulus(df = stroop_stim,
#'  html_content = "word",
#'  html_element = "p",
#'  column_names = c("color","fontsize"),
#'  css = c("color", "font-size"),
#'  id = "id"
#'  )
#'
#'  # use in a pipe to add stimulus definition to stimuli column
#'  library(dplyr)
#'  stroop_stim <- data.frame(stimulus = length(16),
#'     word = rep(c("red","green","blue","yellow"), each=4),
#'     color = rep(c("red","green","blue","yellow"), 4),
#'     response = rep(c("r","g","b","y"), 4),
#'     id = "stroop_stim",
#'     fontsize = "16pt") %>%
#'   mutate(stimulus = html_stimulus(df = .,
#'                      html_content = "word",
#'                      html_element = "p",
#'                      column_names = c("color","fontsize"),
#'                      css = c("color", "font-size"),
#'                      id = "id"))
#'   head(stroop_stim)
#'
#'
html_stimulus <- function(df, html_content, html_element, column_names, css=NULL, id="my_stim"){

  # assign ids
  if(!is.null(df$id)){
    write_id <- paste("id = '", df[,id],"'", sep="")}
  else{
    write_id <- paste("id = '", id,"'", sep="")
  }


  # if css is NULL assume column_names are valid css attributes
  if(is.null(css)) css <- column_names

  # write style definitions for each css attribute
  css_df <- data.frame(row.names=1:dim(df)[1])
  for(i in 1:length(column_names)){
    css_df[,i] <- paste(css[i],": ", df[,column_names[i]], ";", sep="")
  }

  # paste together in one style definition
  css_df <- tidyr::unite(css_df, col="style", sep=" ")
  write_style <- paste("style = '",css_df$style,"'",sep="")

  #write the html element definition
  write_html <- paste("<",html_element," ",
                      write_id, " ",
                      write_style,">",
                      df[,html_content],
                      "</",html_element,">", sep="")

  return(write_html)

}
