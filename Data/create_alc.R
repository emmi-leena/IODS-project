# Emmi-Leena Ihantola 18.11.2019-R.studio excercise 3
#Data reference: Paulo Cortez, University of Minho, GuimarÃ£es, Portugal, http://www3.dsi.uminho.pt/pcortez

#Reading of the data
math<- read.csv("C:/Users/emmilei/Documents/IODS-project/student/student-mat.csv", sep = ";", header=TRUE)
por <- read.csv("C:/Users/emmilei/Documents/IODS-project/student/student-por.csv", sep = ";", header=TRUE)

#Exploration the structure and dimension
str(math)
dim(math)
str(por)
dim(por)
colnames(math)
colnames(por)

#Joining of two dataset
library(dplyr)
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

#Exploration the structure and dimension of joined dataset
str(math_por)

dim(math_por)
# Combination of duplicated answers

colnames(math_por)
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
notjoined_columns
for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}

glimpse(alc)

library(ggplot2)
# Average of the answers related to weekday and weekend alcohol consumption for create new column
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))
g1 + geom_bar()

# Creation of a new logical column high use
alc <- mutate(alc, high_use = alc_use > 2)
g2 <- ggplot(alc, aes(high_use))
g2 + facet_wrap("sex") + geom_bar()

glimpse(alc)

setwd("~/IODS-project")
write.csv(alc, file = "alc.csv")
read.csv("alc.csv")

# Analysis

# Reading of the data

alc <-read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt", sep = ",", header=TRUE)

# structure and dimension of the data:
colnames(alc)
str(alc)
dim(alc)

# Data is consisted of two joined datasets where students achievement in secondary education of two Portuguese schools are explained. Two datasets are provided regarding the performance in two distinct subjects.
# Data consist of 382 objectives and 35 variables.

# Names of variables:
colnames(alc)

#FOllowing variables were compared to high/low alcohol consumption
Sex, failures, goout, absences

#Personal hypothesis behind these chosen variables
#Sex: There are more men than women that use alcohol in high consumption
#age: Students that have high number of past class failures are using more alcohol
#goout: Students that go out with friends have high consumption of alcohol
#health: Students that have high alcohol consumption have lower health status

#Numeral exploration of the distributions of chosen variables and their relationship with alcohol consumption

library(ggplot2)
alc %>% group_by(sex, high_use) %>% summarise(count = n())
#This data shows that most of the men and womens alcohol consumption is on low level. However, more men are using alcohol high level than women. Therefore my intial hypothesis was partially right.
 
alc %>% group_by(failures, high_use) %>% summarise(count = n()) 
#This data shows

alc %>% group_by(goout, high_use) %>% summarise(count = n())

alc %>% group_by(health, high_use) %>% summarise(count = n())

# Graphical exploration of the distributions of chosen variables and their relationship with alcohol consumption

# Alcohol use vs. sex
g1 <- ggplot(alc, aes(x = sex, y = alc_use))
g1 + geom_boxplot() + ylab("alcohol usage")             
                     
# Alcohol use vs. age

g2 <- ggplot(alc, aes(x = high_use, y = age))
g2 + geom_boxplot()+ ylab("ages")

# Alcohol use vs. goout

g2 <- ggplot(alc, aes(x = high_use, y = goout))
g2 + geom_boxplot()+ ylab("go out")

# Alcohol use vs. health

g2 <- ggplot(alc, aes(x = high_use, y = health))
g2 + geom_boxplot()+ ylab("health")

#Logistic regression

m <- glm(high_use ~ sex + age + goout + health, data = alc, family = "binomial")
summary(m)
coef (m)

# To compute odds ratios (OR):
OR <- coef(m) %>% exp

# To compute confidence intervals (CI):
CI <- confint(m) %>% exp

# TO print out the odds ratios with their confidence intervals
cbind(OR, CI)

# fit the model
m <- glm(high_use ~ failures + absences + sex, data = alc, family = "binomial")

# To predict() the probability of high_use
probabilities <- predict(m, type = "response")
alc <- mutate(alc, probability = probabilities)

# use the probabilities to make a prediction of high_use
alc <- mutate(alc, prediction = probability > 0.5)
select(alc, failures, absences, sex, high_use, probability, prediction) %>% tail(10)
table(high_use = alc$high_use, prediction = alc$prediction)

