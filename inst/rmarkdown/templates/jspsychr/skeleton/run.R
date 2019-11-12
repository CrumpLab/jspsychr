# Run the experiment locally in a web-browser, using plumber
# After the experiment is complete, the data should be stored in the data folder
# when finished, "stop" the server that will be be started by this code

library(jspsychr)

# NOTE: about file paths
# Experiment_1 is the assumed name of the parent folder containing the jspsychR template
# Change this to the name of your folder
# The assumption is your folder is inside an R project, which controls the default working directory

# compiles the experiment file into html
rmarkdown::render("Experiment_1/experiment/index.Rmd", "html_document")

# runs the html in your browswer
run_locally(path="Experiment_1",
            show_in = "browser",
            jspsychr_host = "127.0.0.1",
            jspsychr_port = 8000)
 

