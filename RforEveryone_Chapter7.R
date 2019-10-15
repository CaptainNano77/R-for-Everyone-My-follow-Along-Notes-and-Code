########################################################################################################
#                               CHAPTER 7: STATISTICAL GRAPHICS
########################################################################################################
#
########################################################################################################
#                                     Base Graphics: 7.1
########################################################################################################
#
#get the diamonds dataset that is included in ggplot2...

library(ggplot2)
data(diamonds)
head(diamonds)

# base histograms
hist(diamonds$carat, main='Carat Histogram', xlab='Carat')

# base scatterplot
plot(price ~ carat, data=diamonds)
plot(diamonds$carat, diamonds$price)

# base boxplots
boxplot(diamonds$carat)

########################################################################################################
#                                     ggplot2: 7.2
########################################################################################################
#
# ggplot2 histograms
ggplot(data=diamonds) +
  geom_histogram(aes(x=carat))

# ggplot2 density plots
ggplot(data=diamonds) +
  geom_density(aes(x=carat), fill='grey50')

# ggplot2 scatterplots
ggplot(diamonds, aes(x=carat, y=price)) +
  geom_point()

# save basic ggplot object to a variable to work with...
g <- ggplot(diamonds, aes(x=carat, y=price))
# ... then build onto the ggplot object variable...
g +
  geom_point(aes(color=color))

# ggplot2 facet plots
g +
  geom_point(aes(color=color)) +
  facet_wrap(~color)

g +
  geom_point(aes(color=color)) +
  facet_grid(cut~color)

# ggplot2 boxplots and violin plots
ggplot(diamonds, aes(x=1, y=carat)) +
  geom_boxplot()

ggplot(diamonds, aes(x=cut, y=carat)) +
  geom_boxplot()

ggplot(diamonds, aes(y=carat, x=cut)) +
  geom_violin()

ggplot(diamonds, aes(y=carat, x=cut)) +
  geom_point()+
  geom_violin()

ggplot(diamonds, aes(y=carat, x=cut)) +
  geom_violin() +
  geom_point(alpha=0.2)

# ggplot2 line graphs
ggplot(economics, aes(x=date, y=pop)) +
  geom_line()

# sometimes we need to use an aes(group=1) with multiple lines
library(lubridate)
# create year and month variables
economics$year <- year(economics$date)
economics$month <- month(economics$date, label=TRUE)
#subset the data
econ2000 <- economics[which(economics$year >= 2000),]

library(scales)
#build the foundation of the plot
g <- ggplot(econ2000, aes(x=month, y=pop))

g <- g + geom_line(aes(color=factor(year), group=year))

g <- g + scale_color_discrete(name="year")

g <- g + scale_y_continuous(labels=comma)

g <- g + labs(title='Population Growth', x='Month', y='Population')

g

# THEMES
g2 <- ggplot(diamonds, aes(x=carat, y=price)) +
  geom_point(aes(color=color))

g2 + theme_minimal()
g2 + theme_dark()
g2 + theme_light()
g2 + theme_void()
g2 + theme_classic()
g2 + theme_gray()
g2 + theme_bw()
g2 + theme_linedraw()

theme_set(theme_classic())
g2

