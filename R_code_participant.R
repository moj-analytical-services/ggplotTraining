library(tidyverse)
data(mpg)
str(mpg)

ggplot(mpg)
?mpg
ggplot(data=mpg, aes(x=hwy,y=cty)) + geom_point()
ggplot(data=mpg, aes(x=class,y=drv)) + geom_point()

ggplot(data=mpg, aes(x=displ,y=hwy,colour=class)) + geom_point()
ggplot(data=mpg, aes(x=displ,y=hwy,shape=class, colour=class)) + geom_point()

ggplot(data=mpg, aes(x=displ,y=hwy)) + geom_point(color="orange")

ggplot(data=mpg, aes(x=displ,y=hwy)) + geom_point() + facet_wrap(~class, nrow=2)
ggplot(data=mpg, aes(x=displ,y=hwy)) + geom_point() + facet_grid(drv~class)

