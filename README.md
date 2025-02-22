# R charting

This introduction to R charting using ggplot2 is suitable for those who have completed the 
[Intro R training](https://github.com/moj-analytical-services/IntroRTraining) or have at least 
reached an equivalent standard to having done this.  

<br>

## For attendees

You will find the following documents useful:

* [The session presentation](https://moj-analytical-services.github.io/ggplotTraining/)   
* [R_code_participant.R](R_code_participant.R) - this script contains the code used in the training session  
  
This training session is run in person/over Teams every few months. Alternatively, you can go 
through this material in your own time. Recordings of these sessions can be viewed via links 
provided in the [Analytical Platform and related tools training section on R training](https://moj-analytical-services.github.io/ap-tools-training/ITG.html#r-training). If you 
have any access problems please contact <aidan.mews@justice.gov.uk>.If you work 
through the material by yourself please leave feedback about the material 
[here](https://airtable.com/shr9u2OJB2pW8Y0Af).  

**Please contact [Aidan Mews](aidan.mews@justice.gov.uk) if you have any questions.**

### Set up instructions
* [Ensure you have access to the Analytical Platform](https://user-guidance.analytical-platform.service.justice.gov.uk/get-started.html#quickstart-guide).
* [Ensure you have linked RStudio and GitHub with an SSH key](https://user-guidance.analytical-platform.service.justice.gov.uk/github/set-up-github.html).
* [Clone](https://user-guidance.analytical-platform.service.justice.gov.uk/github/rstudio-git.html#work-with-git-in-rstudio) this repo as an RStudio project.
* Run `renv::restore()` to install the required R packages.

<br>

## For presenters

* `index.Rmd` is the markdown for the presentation slides (knitted to `index.html`).
* The Github.io page with the presentation should deploy after each PR to the `master` branch.
* If changes are made to the slides please recreate the `R_code_participant.R` file by running the 
code in `render_r_code_from_source.R`.
* Solutions to the exercises are found in the `solutions.Rmd` file (knitted to `solutions.html`). 
The HTML solutions are not automatically deployed so to use them you will either need to open them
in R studio or download them from GitHub and view them in a browser.
