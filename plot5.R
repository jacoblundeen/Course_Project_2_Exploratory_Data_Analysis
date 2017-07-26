#######################################################################################################
##This script is designed to read in a file from the National Emissions Inventory database and see   ##
##what it says about fine particulate matter pollution in the United States over the 10-year period  ##
##1999-2008. In particular, this script will create a plot that shows if the total emissions of PM2.5##
##produced by moto vehicles decreased in Baltimore, Maryland. The created plot will be output to a   ##
##file called 'plot5.png'.                                                                           ##
##By: Jacob M. Lundeen; Date: 2017 07 25                                                             ##
#######################################################################################################

##Load required packages
library(data.table)
library(ggplot2)

##Set required file names and then check current directory to see if the files are present
filename1 <- "summarySCC_PM25.rds"
filename2 <- "Source_Classification_Code.rds"

if(filename1 %in% dir() == FALSE)
{
     warning("File not present in directory")
} else if(filename2 %in% dir() == FALSE)
{
     warning("File not present in directory")
}

##Read in file as a data.table
NEI.DT <- as.data.table(readRDS(filename1))
SCC.DT <- as.data.table(readRDS(filename2))

##Use grepl to create a logical vector for motor vehicles from the Level Two table. I then used that
##logical vector to pull out the necessary SCC strings, which are then used to subset the NEI data.
vehicles <- grepl("vehicle", SCC.DT$SCC.Level.Two, ignore.case = TRUE)
SCC.veh <- SCC.DT[vehicles,]$SCC
NEI.veh <- NEI.DT[NEI.DT$SCC %in% SCC.veh]

##NEI data is subset by fips == "24510", the city code for Baltimore
NEI.balt <- subset(NEI.veh, fips == "24510")

##Open PNG file
png(filename = "plot5.png", width = 640, height = 480, units = "px")

##Plot data
g <- ggplot(NEI.balt, aes(factor(year), Emissions))
g + geom_bar(stat="identity", width=0.75, aes(fill = year)) +
     theme_bw() +  guides(fill=FALSE) +
     labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
     labs(title=expression("PM"[2.5]*" Vehicle Source Emissions for Baltimore, MD from 1999-2008")) +
     theme(plot.title = element_text(hjust = 0.5))

##Close PNG file
dev.off()
