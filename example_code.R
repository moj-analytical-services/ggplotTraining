## ---- include=FALSE--------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE, cache = FALSE)



## --------------------------------------------------------------------------------------------------------------------------------------------
# Basic Plot

# Set seed for plot
set.seed(5)

# Visualise plot
plot(rnorm(20), rnorm(20))


## ---- highlight=TRUE-------------------------------------------------------------------------------------------------------------------------
import::from("ggplot2", "aes", "mpg")


## ---- highlight=TRUE-------------------------------------------------------------------------------------------------------------------------
import::from("magrittr", "%>%")


## --------------------------------------------------------------------------------------------------------------------------------------------
# Examine the mpg dataset
dplyr::glimpse(mpg)


## ----eval = FALSE----------------------------------------------------------------------------------------------------------------------------
## # ggplot2 blueprint to making any plot
## ggplot(data = <DATA>) +
##   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


## ---- eval=FALSE-----------------------------------------------------------------------------------------------------------------------------
## # ggplot2 works with layers, each layers is added with the `+` operator.
## ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
##   ggplot2::geom_point()


## ---- fig.height=3, fig.width=4--------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg) +
  ggplot2::geom_point(aes(x = displ, y = hwy))


## ---- fig.height=3, fig.width=6--------------------------------------------------------------------------------------------------------------
# Aesthetics
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, colour = class)) +
  ggplot2::geom_point()


## ---- fig.height=4, fig.width=8--------------------------------------------------------------------------------------------------------------
# ggplot2 does some clever things when deciding what colours to use
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, colour = year)) +
  ggplot2::geom_point()


## ---- fig.height=4, fig.width=8--------------------------------------------------------------------------------------------------------------
# You can also use shapes to distinguish between categories, such as class.
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, shape = class, colour = class)) +
  ggplot2::geom_point()


## ---- fig.height=4, fig.width=8--------------------------------------------------------------------------------------------------------------
# Some aesthetics are only suitable in certain situations
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, shape = class, colour = class)) +
  ggplot2::geom_point()


## ---- fig.height=3.5, fig.retina=2-----------------------------------------------------------------------------------------------------------
# You can also specify things manually
dplyr::filter(mpg, manufacturer %in% c('audi', 'volkswagen')) %>% 
  ggplot2::ggplot(aes(x = displ, y = hwy, colour = manufacturer, shape = manufacturer)) +
  ggplot2::geom_point(size = 3) +
  ggplot2::scale_colour_manual(values = c("audi" = "#28b7b7", "volkswagen" = "violet")) +
  ggplot2::scale_shape_manual(values = c("audi" = 1, "volkswagen" = 24))


## ---- fig.height=4, fig.width=8--------------------------------------------------------------------------------------------------------------
# You don't *have* to map aesthetics onto variables; you can specify them manually.
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_point(colour = "orange")


## ---- fig.height=3, fig.width=5--------------------------------------------------------------------------------------------------------------
# What's wrong with this code? Why aren't the points blue?
ggplot2::ggplot(data = mpg) +
  ggplot2::geom_point(aes(x = displ, y = hwy, colour = "blue"))


## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_point() +
  ggplot2::facet_wrap(~ class, nrow = 2)


## --------------------------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_point() +
  ggplot2::facet_grid(drv ~ class)


## ---- echo=FALSE, out.width="600px"----------------------------------------------------------------------------------------------------------
knitr::include_graphics("images/cheatsheet.png")


## ---- fig.height=4---------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_smooth()


## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
# We can add the points as well, using the + operator
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_smooth() +
  ggplot2::geom_point() +
  ggplot2::geom_line(aes(x = 4.5))


## ---- fig.height=3, echo=FALSE---------------------------------------------------------------------------------------------------------------
# Note that the points vary in `colour` based on the cars `class` but the smooth line does not.
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_smooth() +
  ggplot2::geom_point(aes(colour = class))


## ---- fig.height = 2.5-----------------------------------------------------------------------------------------------------------------------
# we can create the same graph using two different approaches in ggplot
ggplot2::ggplot(data = mpg) +
  ggplot2::stat_summary(mapping = aes(x = class, y = hwy),
                        fun.min = min, fun.max = max,
                        fun = median)


## ---- fig.height = 2.5-----------------------------------------------------------------------------------------------------------------------
# The same graph can be created using the geom command
ggplot2::ggplot(data = mpg) +
  ggplot2::geom_pointrange(mapping = aes(x = class, y = hwy),
                           fun.min = min, fun.max = max, 
                           fun = median,
                           stat = "summary")


## ---- fig.height=2---------------------------------------------------------------------------------------------------------------------------
# Bar charts
ggplot2::ggplot(data = mpg, aes(x = class)) +
  ggplot2::geom_bar()


## ---- echo=FALSE, out.width = "800px", out.height = "400px"----------------------------------------------------------------------------------
knitr::include_graphics("images/transform.png")


## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
# Bar chart positioning
ggplot2::ggplot(data = mpg, aes(x = manufacturer, fill = class)) +
  ggplot2::geom_bar(colour = 'black') +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0, hjust = 1))


## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
# By default bars are "stacked" on top of each other. This makes comparing proportions rather 
# difficult. You can control this with the position argument.
ggplot2::ggplot(data = mpg, aes(x = manufacturer, fill = class)) +
  ggplot2::geom_bar(colour = 'black', position = 'dodge') +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0, hjust = 1))


## ---- eval=FALSE, results=FALSE--------------------------------------------------------------------------------------------------------------
## stat = "summary", fun = "mean"


## --------------------------------------------------------------------------------------------------------------------------------------------
# What is wrong with this plot?
ggplot2::ggplot(data = mpg, aes(x = cty, y = hwy)) +
  ggplot2::geom_point()


## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
# Because there are multiple observations, some are **overplotted**. To correct this, you can add 
# some random noise to the data with `position="jitter"` or `geom_jitter`.
ggplot2::ggplot(data = mpg, aes(x = cty, y = hwy)) +
  ggplot2::geom_jitter(colour = 'red') +
  ggplot2::geom_point()


## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
# Themes, titles, and multiple plots
ggplot2::ggplot(data = mpg, aes(x = class, y = ..prop.., group = 1)) +
  ggplot2::geom_bar() +
  ggplot2::labs(title = "Proportion of sample by class", x = "Class", y = "Proportion")


## --------------------------------------------------------------------------------------------------------------------------------------------
# Multiple plots
plot1<-
  ggplot2::ggplot(data = mpg, aes(x = cyl, y = ..prop.., group = 1)) +
  ggplot2::geom_bar(fill = "red") +
  ggplot2::labs(title = "Proportion of sample by cylinder", x = "Cylinder", y = "Proportion", subtitle = " ")

plot2<-
  ggplot2::ggplot(data = mpg, aes(x = cty, y = hwy)) +
  ggplot2::geom_jitter(colour = 'red') +
  ggplot2::labs(title = "Highway fuel efficiency\number of cylinders", 
                subtitle = "Note, the points are jittered", x = "Number of cylinders", y = "Fuel efficiency")



## --------------------------------------------------------------------------------------------------------------------------------------------
# gridExtra
gridExtra::grid.arrange(plot1, plot2, nrow = 1)



## ---- fig.height=5, fig.width=8--------------------------------------------------------------------------------------------------------------
# Themes
gridExtra::grid.arrange(
  plot2 + ggplot2::theme_bw(), plot2 + ggplot2::theme_classic(), 
  plot2 + ggplot2::theme_minimal(), plot2 + ggplot2::theme_light())


## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
# You can also make your own custom themes
ugly_theme <-
  ggplot2::theme(
    text = ggplot2::element_text(colour = 'orange', face = 'bold'),
    panel.grid.major = ggplot2::element_line(colour = "violet", linetype = "dashed"),
    panel.grid.minor = ggplot2::element_blank(),
    panel.background = ggplot2::element_rect(fill = 'black', colour = 'red'),
  )



## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
plot2 + ugly_theme



## ---- eval=FALSE, results=FALSE--------------------------------------------------------------------------------------------------------------
## # Exercises: Section 5
## ggplot2::ggplot(data = mpg) +
##   ggplot2::geom_point(mapping = aes(x = hwy, y = cty, colour = as.factor(cyl)))


## ---- fig.height=2---------------------------------------------------------------------------------------------------------------------------
# Proportion chart
# Set group=1 and y=..prop.. to get relative proportion
# ggplot(data=mpg, aes(x=class, y=stat(prop), group=1))+
#   geom_bar()



## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = class, y = hwy)) +
  ggplot2::stat_summary(fun = mean,
                        fun.min = min,
                        fun.max = max,
                        geom = 'crossbar',
                        fill = 'white')


## --------------------------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = class, y = hwy)) +
  ggplot2::stat_summary(fun.data = "mean_cl_boot")


## --------------------------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = class, y = hwy)) +
  ggplot2::stat_boxplot(coef = 2) #set whisker range to 2


## --------------------------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = class, y = hwy)) +
  ggplot2::stat_ydensity(fill = 'orange')


## --------------------------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = class, y = hwy, fill = class)) +
  ggplot2::stat_summary(fun = "mean", geom = 'bar') +
  ggplot2::stat_summary(fun.data = "mean_cl_boot", geom = "errorbar", width = .25)


## ---- fig.height=3---------------------------------------------------------------------------------------------------------------------------
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, colour = year)) +
  ggplot2::geom_point() +
  viridis::scale_colour_viridis()



## --------------------------------------------------------------------------------------------------------------------------------------------
mpg_group <- mpg %>% 
  dplyr::select(class, year, cty) %>% 
  dplyr::group_by(class, year) %>% 
  dplyr::summarise(mean = mean(cty))

