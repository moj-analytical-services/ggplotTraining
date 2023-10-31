
# Convert the index.Rmd content to an R script for ease of use by the participants. Only
# code cells will be converted.

knitr::purl("index.Rmd")

file.rename("index.R","example_code.R")
