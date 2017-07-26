#######################################################################################################
##This script is designed to read in a file from the National Emissions Inventory database and see   ##
##what it says about fine particulate matter pollution in the United States over the 10-year period  ##
##1999-2008. In particular, this script will create a plot that shows if the total emissions of PM2.5##
##decreased in America by coal combustion. The created plot will be output to a file called          ##
##'plot4.png'.                                                                                       ##
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

##Use grepl to create logical vectors for combustion and coal observations. Combine them those two
##logical vectors and use the SCC subset to pull out needed data from NEI.DT.
SCC.comb <- grepl("comb", SCC.DT$SCC.Level.One, ignore.case = TRUE)
SCC.coal <- grepl("coal", SCC.DT$SCC.Level.Four, ignore.case = TRUE)
SCC.CC <- (SCC.comb & SCC.coal)
comb.SCC <- SCC.DT[SCC.CC,]$SCC
NEI.comb <- NEI.DT[NEI.DT$SCC %in% comb.SCC]

##Open PNG file
png(filename = "plot4.png", width = 640, height = 480, units = "px")

##Plot data
g <- ggplot(NEI.comb, aes(factor(year), Emissions / 10^5))
g + geom_bar(stat="identity", width=0.75, aes(fill = year)) +
     theme_bw() +  guides(fill=FALSE) +
     labs(x="Year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
     labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008")) +
     theme(plot.title = element_text(hjust = 0.5))

##Close PNG file
dev.off()
