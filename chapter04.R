## Chapter 4 - Mastering the Grammar 
library(ggplot2)
#4.2.1 Mapping Aesthetics to Data

ggplot(mpg, aes(displ, hwy, color = factor(cyl))) + geom_line() + theme(legend.position='none')
ggplot(mpg, aes(displ, hwy, color = factor(cyl))) + geom_bar(stat='identity', position='identity', fill=NA) + theme(legend.position='none')
