# CodeBook
This Code Book provides a description of the files and data used in this project.

# PM2.5 Emissions Data
PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, 
and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 
Here are the first few rows.

| fips | SCC | Pollutant | Emissions | type | year |
|:----:|-----|-----------|:---------:|------|------| 
| 09001 | 10100401 | PM25-PRI | 15.714 | POINT | 1999 |
| 09001 | 10100404 | PM25-PRI | 234.178 | POINT | 1999 |
| 09001 | 10100501 | PM25-PRI | 0.128 | POINT | 1999 |
| 09001 | 10200401 | PM25-PRI | 2.036 | POINT | 1999 |
| 09001 | 10200504 | PM25-PRI | 0.388 | POINT | 1999 |
| 09001 | 10200602 | PM25-PRI | 1.490 | POINT | 1999 |

- fips: A five-digit number (represented as a string) indicating the U.S. county
- SCC: The name of the source as indicated by a digit string (see source code classification table)
- Pollutant: A string indicating the pollutant
- Emissions: Amount of PM2.5 emitted, in tons
- type: The type of source (point, non-point, on-road, or non-road)
- year: The year of emissions recorded

# Source Classification Code
Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the
Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more
specific. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.
