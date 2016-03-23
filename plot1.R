#############################################################
#                   PLOT1.R
#  QUESTION 1.
#
#Have total emissions from PM2.5 decreased in the United States
#from 1999 to 2008? Using the base plotting system, make a plot
#showing the total PM2.5 emission from all sources for each of 
#the years 1999, 2002, 2005, and 2008.
#
# ANSWER.
#
# We can see in plot1.png that the total emissions have decreased in the US 
# from 1999 to 2008. From 7,332,967 tons in 1999 to
# 3,464,206 tons in 2008.
###############################################################

if (!file.exists("summarySCC_PM25.rds") || 
    !file.exists("Source_Classification_Code.rds")){
  
  source("getdata.R")
}

#Data loaded into memory if not there

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

#Group by years

Totals <- tapply(NEI$Emissions,NEI$year, sum)

# Create plot.

png("plot1.png")
barplot(
    (Totals/10^3),
    names.arg=names(Totals),
    xlab="Year",
    ylab="PM2.5 Emissions (10^3 Tons)",
    main="Total PM2.5 Emissions from all US sources"
)
dev.off()
