# Emmi-Leena Ihantola 9.12.2019, Excercise 6

#Reading the datasets

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#Exploring datasets

dim(BPRS)
str(BPRS)

dim(RATS)
str(RATS)

#Variable names
names(BPRS)
names(RATS)

#Summary of datasets
summary(BPRS)
summary(RATS)

#Conversion of categorial variables
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#Conversion the sate set to long form
library(dplyr)
library(tidyr)
library(ggplot2)

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group)
RATSL <- RATSL %>%  mutate(Time = as.integer(substr(WD,3,4)))

#Variable names, data contents 

glimpse(BPRSL)
head(BPRSL)
tail(BPRSL)

glimpse(BPRS)
head(BPRS)
tail(BPRS)

glimpse(RATSL)
head(RATSL)
tail(RATSL)

glimpse(RATS)
head(RATS)
tail(RATS)

#writing the datasets to files
setwd("~/IODS-project")
write.csv(BPRSL, file = "BPRSL.csv")
read.csv("BPRSL.csv")


write.csv(RATSL, file = "RATSL.csv")
read.csv("RATSL.csv")