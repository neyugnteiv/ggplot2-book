##Chapter 11: Modelling for Visualization
#11.2 Removing Trend

diamonds2 <- diamonds %>%
  filter(carat <= 2) %>% 
  mutate(
    lcarat=log2(carat),
    lprice=log2(price)
  )
diamonds2

ggplot(diamonds2, aes(lcarat, lprice)) + 
  geom_bin2d() + 
  geom_smooth(method='lm', se=FALSE, size=2, color='yellow')

mod <- lm(lprice ~ lcarat, data=diamonds2)
coef(summary(mod))


diamonds2 <- diamonds2 %>% mutate(rel_price=resid(mod))
ggplot(diamonds2, aes(carat, rel_price)) + geom_bin2d()
xgrid <- seq(-2, 1, by= 1/3)
data.frame(logx = xgrid, x = round(2^xgrid, 2))

color_cut <- diamonds2 %>% 
  group_by(color, cut) %>%
  summarise(
    price = mean(price),
    rel_price=mean(rel_price)
  )
color_cut

ggplot(color_cut, aes(color, price)) + 
  geom_line(aes(group=cut), color='grey80') + 
  geom_point(aes(color=cut))

ggplot(color_cut, aes(color, rel_price)) + 
  geom_line(aes(group=cut), color='grey80') + 
  geom_point(aes(color=cut))

ggplot(color_cut, aes(color, rel_price)) + 
  geom_line(aes(group=cut), color='grey80') + geom_point(aes(color=cut))

#11.3 Texas Housing Data
txhousing

ggplot(txhousing, aes(date, sales)) + 
  geom_line(aes(group=city), alpha=1/2)

ggplot(txhousing, aes(date, log(sales))) + 
  geom_line(aes(group=city), alpha=1/2)

abilene <- txhousing %>% filter(city=="Abilene")
ggplot(abilene, aes(date, log(sales))) + geom_line()

mod <- lm(log(sales) ~ factor(month), data=abilene)
abilene$rel_sales <- resid(mod)
ggplot(abilene, aes(date, rel_sales)) + geom_line()

deseas <- function(x, month) {
  resid(lm(x ~ factor(month), na.action=na.exclude))
}
txhousing <- txhousing %>% 
  group_by(city) %>% 
  mutate(rel_sales = deseas(log(sales), month))

ggplot(txhousing, aes(date, rel_sales)) + 
  geom_line(aes(group=city), alpha=1/5) +
  geom_line(stat="summary", fun.y="mean", color="red")

#11.4 Visualising Models
models <- txhousing %>% 
  group_by(city) %>% 
  do(mod=lm(
    log2(sales) ~ factor(month), 
    data=., 
    na.action=na.exclude
  ))
models

library(broom)
#11.5 Model-Level Summaries

model_sum <- models %>% glance(mod)
model_sum

ggplot(model_sum, aes(r.squared, reorder(city, r.squared))) + geom_point()

top3 <- c('Bryan-College Station', 'Lubbock', 'NE Tarrant County')
bottom3 <- c('McAllen', 'Brownsville', 'Harlingen')
extreme <- txhousing %>% ungroup() %>% 
  filter(city %in% c(top3, bottom3), !is.na(sales)) %>%
  mutate(city=factor(city, c(top3, bottom3)))

ggplot(extreme, aes(month, log(sales))) + 
  geom_line(aes(group=year)) + 
  facet_wrap(~city)

#11.6 Coefficient-Level Summaries
coefs <- models %>% tidy(mod)
coefs

months <- coefs %>%
  filter(grepl('factor', term)) %>% 
  tidyr::extract(term, 'month', '(\\d+)', convert=TRUE)
months

ggplot(months, aes(month, 2^estimate)) + geom_line(aes(group=city))

coef_sum <- months %>% 
  group_by(city) %>% 
  summarise(max=max(estimate))
ggplot(coef_sum, aes(2^max, reorder(city, max))) + geom_point()
