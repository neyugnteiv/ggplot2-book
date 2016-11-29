library(ggplot2)
mpg

ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(mpg, aes(model, manufacturer)) + 
  geom_point()

ggplot(mpg, aes(displ, cty, color=class)) +
  geom_point()
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color='blue'))
ggplot(mpg, aes(displ, hwy)) + geom_point(color='blue')

ggplot(mpg, aes(displ, hwy)) + geom_point() + facet_wrap(~class)
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth()
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(span=0.2)
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(span=1)
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method='gam', formula= y ~ s(x))
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method='lm')

#2.6.2
ggplot(mpg, aes(drv, hwy)) + geom_point()
ggplot(mpg, aes(drv, hwy)) + geom_jitter()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_violin()

#2.6.3 Histograms & Frequency polygons
ggplot(mpg, aes(hwy)) + geom_histogram()
ggplot(mpg, aes(hwy)) + geom_freqpoly()
ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth=2.5)
ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth=1)
ggplot(mpg, aes(displ, color = drv)) + geom_freqpoly(binwidth=0.5)
ggplot(mpg, aes(displ, fill=drv)) + geom_histogram(binwidth=0.5) + facet_wrap(~drv, ncol=1)

#2.6.4 Bar Charts
ggplot(mpg, aes(manufacturer)) + geom_bar()
drugs <- data.frame(
  drug = c('a', 'b','c'),
  effect = c(4.2, 9.7, 6.1)
)
ggplot(drugs, aes(drug, effect)) + geom_bar(stat='identity')
ggplot(drugs, aes(drug, effect)) + geom_point()

#2.6.5 Time Series with Line and Path Plots 
ggplot(economics, aes(date, unemploy/pop)) + geom_line()
ggplot(economics, aes(date, uempmed)) + geom_line()
ggplot(economics, aes(unemploy/pop, uempmed)) + geom_path() + geom_point()

year <- function(x) as.POSIXlt(x)$year + 1900
ggplot(economics, aes(unemploy/pop, uempmed)) + 
  geom_path(color='grey50') + 
  geom_point(aes(color=year(date)))

#2.7 - Modifying the Axes
ggplot(mpg, aes(cty, hwy)) + geom_point(alpha=1/3)

ggplot(mpg, aes(cty, hwy)) + 
  geom_point(alpha=1/3) + 
  xlab('city driving (mpg)') + 
  ylab('highway driving (mpg)' )

ggplot(mpg, aes(cty, hwy)) + 
  geom_point(alpha=1/3) + 
  xlab(NULL) + 
  ylab(NULL )

ggplot(mpg, aes(drv, hwy)) + geom_jitter(width=0.25)
ggplot(mpg, aes(drv, hwy)) + geom_jitter(width=0.25) + xlim('f', 'r') + ylim(20, 30)
ggplot(mpg, aes(drv, hwy)) + geom_jitter(width=0.25, na.rm=T) + ylim(NA, 30)

#2.8 - Output
p <- ggplot(mpg, aes(displ, hwy, color=factor(cyl))) + geom_point()
print(p)
ggsave('plot.png', width=5, height=5)
summary(p)
?ggsave

#2.9 - Quick Plot
qplot(displ, hwy, data=mpg)
qplot(displ, data=mpg)
