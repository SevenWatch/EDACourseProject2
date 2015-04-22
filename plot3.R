############################################################
#############################################################################
##Greetings there! This is a R script called Plot3.R
##For the Second Course Project in Exploratory Data Analysis
##  "Sat Apr 18 09:18:46 2015" This is the date of download.
## This R script assumes the needed files have been downloaded and unzipped 
##in the working directory. 
##The following code was written by SevenWatch

#############################################################################
##READING FILES
##We are provided with two RDS file. the function to read them is readRDS()

SCC <- readRDS("./Source_Classification_Code.rds")

NEI <- readRDS("./summarySCC_PM25.rds")

NEI <- na.omit(NEI)
############################################################################
##QUESTION3
##Of the four types of sources indicated by the type (point, nonpoint, onroad,
##nonroad) variable, which of these four sources have seen decreases in
##emissions from 1999-2008 for Baltimore City? Which have seen increases in
##emissions from 1999-2008? Use the ggplot2 plotting system to make a plot
##answer this question.

##SUBSETTING DATASET
##Subsetting for Baltimore City, Maryland.
subdata <- subset(NEI, NEI$fips == "24510")
##Subsetting only needed columns.
subdata <- subdata[, c("Emissions", "type", "year")]
##Summing by year.
data <- aggregate(subdata[, "Emissions"], 
                  by=list(subdata$type, subdata$year), "sum")
##Amending the col names.
colnames(data) <- c("Type", "Year", "Emission")
##Threat the years as character to get the x axis sticks stable 
##and center the bars.
data$Year <- as.character(data$Year)

##CREATING THE PLOT AS PNG FILE WITH GGPLOT2
library(ggplot2) #loading the library
png(filename= "plot3.png", width=480, height=480)

mytitle <- as.character("Total Emissions of PM2.5 in Baltimore City\n (Maryland, 1999 to 2008) by Source Type")
p <- qplot(Year, Emission, data = data, facets =.~ Type, geom = "bar", 
           stat="identity", fill= Type)
p <- p + ylab("Emission in Tons")
p <- p + labs(title = mytitle)
p <- p +theme(axis.text=element_text(size=8), 
              axis.title=element_text(size=14,face="bold"), 
              plot.title = element_text(size=14,face="bold"))
p
dev.off()

###################################################################
##########        SEE YOU SPACE COWBOY...               ###########
###################################################################