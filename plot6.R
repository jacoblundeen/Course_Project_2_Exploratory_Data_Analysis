#######################################################################################################
##This script is designed to read in a file from the National Emissions Inventory database and see   ##
##what it says about fine particulate matter pollution in the United States over the 10-year period  ##
##1999-2008. In particular, this script will create a plot that will compare motor vehicle emissions ##
##between Baltimore, MD and Los Angeles, CA between 1999 and 2012. The created plot will be output   ##
##to a file called 'plot6.png'.                                                                      ##
##By: Jacob M. Lundeen; Date: 2017 07 26                                                             ##
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

##NEI is subset twice, once for Baltimore and once for LA. The city names are added to the data.tables
##for the plot, and then the subsets are bound together.
NEI.balt <- subset(NEI.veh, fips == "24510")
NEI.balt$city <- "Baltimore city"
NEI.la <- subset(NEI.veh, fips == "06037")
NEI.la$city <- "Los Angeles"
NEI.both <- rbind(NEI.balt, NEI.la)

##Open PNG file
png(filename = "plot6.png", width = 640, height = 480, units = "px")

##Plot data
g <- ggplot(NEI.both, aes(x = factor(year), Emissions, fill = city))
g + geom_bar(stat="identity", width=0.75, aes(fill = year)) + facet_grid(scales = "free",
                                                                         space = "free", .~city) +
     theme_bw() +  guides(fill=FALSE) +
     labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
     labs(title=expression("PM"[2.5]*" Vehicle Source Emissions for Baltimore and LA from 1999-2008")) +
     theme(plot.title = element_text(hjust = 0.5))

##Close PNG file
dev.off()
