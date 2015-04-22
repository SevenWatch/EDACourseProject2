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