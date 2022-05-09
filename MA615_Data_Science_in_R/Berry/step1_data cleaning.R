library(knitr)
library(tidyverse)
library(magrittr)
library(stringr)
library(kableExtra)

################################################ step1 ################################################
##read data
ag_data=read_csv("berries.csv", col_names = TRUE)

## look at number of unique values in each column
unique_ind=ag_data %>% summarize_all(n_distinct)

## make a list of the columns with only one unique value
onevalue_col = which(unique_ind[1,]==1)

## remove the 1-unique columns from the dataset
ag_data %<>% select(-all_of(onevalue_col))

## delete State name and the State ANSI code
ag_data %<>% select(-4)

#print the table
kable(head(ag_data)) %>%
  kable_styling(font_size=12)

############################################### step2 ###################################################
#### seperate Measure and Berry
#ag_data %<>% filter((Commodity=="STRAWBERRIES") & (Period=="YEAR"))
ag_data %<>% separate(`Data Item`,c("Berry","Other"),sep = "BERRIES")

#### delete Berry Category
ag_data %<>% select(-Berry)
head(ag_data)

#### Create Measure Method
ag_data %<>% separate(`Other`,c("lab1","Measure"),sep="MEASURED IN")
#check
head(ag_data)
ag_data%>%summarize_all(n_distinct)
unique(ag_data$Measure)

#### Create Type, Production, Marketing, Domain,Chemi_family, Materials
ag_data$Type=str_extract(ag_data$lab1,pattern = "(BEARING)|(TAME)|(WILD)")
ag_data$Production=str_extract(ag_data$lab1,pattern = "PRODUCTION")
ag_data$Marketing=str_extract(ag_data$lab1,pattern ="(ACRES HARVESTED)|(YIELD)|(FRESH MARKET)|(NOT SOLD)|(PROCESSING)|(UTILIZED)|(APPLICATIONS)|(TREATED)|(NOT HARVESTED)") 
ag_data %<>% separate(`Domain`,c("Domain","Chemi_family"),sep=",")
ag_data %<>% separate(`Domain Category`,c("lab2","Materials"),sep="[(]")
ag_data %<>% separate(`Materials`,c("Materials","lab3"),sep="[)]")
#check
head(ag_data)
unique(ag_data$Materials)


############################################### step3 ###################################################
#### export our dataset as new csv file
berry=ag_data %>% select(Year, State, Commodity, Type,Production, Marketing, Measure,Domain,Chemi_family,Materials,Value)
head(berry)

write.csv(berry,"new_berry.csv")


