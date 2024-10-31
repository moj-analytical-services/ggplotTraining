knitr::opts_chunk$set(message = FALSE, warning = FALSE, cache = FALSE)


# Random number seed
set.seed(5)

# Scatter plot
plot(rnorm(20), rnorm(20))

import::from("ggplot2", "aes", "vars", "mpg")

# Examine the mpg dataset
dplyr::glimpse(mpg)

ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_point()

ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_point() +
  ggplot2::geom_point(aes(x = displ, y = cty), colour = "blue")

## # chart template
## ggplot(data = <DATA>, aes(<MAPPINGS>) )  +
##   <GEOM_FUNCTION> +
##   <COORDINATE_FUNCTION> +
##   <FACET_FUNCTION> +
##   <SCALE_FUNCTION> +
##   <THEME FUNCTION>

# Aesthetics
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, colour = class)) +
  ggplot2::geom_point()

# ggplot2 looks at the data type to set a default colour scale
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, colour = year)) +
  ggplot2::geom_point()

# You can also use shapes to distinguish between categories
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, shape = class, colour = class)) +
  ggplot2::geom_point()

# Some aesthetics are only suitable in certain situations
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, shape = class, colour = class)) +
  ggplot2::geom_point()

# Use scale_ functions to set properties of the aesthetics
dplyr::filter(mpg, manufacturer %in% c('audi', 'volkswagen')) |> 
  ggplot2::ggplot(aes(x = displ, y = hwy, colour = manufacturer)) +
  ggplot2::geom_point(size = 3) +
  ggplot2::scale_colour_manual(values = c("audi" = "#12436D", "volkswagen" = "#28A197")) +
  ggplot2::scale_x_continuous(limits = c(1, 5))

# Set an aesthetic to a fixed value
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_point(colour = "orange")

# What's wrong with this code? Why aren't the points blue?
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy, colour = "blue")) +
  ggplot2::geom_point()

ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_point() +
  ggplot2::facet_wrap(vars(class))

ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_point() +
  ggplot2::facet_grid(rows = vars(drv), cols = vars(class))

# What is wrong with this plot?
ggplot2::ggplot(data = mpg, aes(x = cty, y = hwy)) +
  ggplot2::geom_point()

# Because there are multiple observations, some are **overplotted**. To correct this, you can add 
# some random noise to the data with `position="jitter"` or `geom_jitter`.
ggplot2::ggplot(data = mpg, aes(x = cty, y = hwy)) +
  ggplot2::geom_jitter(colour = 'red') +
  ggplot2::geom_point()

ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_smooth()

# We can add the points as well, using the + operator
ggplot2::ggplot(data = mpg, aes(x = displ, y = hwy)) +
  ggplot2::geom_smooth() +
  ggplot2::geom_point() +
  ggplot2::geom_line(aes(x = 4.5))

# Bar charts counting rows in the data
ggplot2::ggplot(data = mpg, aes(x = class)) +
  ggplot2::geom_bar()

# Bar charts from tabulated data
mpg |>
  dplyr::group_by(class) |> 
  dplyr::summarise(count = dplyr::n()) |> 
  ggplot2::ggplot(aes(x = class, y = count)) +
  ggplot2::geom_col() 

# Bar chart positioning
ggplot2::ggplot(data = mpg, aes(x = manufacturer, fill = class)) +
  ggplot2::geom_bar(colour = 'black') +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0, hjust = 1))

# By default bars are "stacked" on top of each other. This makes comparing proportions rather difficult. 
# You can control this with the position argument.
ggplot2::ggplot(data = mpg, aes(x = manufacturer, fill = class)) +
  ggplot2::geom_bar(colour = 'black', position = 'dodge') +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0, hjust = 1))

# Histogram
ggplot2::ggplot(data = mpg, aes(x = hwy)) +
  ggplot2::geom_histogram(bins = 30) 

# Density plot
ggplot2::ggplot(data = mpg, aes(x = hwy)) +
  ggplot2::geom_density() 

# Overlapping density plots
ggplot2::ggplot(data = mpg, aes(x = hwy, fill = drv)) +
  ggplot2::geom_density(alpha = 0.5) 

# Box plots
ggplot2::ggplot(data = mpg, aes(x = drv, y = hwy)) +
  ggplot2::geom_boxplot(fill = "red")

# Violin plots
ggplot2::ggplot(data = mpg, aes(x = drv, y = hwy)) +
  ggplot2::geom_violin(aes(fill = drv))

# Line charts
ggplot2::economics |> 
  ggplot2::ggplot(aes(x = date, y = unemploy)) +
  ggplot2::geom_line()

# Themes, titles, and multiple plots
ggplot2::ggplot(data = mpg, aes(x = class, y = ggplot2::after_stat(prop), group = 1)) +
  ggplot2::geom_bar() +
  ggplot2::labs(title = "Proportion of sample by class", x = "Class", y = "Proportion")

# Multiple plots
plot1 <-
  ggplot2::ggplot(data = mpg, aes(x = cyl, y = ggplot2::after_stat(prop), group = 1)) +
  ggplot2::geom_bar(fill = "red") +
  ggplot2::labs(title = "Proportion of sample by engine type", 
                x = "Number of cylinders", 
                y = "Proportion")

plot2 <-
  ggplot2::ggplot(data = mpg, aes(x = cty, y = hwy)) +
  ggplot2::geom_jitter(colour = 'red') +
  ggplot2::labs(title = "Fuel efficiency comparison", 
                subtitle = "Note: the points are jittered", 
                x = "City fuel efficiency", 
                y = "Highway fuel efficiency")


# gridExtra
gridExtra::grid.arrange(plot1, plot2, nrow = 1)


# Themes
gridExtra::grid.arrange(
  plot2 + ggplot2::theme_bw(), plot2 + ggplot2::theme_classic(), 
  plot2 + ggplot2::theme_dark(), plot2 + ggplot2::theme_light())

# You can also make your own custom themes
ugly_theme <-
  ggplot2::theme(
    text = ggplot2::element_text(colour = 'orange', face = 'bold'),
    panel.grid.major = ggplot2::element_line(colour = "violet", linetype = "dashed"),
    panel.grid.minor = ggplot2::element_blank(),
    panel.background = ggplot2::element_rect(fill = 'black', colour = 'red'),
  )


plot2 + ugly_theme

# MoJ colour scheme
ggplot2::ggplot(data = mpg, aes(x = class, fill = drv)) +
  ggplot2::geom_bar(position = "dodge") +
  mojchart::scale_fill_moj(n = 3) +
  mojchart::theme_gss(xlabel = TRUE)

# Accessible colour scheme
ggplot2::ggplot(data = mpg, aes(x = class, fill = drv)) +
  ggplot2::geom_bar(position = "dodge") +
  mojchart::scale_fill_moj(n = 3, scheme = "govanal_bars") +
  mojchart::theme_gss(xlabel = TRUE)

## ggplot2::ggplot(data = mpg) +
##    ggplot2::geom_point(mapping = aes(x = hwy, y = cty, colour = as.factor(cyl)))
