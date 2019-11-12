# author: Matt Crump

#' Convert stimulus dataframe to json object
#'
#' @param df dataframe containins stimulus column with html for each stimulus, and additional columns for data codes
#' @param stimulus character name of the stimulus column
#' @param data character vector names of columns to include as data codes
#' @param pretty logical true = pretty format, false=not pretty
#' @return string a json object definition that can supply jsPsych with stimulus information
#' @export
#'
#' @examples
#'
#' # create a stimulus dataframe
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
#'   # convert to json
#'   stimulus_df_to_json(stroop_stim,"stimulus",c("word","color","response"))
#'
stimulus_df_to_json <- function(df,stimulus, data, pretty=TRUE){
  temp_list <- list()
  for(i in 1:dim(df)[1]){
    temp_list[[i]] <- list(stimulus = df[i,stimulus],
                           data = as.list(df[i,data]))
  }
  return(jsonlite::toJSON(temp_list, auto_unbox = TRUE, pretty=pretty))
}
