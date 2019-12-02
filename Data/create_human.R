#Data wrankling (Excercise 5)
#Emmi-Leena Ihantola
#2.12.2019



#Loading of human data
human <- read.table ("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)


#Structure and dimension of the data
str(human)
dim(human)
colnames(human)

#This data consist of 19 variables and 195 observations. The data includes following data about humand development and gender inequality.

#Mutation of the data by transfroiming the Gross National Income (GNI) variable to numeric using string manipulations
library(stringr)
str(human$GNI)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

#Exclution of unneeded variables
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

#Deletion of all rows with missing values
human_ <- filter(human, complete.cases(human))
human_


