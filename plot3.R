#######################################################################################################
##This script is designed to read in a file from the National Emissions Inventory database and see   ##
##what it says about fine particulate matter pollution in the United States over the 10-year period  ##
##1999-2008. In particular, this script will create a plot that shows if the total emissions of PM2.5##
##decreased in Baltimore, Maryland by the type of source. The created plot will be output to a file  ##
##called 'plot3.png'.                                                                                ##
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

##Subset table by state code fips == 24510
NEI.sub <- subset(NEI.DT, fips == "24510")

##Summarize data to sum emissions by type and year
NEI.type <- NEI.sub[, list(totalEmissions = sum(Emissions)), by = c("type", "year")]

##Open PNG file
png(filename = "plot3.png", width = 640, height = 480, units = "px")

##Plot data
g <- ggplot(NEI.type, aes(factor(year), totalEmissions, fill = type))
g + geom_bar(stat = "identity") + facet_grid(.~type, scales = "free", space = "free") +
     labs(x = "Year", y = expression("PM"[2.5]*" Emissions (tons)")) +
     theme_bw() + theme(plot.title = element_text(hjust = 0.5)) + guides(fill = FALSE) + 
     ggtitle(expression("PM"[2.5]*" Emissions in Baltimore, MD between 1999 and 2008 by Source Type"))

##Close PNG file
dev.off()
