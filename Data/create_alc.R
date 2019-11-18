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