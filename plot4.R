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
