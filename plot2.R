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