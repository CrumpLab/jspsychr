# author: Matt Crump
#' Write json to js script
#'
#' @param json_object string a json object
#' @param var_name character default=NULL, set name to declare json object as a variable
#'
#' @return string printed to the html as a <script></script>
#' @export
#'
#' @description To be used in a knitr code chunk with results="asis"
#'
#' @examples
#'
#'
write_to_script <- function(json_object,var_name=NULL){
  if(is.null(var_name)){
    return(cat("<script>", json_object,"; </script>"))
  }else{
    return(cat("<script>", "var ",var_name,"= ", json_object,"; </script>"))
  }
}
