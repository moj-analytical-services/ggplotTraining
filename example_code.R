## ---- include=FALSE------------------------------------------------------
require(knitr)
knitr::opts_chunk$set(message=FALSE, warning=FALSE, cache=FALSE)



## ------------------------------------------------------------------------
#Basic Plot
plot(rnorm(20), rnorm(20))


## ---- highlight=TRUE-----------------------------------------------------
# load ggplot2 library as part of tidyverse  
library(tidyverse)


## ---- highlight=TRUE-----------------------------------------------------
# load ggplot2 library on its own

library(ggplot2)


## ------------------------------------------------------------------------
#load the mpg dataset

data(mpg) #load the mpg dataset
glimpse(mpg)


## ----eval = FALSE--------------------------------------------------------
## ## ggplot blueprint to making any plot
## ggplot(data = <DATA>) +
##   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


## ---- eval=FALSE---------------------------------------------------------
## # ggplot works with layers, each layers is added with the `+` operator.
## ggplot(data = mpg, aes(x=displ, y=hwy))+
##   geom_point()


## ---- fig.height=3, fig.width=4------------------------------------------
ggplot(data = mpg)+
  geom_point(aes(x=displ, y=hwy))


## ---- fig.height=3, fig.width=6------------------------------------------
# Aesthetics
ggplot(data = mpg, aes(x=displ, y=hwy, colour=class))+
  geom_point()


## ------------------------------------------------------------------------
# ggplot does some clever things when deciding what colours to use
ggplot(data = mpg, aes(x=displ, y=hwy, colour=year))+
  geom_point()


## ------------------------------------------------------------------------
# You can also use shapes to distinguish between categories, such as class.
ggplot(data = mpg, aes(x=displ, y=hwy, shape=class, colour=class))+
  geom_point()


## ------------------------------------------------------------------------
#Some aesthetics are only suitable in certain situations
ggplot(data = mpg, aes(x=displ, y=hwy, shape=class, colour=class))+
  geom_point()


## ---- fig.height=3, fig.retina=2-----------------------------------------
#You can also specify things manually

ggplot(data = mpg %>% filter(manufacturer %in% c('audi', 'volkswagen')), 
       aes(x=displ, y=hwy, colour=manufacturer, shape = manufacturer))+
  geom_point(size=3)+
  scale_color_manual(values = c("audi" = "#28b7b7", "volkswagen"="violet"))+
  scale_shape_manual(values = c("audi" = 1, "volkswagen" = 24))


## ------------------------------------------------------------------------

#You don't *have* to map aesthetics onto variables; you can specify them manually.
#
ggplot(data = mpg, aes(x=displ, y=hwy))+
  geom_point(color = "orange")


## ---- fig.height=2, fig.width=5------------------------------------------
#What's wrong with this code? Why aren't the points blue?

ggplot(data = mpg)+
  geom_point(aes(x=displ, y=hwy, color = "blue"))


## ---- fig.height=3-------------------------------------------------------
ggplot(data = mpg, aes(x=displ, y=hwy))+
  geom_point()+
  facet_wrap(~ class, nrow=2)


## ------------------------------------------------------------------------
ggplot(data = mpg, aes(x=displ, y=hwy))+
  geom_point()+
  facet_grid(drv ~ class)


## ---- echo=FALSE, out.width="600px"--------------------------------------
knitr::include_graphics("images/cheatsheet.png")


## ---- fig.height=4-------------------------------------------------------
ggplot(data = mpg, aes(x=displ, y=hwy))+
  geom_smooth()


## ---- fig.height=4-------------------------------------------------------

# We can add the points as well, using the + operator
# 
ggplot(data = mpg, aes(x=displ, y=hwy))+
  geom_smooth()+
  geom_point() +
  geom_line(aes(x = 4.5))


## ---- fig.height=3, echo=FALSE-------------------------------------------

# Note that the points vary in `color` based on the cars `class` but the smooth line does not.
# 
ggplot(data = mpg, aes(x=displ, y=hwy))+
  geom_smooth()+
  geom_point(aes(color=class))


## ---- fig.height = 2.5---------------------------------------------------

# we can create the same graph using two different approaches in ggplot

ggplot(data = mpg)+
  stat_summary(mapping = aes(x = class, y = hwy),
               fun.ymin = min, fun.ymax = max,
               fun.y = median)


## ---- fig.height = 2.5---------------------------------------------------

# The same graph can be created using the geom command
# 
ggplot(data = mpg)+
  geom_pointrange(mapping = aes(x = class, y = hwy),
                  fun.ymin = min, fun.ymax = max, 
                  fun.y = median,
                  stat = "summary")


## ---- fig.height=2-------------------------------------------------------
#Bar charts

ggplot(data=mpg, aes(x=class))+
  geom_bar()


