# Coursera - Exploratory Data Analysis End of Course Project
This repository holds the plots and R code for the Coursera end of course project in Exploratory Data Analysis. The data needed for this project was downloaded from the course website. The data used is air pollutant data collected by the EPA from 1999 - 2008 for the United States.

The R scripts for this project use readRDS() to read in the files, and then break down the data according to what is needed. That data is then plotted using either the base plotting functions or ggplot2. Six separate plots are created to answer the following six questions: 

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# Code Book
"CodeBook.md" provides information on the data contained within the zip file that is used for this project.

# Plots
Plots 1 - 6 are the products used to answer the above questions.
