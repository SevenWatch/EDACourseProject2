setwd("~/Coursera/Exploratory Data/PROJECT2")
###############################################################
##Greetings there! This is a R script called Allcode.R
##For the Second Project in Exploratory Data Analysis
##First lets download the file.
##We create our data folder. 

##This checks to see if the folder data exists. If it doesnt then it will 
##create it.
if(!file.exists("data")){
  dir.create("data")
}

##Now we can download it from the provided url into our folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile= "./data/dataset.zip")

##Now I feel like recording when I downloaded the file.
dateDownloaded <-date()
dateDownloaded

SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI <- readRDS("./data/summarySCC_PM25.rds")

NEI <- na.omit(NEI)

############################################################
#############################################################################
##Greetings there! This is a R script called Plot1.R
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
##QUESTION 1
##Have total emissions from PM2.5 decreased in the United States from 1999 to
##2008? Using the base plotting system, make a plot showing the total PM2.5
##emission from all sources for each of the years 1999, 2002, 2005, and 2008.

##SUBSETTING DATASET
##We only need Emissions and year.
subdata <- NEI[, c("Emissions", "year")]
##Summing by year.
data <- aggregate(subdata[, "Emissions"], by=list(subdata$year), "sum")
##Amending the col names.
colnames(data) <- c("Year", "Emission")

##The following line forces R to not use scientific notation.
options(scipen=999) ##default is 0

##CREATING THE PLOT AS PNG FILE
png(filename= "plot1.png", width=480, height=480)
barplot(data$Emission, col= "blue", xlab = "Year", ylab ="Emission in Tons", 
        ylim = c(0, max(data$Emission)), 
        names.arg=c("1999", "2002", "2005", "2008"), 
        main = "Total Emissions of PM2.5 in the USA from 1999 to 2008")
dev.off()
options(scipen=0) ##Returning to default.

###################################################################
##########        SEE YOU SPACE COWBOY...               ###########
###################################################################



############################################################
#############################################################################
##Greetings there! This is a R script called Plot2.R
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
###############################################################################
####QUESTION2
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##(fips == "24510") from 1999 to 2008? Use the base plotting system to make a
##plot answering this question.

##SUBSETTING DATASET
##Subsetting for Baltimore City, Maryland.
subdata <- subset(NEI, NEI$fips == "24510")
##Subsetting only needed columns.
subdata <- subdata[, c("Emissions", "year")]
##Summing by year.
data <- aggregate(subdata[, "Emissions"], by=list(subdata$year), "sum")
##Amending the col names.
colnames(data) <- c("Year", "Emission")

##CREATING THE PLOT AS PNG FILE
png(filename= "plot2.png", width=480, height=480)

barplot(data$Emission, col= "blue", xlab = "Year", ylab ="Emission in Tons", 
        names.arg=c("1999", "2002", "2005", "2008"), 
        main = "Total Emissions of PM2.5\n in the Baltimore City (Maryland) from 1999 to 2008")
dev.off()

###################################################################
##########        SEE YOU SPACE COWBOY...               ###########
###################################################################


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



############################################################
#############################################################################
##Greetings there! This is a R script called Plot4.R
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
##############################################################################
##  QUESTION 4
##Across the United States, how have emissions from coal combustion-related 
##sources changed from 1999-2008?

##We will need to subset by source (scc =coal combustion) 
##We need to know the codes from the scc.rds file. 

##Obtaining scc codes with grepl function
codes <- SCC[, c("SCC", "Short.Name")] #Subsetting
codes <- subset(codes, grepl("*Coal", codes$Short.Name))
codes <- codes[, c("SCC")] #Obtaining the scc codes


##SUBSETTING DATASET
##Obtaning dataset that fulfills requirements
##Subsetting  data for coal scc
subdata <- subset(NEI, codes %in% NEI$SCC)
##Subsetting only needed columns.
subdata <- subdata[, c("Emissions","year")]
##Summing by year.
data <- aggregate(subdata[, "Emissions"], by=list(subdata$year), "sum")
##Amending the col names.
colnames(data) <- c("Year", "Emission")
##Threat the years as character to get the x axis sticks stable 
##and center the bars.
data$Year <- as.character(data$Year)

##CREATING THE PLOT AS PNG FILE WITH GGPLOT2
library(ggplot2) #loading the library
##The following line forces R to not use scientific notation.
options(scipen=999) ##default is 0
png(filename= "plot4.png", width=480, height=480)

