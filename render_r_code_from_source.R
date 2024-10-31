
# Convert the index.Rmd content to an R script for ease of use by the participants. Only
# code cells will be converted.

knitr::purl("index.Rmd", documentation = 0)

file.rename("index.R", "R_code_participant.R")
