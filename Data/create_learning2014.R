# Emmi-Leena Ihantola 10.11.2019-performing R-studio excercise 2

#Reading data
learning2014 <- read.table ("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header=TRUE)

##Dimension of learning2014 data
dim(learning2014) 
"consist of 180 observations and 60 variables"

##Structure of learning 2014 data
str(learning2014)
"Most results are showed as likert scale (1-5) variables"
"Data also  includes gender (F or M, as a two level factor) and age (in years) of the person"
"Data also includes points and attitude of the person"

#Creation of analysis dataset with the variables gender, age, attitude, deep, stra, surf and points

gender <-c("Gender")
age <- c("Age")
attitude_questions <- c("Da","Db","Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")
stra_questions <- c("ST01", "ST09", "ST17", "ST25", "ST04", "ST12", "ST20", "ST28")
surf_questions <- c("SU02", "SU10", "SU18", "SU26","SU05", "SU13", "SU21", "SU29", "SU08", "SU16", "SU24", "SU32")
points <- c("Points")

#Scaling of all combination variables to original scales (by taking mean)
library(dplyr)
deep_columns <- select(learning2014, one_of(deep_questions))
stra_columns <- select(learning2014, one_of(stra_questions))
surf_columns <- select(learning2014, one_of(surf_questions))
attitude_columns <- select(learning2014, one_of(attitude_questions))

learning2014$deep <- rowMeans(deep_columns)
learning2014$stra <- rowMeans(stra_columns)
learning2014$surf <- rowMeans(surf_columns)
learning2014$attitude <- attitude_columns / 10

keep_columns <- c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")

learning2014 <- select(learning2014, one_of(keep_columns))

learning2014$Attitude <- c(learning2014$Attitude) / 10
learning2014$Attitude

learning2014 <-filter(learning2014, Points>0)
dim(learning2014)

setwd("~/IODS-project")
write.csv(learning2014, file = "learning2014.csv")
read.csv("learning2014.csv")

# Analysis of the data

read.csv("learning2014.csv")

dim(learning2014)
str(learning2014)

"Data set consist of 166 observations and 7 variables (Gender, Age, Attitude, deep, stra, surf, Points"
"Gender consisted two level factor (F=1 or M=2). "
"Attitude, deep, stra and surf are numeric factors."

## Graphical overview of data

pairs(learning2014 [-1], col = learning2014$gender)

"Changing of column names" 
colnames(learning2014)[7] <- "points"
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"

library (ggplot2)
library(GGally)
pairs(learning2014 [-1], col = learning2014$gender)
p <- ggpairs(learning2014, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))
p

p1 <- ggplot(learning2014, aes(x = attitude, y = points, col = gender))
p2 <- p1 + geom_point()
p2
p3 <- p2 + geom_smooth(method = "lm")
p3

##Summary of the variables
summary(learning2014)

##Regression model
ggpairs(learning2014, lower = list(combo = wrap("facethist", bins = 20)))
my_model1 <- lm(points ~ attitude + stra + surf, data = learning2014)

##Summary of the fitted model
summary(my_model1)

"Stra and surf are not significant (p value less than 0.05) and they are deleted from the the variable and model is fitted again without them"
my_model1.2 <- lm(points ~ attitude, data = learning2014)
summary(my_model1.2)

##Diagnostic plots
par(mfrow = c(2,2))
plot(my_model1.2, which = c(1,2,5))

