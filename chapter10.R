#Chapter 10 - Data Transformation
library(dplyr)
library(ggplot2)
#10.2 - Filter Observations

ggplot(diamonds, aes(x, y)) + geom_bin2d()
filter(diamonds, x==0 | y == 0)
start0 <- Sys.time(); filter(diamonds, x==0|y==0); Sys.time() - start0
start0 <- Sys.time(); subset(diamonds, x==0); Sys.time() - start0

diamonds_ok <- filter(diamonds, x>0, y>0, y<20)
ggplot(diamonds_ok, aes(x,y)) + geom_bin2d() + geom_abline(slope=1, color='white', size=1, alpha=0.5)

diamonds_ok2 <- mutate(diamonds_ok, 
                       sym = x-y,
                       size=sqrt(x^2 + y^2)
                       )
diamonds_ok2

ggplot(diamonds_ok2, aes(size, sym)) + stat_bin2d()
ggplot(diamonds_ok2, aes(abs(sym))) + geom_histogram(binwidth=0.10)
diamonds_ok3 <- filter(diamonds_ok2, abs(sym) < 0.20)
ggplot(diamonds_ok3, aes(abs(sym))) + geom_histogram(binwidth=0.01)

#10.3 Create New Variables
diamonds_ok2 <- mutate(diamonds_ok, sym = x-y,
                       size = sqrt(x^2 + y^2))
diamonds_ok2
ggplot(diamonds_ok2, aes(size, sym)) + stat_bin2d()
ggplot(diamonds_ok2, aes(abs(sym))) + geom_histogram(binwidth=0.10)
diamonds_ok3 <- filter(diamonds_ok2, abs(sym) < 0.20)
ggplot(diamonds_ok3, aes(abs(sym))) + geom_histogram(binwidth=0.01)

#19.4 Group-Wise Summaries
by_clarity <- group_by(diamonds, clarity)
sum_clarity <- summarise(by_clarity, price=mean(price))
sum_clarity
ggplot(sum_clarity, aes(clarity, price)) + 
  geom_line(aes(group=1), color='grey80') + 
  geom_point(size=2)

cut_depth <- summarise(group_by(diamonds, cut, depth), n=n())
cut_depth <- filter(cut_depth, depth > 55, depth < 70)
cut_depth
ggplot(cut_depth, aes(depth, n, color=cut)) + geom_line()

cut_depth <- mutate(cut_depth, prop=n/sum(n))
ggplot(cut_depth, aes(depth, prop, color=cut)) + geom_line()

summarise(diamonds,
          n_big = sum(carat >= 4), 
          prop_cheap = mean(price < 1000))

#10.4.2 Statistical Considerations
by_clarity <- diamonds %>%
  group_by(clarity) %>% 
  summarise(
    n = n(),
    mean=mean(price),
    lq = quantile(price, 0.25),
    uq = quantile(price, 0.75)
)

by_clarity

ggplot(by_clarity, aes(clarity, mean)) + 
  geom_linerange(aes(ymin=lq, ymax=uq)) + 
  geom_line(aes(group=1), color = 'grey50') + 
  geom_point(aes(size=n))

data(Batting, package='Lahman')
batters <- filter(Batting, AB > 0) 
per_player <- group_by(batters, playerID)
ba <- summarise(per_player, 
                ba = sum(H, na.rm=TRUE) / sum(AB, na.rm=TRUE)
          )
ggplot(ba, aes(ba)) + geom_histogram(binwidth=0.01)

ba <- summarise(per_player, 
          ba = sum(H, na.rm=TRUE) / sum(AB, na.rm=TRUE),
          ab = sum(AB, na.rm=TRUE)
          )
ggplot(ba, aes(ab, ba)) + geom_bin2d(bins=100) + geom_smooth()
ggplot(filter(ba, ab >= 10), aes(ab, ba)) + geom_bin2d() + geom_smooth()

#10.5 Transformation Pipelines
cut_depth <- group_by(diamonds, cut, depth)
cut_depth <- summarise(cut_depth, n=n())
cut_depth <- filter(cut_depth, depth > 55, depth < 70)
cut_depth <- mutate(cut_depth, prop = n / sum(n))
cut_depth

mutate(
  filter(
    summarise(
      group_by(
        diamonds, 
        cut,
        depth
      ),
      n=n()
    ),
  depth > 55,
  depth < 70
  ),
  prop = n/sum(n)
)
cut_depth <- diamonds %>% 
  group_by(cut, depth) %>% 
  summarise(n=n()) %>% 
  filter(depth > 55, depth <70) %>% 
  mutate(prop=n/sum(n))
cut_depth



