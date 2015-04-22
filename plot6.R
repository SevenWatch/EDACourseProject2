
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

##data$Year <- as.character(data$Year)
##Changing fips number to city name
data$City <- gsub("24510", "Baltimore City", data$City)
data$City <- gsub("06037", "Los Angeles County", data$City)

##CREATING PLOT AS PNG FILE WITH GGPLOT2
library(ggplot2) #loading the library

png(filename= "plot6.png", width=480, height=480)

mytitle <- as.character("Total Emissions of PM2.5 in\n Baltimore City (Maryland) and Los Angeles County (California)\n 1999 to 2008 from Motor Vehicle Source")
p <- ggplot(data, aes(Year, Emission), group = City, color = City)
p <- p + geom_line(size = 0.9, aes(linetype = City, color = City)) 
p <- p + geom_point(size = 3.0, aes(color = City))
p <- p + ggtitle(mytitle)
p <- p + theme(plot.title = element_text(size=10,face="bold"))
p <- p + ylab("Emission in Tons")
p
dev.off()



###################################################################
##########        SEE YOU SPACE COWBOY...               ###########
###################################################################