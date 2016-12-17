##Chapter 5 - Building a Plot Layer by Layer
library(ggplot2)
library(tidyr)
library(tibble)
library(dplyr)
#5.2 - Building a Plot

p <- ggplot(mpg, aes(displ, hwy))
p
p + geom_point()
p + layer(
  mapping=NULL,
  data=NULL,
  geom='point',
  stat='identity',
  position='identity'
)

mod <- loess(hwy ~ displ, data=mpg)
grid <- data_frame(displ=seq(min(mpg$displ), max(mpg$displ), length=50))
grid$hwy <- predict(mod, newdata = grid)
grid
std_resid <- resid(mod) / mod$s
outlier <- filter(mpg, abs(std_resid) > 2)
outlier

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_line(data=grid, color='blue', size=1.5) + 
  geom_text(data=outlier, aes(label=model))

ggplot(mapping = aes(displ, hwy)) + 
  geom_point(data=mpg) + 
  geom_line(data=grid) + 
  geom_text(data=outlier, aes(label=model))

###exercise 2:
library(dplyr)
class <- mpg %>% 
  group_by(class) %>% 
  summarise(n=n(), hwy=mean(hwy))

p <- ggplot(mpg, aes(class, hwy))

#5.4: Aesthetic Mappings
#5.4.1: Specifying the Aesthetics in the Plot vs in the Layers

ggplot(mpg, aes(displ, hwy, color=class)) + geom_point()
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color=class))
ggplot(mpg, aes(displ)) + geom_point(aes(y=hwy, color=class))
ggplot(mpg) + geom_point(aes(displ, hwy, color=class))


ggplot(mpg, aes(displ, hwy, color=class)) + 
  geom_point() + 
  geom_smooth(method='lm', se=FALSE) + 
  theme(legend.position='none')

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color=class)) + 
  geom_smooth(method='lm', se=FALSE) + 
  theme(legend.position = 'none')

#5.4.2: Setting vs Mapping
ggplot(mpg, aes(cty, hwy)) + geom_point(color='darkblue')
ggplot(mpg, aes(cty, hwy)) + geom_point(aes(color='darkblue'))
ggplot(mpg, aes(cty, hwy)) + geom_point(aes(color='darkblue')) + scale_color_identity()
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(aes(color='loess'), method='loess', se=FALSE) + 
  geom_smooth(aes(color='lm'), method='lm', se=FALSE) + 
  labs(color='Method')

ggplot(mpg) + geom_point(aes(mpg$displ, mpg$hwy))
ggplot(mpg, aes(displ, hwy)) + geom_point()

ggplot() + 
  geom_point(mapping=aes(y=hwy, x=cty), data=mpg) + 
  geom_smooth(data=mpg, mapping=aes(cty, hwy))
ggplot(mpg, aes(cty, hwy)) + geom_point() + geom_smooth()

ggplot(diamonds, aes(carat, price)) + 
  geom_point(aes(log(brainwt), log(bodywt)), data=msleep)
ggplot(diamonds, aes(carat, price)) + 
  geom_point(data=msleep, aes(log(brainwt), log(bodywt)))

ggplot(mpg) + 
  geom_point(aes(class, cty)) + 
  geom_boxplot(aes(trans, hwy))

#5.5 Geoms
#5.6 Stats
ggplot(mpg, aes(trans, cty)) + 
  geom_point() + 
  stat_summary(geom='point', fun.y='mean', color='red', size=4)

ggplot(mpg, aes(trans, cty)) + 
  geom_point() + 
  geom_point(stat='summary', fun.y='mean', color='red', size=4)

#5.6.1 Generated Variables

ggplot(diamonds, aes(price)) + geom_histogram(binwidth=500)
ggplot(diamonds, aes(price)) + geom_histogram(aes(y=..density..), binwidth=500)

ggplot(diamonds, aes(price, color=cut)) + 
  geom_freqpoly(binwidth=500) + 
  theme(legend.position='none')

ggplot(diamonds, aes(price, color=cut)) + 
  geom_freqpoly(aes(y=..density..), binwidth=500) + 
  theme(legend.position='none')

#5.7 POsition Adjustments
dplot <- ggplot(diamonds, aes(color, fill=cut)) + 
  xlab(NULL) + ylab(NULL) + theme(legend.position='none')
dplot + geom_bar(position='stack')
dplot + geom_bar(position='fill')
dplot + geom_bar(position='dodge')

dplot + geom_bar(position='identity', alpha=1/2, color='grey50')
ggplot(diamonds, aes(color, color=cut)) + 
  geom_line(aes(group=cut), stat='count') + xlab(NULL) + ylab(NULL) + 
  theme(legend.position='none')

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(position='jitter')

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(position = position_jitter(width=0.05, height=0.5))

ggplot(mpg, aes(displ, hwy)) + 
  geom_jitter(width=0.05, height=0.5)