mytitle <- as.character("Total Emissions of PM2.5 in USA \n(1999 to 2008) from Coal Combustion Source")
p <- qplot(Year, Emission, data = data, geom = "bar", stat="identity", fill = Year)
p <- p + ylab("Emission in Tons")
p <- p + labs(title = mytitle)
p <- p +theme(plot.title = element_text(size=14,face="bold"))
p
dev.off()
options(scipen=0) ##Returning to default.

###################################################################
##########        SEE YOU SPACE COWBOY...               ###########
###################################################################




############################################################
#############################################################################
##Greetings there! This is a R script called Plot5.R
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
##############################################################################  
##QUESTION 5
##How have emissions from motor vehicle sources changed from 1999-2008 in
##Baltimore City?

##We will need to subset by source (scc = vehicle sources) 
##We need to know the codes from the scc.rds file. 

##Obtaining scc codes with grepl function
codes <- SCC[, c("SCC", "Short.Name")] #subsetting
#Selecting all rows containing Veh for Vehicle.
codes <- subset(codes, grepl("*Veh", codes$Short.Name)) 
codes <- codes[, c("SCC")]


##SUBSETTING DATASET
##Obtaning dataset that fulfills requirements
##Subsetting  data for vehicle scc
subdata <- subset(NEI, codes %in% NEI$SCC)
##Subsetting for Baltimore Only
subdata <- subset(subdata, subdata$fips == "24510")
##Subsetting only needed columns.
subdata <- subdata[, c("Emissions","year")]
##Summing by year.
data <- aggregate(subdata[, "Emissions"], by=list(subdata$year), "sum")
##Amending the col names.
colnames(data) <- c("Year", "Emission")
##Threat the years as character to get the x axis sticks stable 
##and center the bars.
data$Year <- as.character(data$Year)


##CREATING THE PLOT AS PNG FILE WITH GGPLOT2
library(ggplot2) #loading the library

png(filename= "plot5.png", width=480, height=480)
mytitle <- as.character("Total Emissions of PM2.5 in Baltimore City\n (Maryland, 1999 to 2008) from Motor Vehicle Source")
p <- qplot(Year, Emission, data = data, geom = "bar", stat="identity", fill = Year)
p <- p + ylab("Emission in Tons")
p <- p + labs(title = mytitle)
p <- p +theme(plot.title = element_text(size=14,face="bold"))
p
dev.off()

###################################################################
##########        SEE YOU SPACE COWBOY...               ###########
###################################################################





############################################################
#############################################################################
##Greetings there! This is a R script called Plot6.R
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
###########################################################################
## QUESTION 6
##Compare emissions from motor vehicle sources in Baltimore City with emissions
##from motor vehicle sources in Los Angeles County, California (fips ==
##"06037"). Which city has seen greater changes over time in motor vehicle
##emissions?

##We will need to subset by source (scc =vehicle sources) 
##We need to know the codes from the scc.rds file. 
codes <- SCC[, c("SCC", "Short.Name")] #subsetting
#Selecting all rows containing Veh for Vehicle.
codes <- subset(codes, grepl("*Veh", codes$Short.Name)) 
codes <- codes[, c("SCC")]


##SUBSETTING DATASET
##Obtaning dataset that fulfills requirements
##Subsetting  data for veh scc
subdata <- subset(NEI, codes %in% NEI$SCC)
##Subsetting for Baltimore and Los Angeles County.
subdata <- subset(subdata, subdata$fips == "24510" |subdata$fips == "06037" )
##Subsetting only needed columns.
subdata <- subdata[, c("fips", "Emissions","year")]
##Summing by year.
data <- aggregate(subdata[, "Emissions"], 
                  by=list(subdata$fips, subdata$year), "sum")
##Amending the col names.
colnames(data) <- c("City", "Year", "Emission")
##Threat the years as character to get the x axis sticks stable 
##and center the bars.
data$Year <- as.character(data$Year)
##Changing fips number to city name
data$City <- gsub("24510", "Baltimore City", data$City)
data$City <- gsub("06037", "Los Angeles County", data$City)

##CREATING PLOT AS PNG FILE WITH GGPLOT2
library(ggplot2) #loading the library

png(filename= "plot6.png", width=480, height=480)
mytitle <- as.character("Total Emissions of PM2.5 in\n Baltimore City (Maryland) and Los Angeles County (California)\n 1999 to 2008 from Motor Vehicle Source")
p <- qplot(Year, Emission, data = data, facets =.~ City, geom = "bar", 
           stat="identity")
p <- p + ylab("Emission in Tons")
p <- p + labs(title = mytitle)
p <- p + theme(plot.title = element_text(size=14,face="bold"))
p
dev.off()

###################################################################
##########        SEE YOU SPACE COWBOY...               ###########
###################################################################


