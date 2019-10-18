#########################################################################################################
#                                               CHAPTER 19
#                                             LINEAR MODELS
#########################################################################################################
#
# RESPONSE = variable we want to predict
# PREDICTOR = variable/s we are using to make the prediction/s

#                                         SIMPLE LINEAR REGRESSON
# Single predictor
data(father.son, package='UsingR')
library(ggplot2)

head(father.son)
ggplot(father.son, aes(x=fheight, y=sheight)) +
  geom_point() +
  geom_smooth(method='lm') +
  labs(x='Father', y='Son')

# show model results
heightsLM <- lm(sheight ~ fheight, data=father.son)
heightsLM
summary(heightsLM)

#                                       MULTIPLE LINEAR REGRESSION
# Multiple predictors
