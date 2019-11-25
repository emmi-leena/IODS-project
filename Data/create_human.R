#Data wrankling (Excercise 4)
#Emmi-Leena Ihantola
#25.11.2019


#Reading of "Human development" and "Gender inequality"
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Structure and dimension of the data
str(hd)
str(gii)
dim(hd)
dim(gii)

#Human development data consisted of 195 observations and 8 variables.
#Gender inequality data consisted 195 observations and 10 variables.


#Summaries of the variables
summary(hd)
summary(gii)

#Renaming of variables
names(hd)
names(hd)[1]<- "HDI_rank"
names(hd)[2]<- "count_hdi"
names(hd)[3]<- "HDI_index"
names(hd)[4]<- "life_expect"
names(hd)[5]<- "expect_y_edu"
names(hd)[6]<- "mean_y_edu"
names(hd)[7]<- "GNI"
names(hd)[8]<- "GNI-HDIrank"

names(gii)
names(gii)[1]<- "GII_rank"
names(gii)[2]<- "count_gii"
names(gii)[3]<- "gend_inequal_index"
names(gii)[4]<- "mom_mortal_ratio"
names(gii)[5]<- "adol_birth_rate"
names(gii)[6]<- "%_represten_parl"
names(gii)[7]<- "m_2nd_edu"
names(gii)[8]<- "f_2nd_edu"
names(gii)[9]<- "f_labour_participation"
names(gii)[10]<- "m_labour_participation" 