## ---- echo=FALSE, out.width = "800px", out.height = "400px"--------------
knitr::include_graphics("images/transform.png")


## ---- fig.height=3-------------------------------------------------------

# Bar chart positioning
# 
ggplot(data=mpg, aes(x=manufacturer, fill=class))+
         geom_bar(color='black')+
  theme(axis.text.x = element_text(angle=90, vjust = 0, hjust=1))


## ---- fig.height=3-------------------------------------------------------

#By default bars are "stacked" on top of each other. This makes comparing proportions rather difficult. You can control this with the position argument

ggplot(data=mpg, aes(x=manufacturer, fill=class))+
         geom_bar(color='black', position='dodge')+
  theme(axis.text.x = element_text(angle=90, vjust = 0, hjust=1))


## ---- eval=FALSE, results=FALSE------------------------------------------
## stat = "summary", fun.y = "mean"


## ------------------------------------------------------------------------
# What is wrong with this plot?
# 
ggplot(data=mpg, aes(x=cty, y=hwy))+
  geom_point()


## ---- fig.height=3-------------------------------------------------------
# Because there are multiple observations, some are **overplotted**.
#  To correct this, you can add some random noise to the data with `position="jitter"` or `geom_jitter`.

ggplot(data=mpg, aes(x=cty, y=hwy))+
  geom_jitter(color='red')+
  geom_point()


## ---- fig.height=3-------------------------------------------------------
#Themes, titles, and multiple plots

ggplot(data=mpg, aes(x=class, y=..prop.., group=1))+
  geom_bar()+
  labs(title="Proportion of sample by class", x="Class", y="Proportion")


## ------------------------------------------------------------------------

# Multiple plots
# 
plot1<-
  ggplot(data=mpg, aes(x=cyl, y=..prop.., group=1))+
  geom_bar(fill="red")+
  labs(title="Proportion of sample by cylinder", x="Cylinder", y="Proportion", subtitle=" ")

plot2<-
  ggplot(data=mpg, aes(x=cty, y=hwy))+
  geom_jitter(color='red')+
  labs(title="Highway fuel efficiency\number of cylinders", 
       subtitle="Note, the points are jittered", x="Number of cylinders", y="Fuel efficiency")



## ------------------------------------------------------------------------
# gridExtra

require(gridExtra)
grid.arrange(plot1, plot2, nrow=1)



## ------------------------------------------------------------------------
#Themes

grid.arrange(
  plot2+theme_bw(), plot2+theme_classic(),plot2+theme_minimal(),  plot2+theme_light())


## ---- fig.height=3-------------------------------------------------------

#You can also make your own custom themes
#
#
ugly.theme <-
  theme(
    text = element_text(colour='orange', face='bold'),
    panel.grid.major = element_line(color="violet", linetype = "dashed"),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = 'black', colour = 'red'),
  )

plot2+ugly.theme



## ---- eval=FALSE, results=FALSE------------------------------------------
##  # Exercises: Section 5
## 
## ggplot(data = mpg) +
##   geom_point(mapping = aes(x = hwy, y = cty, colour = as.factor(cyl)))


## ---- fig.height=2-------------------------------------------------------
# #Proportion chart
# # Set group=1 and y=..prop.. to get relative propotion
# ggplot(data=mpg, aes(x=class, y=stat(prop), group=1))+
#   geom_bar()



## ---- fig.height=4-------------------------------------------------------
ggplot(data=mpg, aes( x=class, y=hwy))+
  stat_summary(fun.y=mean,
               fun.ymin=min,
               fun.ymax=max,
               geom='crossbar',
               fill='white')


## ------------------------------------------------------------------------
ggplot(data=mpg, aes( x=class, y=hwy))+
  stat_summary(fun.data="mean_cl_boot")


## ------------------------------------------------------------------------
ggplot(data=mpg, aes( x=class, y=hwy))+
  stat_boxplot(coef = 2) #set whisker range to 2


## ------------------------------------------------------------------------
ggplot(data=mpg, aes( x=class, y=hwy))+
  stat_ydensity(fill='orange')


## ------------------------------------------------------------------------
ggplot(data=mpg, aes(x=class, y=hwy, fill=class))+
  stat_summary(fun.y="mean", geom='bar') +
  stat_summary(fun.data="mean_cl_boot", geom="errorbar", width=.25)


## ------------------------------------------------------------------------
#install.packages('viridis')
require(viridis)
ggplot(data = mpg, aes(x=displ, y=hwy, colour=year))+
  geom_point()+
  scale_color_viridis()
  


## ------------------------------------------------------------------------
library(dplyr)
mpg_group    <- mpg %>% select(class, year, cty) %>% group_by(class, year) %>% summarise_all(mean)

