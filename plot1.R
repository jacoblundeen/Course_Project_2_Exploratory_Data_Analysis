#######################################################################################################
##This script is designed to read in a file from the National Emissions Inventory database and see   ##
##what it says about fine particulate matter pollution in the United States over the 10-year period  ##
##1999-2008. In particular, this script will create a plot that shows if the total emissions of PM2.5##
##decreased in the United States. The created plot will be output to a file called 'plot1.png'.      ##
##By: Jacob M. Lundeen; Date: 2017 07 25                                                             ##
#######################################################################################################

##Load required packages
library(data.table)

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

##Create new variable with summary of emmissions by year
NEI.total <- NEI.DT[, list(totalEmissions = (sum(Emissions) / 1000)), by = "year"]

##Open png file
png(filename = "plot1.png", width = 640, height = 480, units = "px")

##Plot data
with(NEI.total, barplot(totalEmissions, names.arg = year, col = year, xlab = "Year",
                     ylab = "Total Emmissions (kilotons)"))
title(main = expression("Total PM"[2.5]*" Emissions from All Sources between 1999 and 2008"))
with(NEI.total, abline(lm(totalEmissions ~ year), lwd = 2))

##Close png
dev.off()

