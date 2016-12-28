#Chapter 6 - Scales, Axes and Legends
library(ggplot2)

#6.2 Modifying Scales
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color=class))
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color=class)) + 
  scale_x_continuous() + 
  scale_y_continuous() + 
  scale_color_discrete()

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color=class)) + 
  scale_x_continuous("A really awesome x axis ") + 
  scale_y_continuous("An amazingly great y axis ") 
  
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_x_continuous("Label 1") + 
  scale_y_continuous("Label 2")

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_x_continuous("Label 2")

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color=class)) + 
  scale_x_sqrt() + 
  scale_color_brewer()

ggplot(mpg, aes(displ)) + 
  scale_y_continuous('Highway mpg') + 
  scale_x_continuous() + 
  geom_point(aes(y=hwy))

ggplot(mpg, aes(displ)) + 
  scale_y_continuous('Highway mpg') + 
  geom_point(aes(y=hwy))

ggplot(mpg, aes(y=displ, x=class)) + 
  scale_y_continuous('Displacement (l)') + 
  scale_x_discrete("Car type") + 
  scale_x_discrete("Type of car") + 
  scale_color_discrete() + 
  geom_point(aes(color=drv)) + 
  scale_color_discrete("Drive\ntrain")

ggplot(mpg, aes(y=displ, x=class)) + 
  scale_y_continuous('Displacement (l)') + 
  scale_x_discrete("Type of car") + 
  geom_point(aes(color=drv)) + 
  scale_color_discrete("Drive\ntrain")

#6.3 Guides: Legends and Axes
#6.3.1 Scale Title 
df <- data.frame(x=1:2, y=1, z='a')
p <- ggplot(df, aes(x,y)) + geom_point()
p + scale_x_continuous('X axis')
p + scale_x_continuous(quote(a + mathematical ^ expression))
p <- ggplot(df, aes(x, y)) + geom_point(aes(color=z))
p + xlab('X axis') + ylab('Y axis')
p + labs(x='X axis', y='Y axis', color='Colour\nLegend')

p <- ggplot(df, aes(x, y)) + geom_point() + theme(plot.background=element_rect(color='grey50'))
p + labs(x="", y="")
p + labs(x=NULL, y=NULL)

#6.3.2 Breaks and Labels
df <- data.frame(x=c(1,3,5)* 1000, y=1)
axs <- ggplot(df, aes(x,y)) + geom_point() + labs(x=NULL, y=NULL)
axs
axs + scale_x_continuous(breaks=c(2000, 4000))
axs + scale_x_continuous(breaks = c(2000, 4000), labels=c('2k', '4k'))
leg <- ggplot(df, aes(y, x, fill=x)) + geom_tile() + labs(x=NULL, y=NULL)
leg
leg + scale_fill_continuous(breaks=c(2000, 4000))
leg + scale_fill_continuous(breaks=c(2000, 4000), labels=c('2k', '4k'))
df2 <- data.frame(x=1:3, y=c('a', 'b', 'c'))
ggplot(df2, aes(x, y)) + geom_point()
ggplot(df2, aes(x, y)) + geom_point() + scale_y_discrete(labels=c(a='apple', b='banana', c='carrot'))
axs + scale_x_continuous(breaks=NULL)
axs + scale_x_continuous(labels=NULL)
leg + scale_fill_continuous(breaks=NULL)
leg + scale_fill_continuous(labels=NULL)


# 6.3 : Guides - Legends and Axes
#6.3.1 Scale Title
df <- data.frame(x=1:2, y=1, z='a')
p <- ggplot(df, aes(x, y)) + geom_point()
p + scale_x_continuous("X Axis")
p + scale_x_continuous(quote(a + mathematical ^ expression))

p <- ggplot(df, aes(x, y)) + geom_point(aes(color=z))
p + xlab('X Axis') + ylab('Y Axis')
p + labs(x='X Axis', y='Y axis', color = 'Color\nlegend')
p <- ggplot(df, aes(x,y)) + geom_point() + theme(plot.background=element_rect(color='grey50'))
p + labs(x='', y='')
p + labs(x=NULL, y=NULL)

