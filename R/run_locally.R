# file: run_locally.R
# author: Danielle Navarro
# modifications: Matt Crump
# change xprmntr to jspsychr to avoid future conflict
# added options to run in browser vs viewer, and report port

#' Run a jspsych experiment
#'
#' @param path path
#' @param show_in string, "viewer" to show in viewer, or "browser" to show in browser
#' @param jspsychr_host host defaults to 127.0.0.1
#' @param jspsychr_port port defaults to 8000
#' @export
run_locally <- function(path = ".",
                        show_in = "viewer",
                        jspsychr_host = "127.0.0.1",
                        jspsychr_port = 8000) {

  pr <- plumber::plumber$new()

  static_site <- file.path(path, "experiment")
  data_folder <- file.path(path, "data")
  static_router <- plumber::PlumberStatic$new(static_site)

  pr$mount("/", static_router)
  pr$handle("POST", "/submit", function(req, res){

    dat <- jsonlite::fromJSON(req$postBody)
    dat <- readr::read_csv(dat$filedata)
    tsp <- get_timestamp()
    file_id <- paste("data", get_timestamp(), get_alphanumeric(10), sep = "_")
    dat$file_id <- file_id
    dat <- dat[, c(ncol(dat), 1:ncol(dat)-1), drop = FALSE]
    readr::write_csv(dat, file.path(data_folder, paste0(file_id, ".csv")))
  })

  # add message, and options to display in viewer or browser
  message(paste("Point the browser to http://",jspsychr_host,":",jspsychr_port, sep=""))

  if(show_in == "viewer"){
    viewer <- getOption("viewer")
    viewer(paste("http://",jspsychr_host,":",jspsychr_port, sep=""))
  }
  if(show_in == "browser") utils::browseURL(paste("http://",jspsychr_host,":",jspsychr_port, sep=""))
  #

  pr$run(swagger = FALSE, host=jspsychr_host, port= jspsychr_port)

}
