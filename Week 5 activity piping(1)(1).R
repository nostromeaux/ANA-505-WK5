#Lines 5 through 20 are examples of various file types 
#and the code to read and write them. 
#Your tasks begin at line 22.

#Getting and saving your dataset is typically a two step process
#Read and write a delimited text file.
#datasetname <- read.table(‘file.txt’)
#write.table(datasetname, ‘file.txt’)

#Read and write a comma separated value file. This is a special case of read.table/ write.table.	
#datasetname <- read.csv(‘file.csv’)
#write.csv(datasetname, ‘file.csv’)

#Read and write an R data file, a file type special for R.	
#load(‘file.RData’)
#save(datasetname, file = ‘file.Rdata’)

#Read and write an R data file from GitHub.
#You need to select 'raw data' on the GitHub page 
#and then copy the URL and put in your code, as below

#TASK: run the code below to get and save the dataset
download.file(url = "https://raw.githubusercontent.com/fivethirtyeight/data/master/airline-safety/airline-safety.csv", destfile = "airline_safety.csv")
#Then you need to name your dataset
airline_safety<- read.csv("airline_safety.csv")

#TASK: take a look at the airline safety data. 
#Replace the ?s with functions that display a sample of the data
head(airline_safety, 2)
#Or
head(airline_safety)

#TASK: Install and call the dplyr package. 
#Replace the ?s with the functions
install.packages("dplyr")
library(dplyr)

#Let's make a random sample of our data and save it
mysample<-sample_n(airline_safety, size=15, replace = FALSE, weight = NULL, .env = NULL)

#Let's save the new sample as a csv file in our wd
write.csv(mysample,"~/mysample.csv", row.names = FALSE)
#TASK: Check your wd. Is the file there? No? ;_;

#Now let's have some fun with *piping*
#we will use our mysample dataset
#The pipe, %>%, comes from the magrittr package. 
#Packages in the tidyverse (like dplyr) load %>% for you automatically, 
#so you don't usually load magrittr explicitly.

#TASK: what other packages are in the tidyverse? answer in a comment: 
#gg2plot, purrr, tibble (there are some others listed on the website, but aren't in my library)

#Example: Let's try some piping with our mysample data
piping<-mysample %>% 
  mutate (seats = avail_seat_km_per_week) %>%
  subset(incidents_85_99 < 24) %>%
  dim()%>%
  print()

#TASK: revise this code chunk using piping
mysample2<-mysample
arrange(mysample2, airline)
mysample2<-filter(mysample2, incidents_85_99<25)
mysample2<-rename(mysample2, seats = avail_seat_km_per_week)
mysample3<-select(mysample2, incidents_00_14, incidents_85_99)
mysample4<-summary(mysample3)
print(mysample4)

piping2<-mysample %>%
  arrange(airline) %>%
  filter(incidents_85_99 < 25) %>%
  mutate(seats = avail_seat_km_per_week) %>% #technically not needed?
  select(incidents_00_14, incidents_85_99) %>%
  summary() %>%
  print()

  