#6.3.2 Breaks and Labels
df <- data.frame(x=c(1,3,5) * 1000, y=1)
axs <- ggplot(df, aes(x, y)) + geom_point() + labs(x=NULL, y=NULL)
axs
axs + scale_x_continuous(breaks=c(2000, 4000))
axs + scale_x_continuous(breaks=c(2000, 4000), labels=c('2k', '4k'))
leg <- ggplot(df, aes(y, x, fill=x)) + geom_tile() + labs(x=NULL, y=NULL)
leg
leg + scale_fill_continuous(breaks=c(2000, 4000))
leg + scale_fill_continuous(breaks=c(2000, 4000), labels=c('2k', '4k'))

df2 <- data.frame(x=1:3, y=c('a', 'b', 'c'))
ggplot(df2, aes(x, y)) + geom_point()
ggplot(df2, aes(x, y)) + geom_point() + scale_y_discrete(labels=c(a='apple', b='banana', c='carrot'))
axs + scale_x_continuous(breaks=NULL)
axs + scale_x_continuous(labels=NULL)

leg + scale_fill_continuous(breaks=NULL)
leg + scale_fill_continuous(labels=NULL)
axs + scale_y_continuous(labels=scales::percent_format())
axs + scale_y_continuous(labels=scales::dollar_format('$'))
leg + scale_fill_continuous(labels=scales::unit_format('k', 1e-3))

df <- data.frame(x=c(2,3,5,10,200, 3000), y=1)
ggplot(df, aes(x, y)) + geom_point() + scale_x_log10()
mb <- as.numeric(1:10 %o% 10 ^ (0:4))
ggplot(df, aes(x, y)) + geom_point() + scale_x_log10(minor_breaks=log10(mb))

#6.4: Legends
ggplot(df, aes(y, y)) + geom_point(size=4, color='grey20') + geom_point(aes(color=z), size=2)
df

norm <- data.frame(x=rnorm(1000), y=rnorm(1000))
norm$z <- cut(norm$x, 3, labels=c('a', 'b', 'c')) 
ggplot(norm, aes(x,y)) + geom_point(aes(color=z), alpha=0.1)
ggplot(norm, aes(x, y)) + geom_point(aes(color=z), alpha=0.1) + guides(color=guide_legend(override.aes=list(alpha=1)))

#6.4.2 Legend Layout
df <- data.frame(x=1:3, y=1:3, z=c('a', 'b', 'c'))
base <- ggplot(df, aes(x, y)) + geom_point(aes(color=z), size=3) + xlab(NULL) + ylab(NULL)
base + theme(legend.position='right')
base + theme(legend.position='bottom')
base + theme(legend.position='none')

base <- ggplot(df, aes(x, y)) + geom_point(aes(color=z), size=3)
base + theme(legend.position=c(0,1), legend.justification=c(0,1))
base + theme(legend.position=c(0.5, 0.5), legend.justification=c(0.5, 0.5))
base + theme(legend.position=c(1,0), legend.justification=c(1,0), legend.margin=unit(0, 'mm'))

#6.4.3 Guide Functions
df <- data.frame(x=1, y=1:3, z=1:3)
base <- ggplot(df, aes(x, y)) + geom_raster(aes(fill=z))
base
base + scale_fill_continuous(guide=guide_legend())
base + guides(fill=guide_legend())

#6.4 Legends
#6.4.1 Layers and Legends
ggplot(df, aes(y, y)) + geom_point(size=4, color='grey20') + geom_point(aes(color=z), size=2)

norm <- data.frame(x=rnorm(1000), y=rnorm(1000))
norm$z <- cut(norm$x, 3, labels=c('a', 'b', 'c'))
ggplot(norm, aes(x,y)) + geom_point(aes(color=z), alpha=0.1)
ggplot(norm, aes(x, y)) + geom_point(aes(color=z), alpha=0.5) + guides(color=guide_legend(override.aes=list(alpha=1)))

#6.4.3.1: guide_legend()
df <- data.frame(x=1, y=1:4, z=letters[1:4])
p <- ggplot(df, aes(x, y)) + geom_raster(aes(fill=z))
p
p + guides(fill = guide_legend(ncol=2))
p + guides(fill = guide_legend(ncol=2, byrow=TRUE))
p <- ggplot(df, aes(1, y)) + geom_bar(stat='identity', aes(fill=z))
p 
p + guides(fill=guide_legend(reverse=TRUE))

#6.5 Limits
