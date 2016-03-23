###############################################################
#                      PLOT3.R
# QUESTION 3.
#
#Of the four types of sources indicated by the type
#(point, nonpoint, onroad, nonroad) variable, which of these
#four sources have seen decreases in emissions from 1999-2008
#for Baltimore City? Which have seen increases in emissions 
#from 1999-2008? Use the ggplot2 plotting system to make a plot
#answer this question
#
# ANSWER.
#
# As we can see in plot3.png, all types of pollution sources
# decreased except type  "POINT" FROM 297 tons of PM2.5 in 1999
# to 345 tons in 2008, with a large increase in 2005 (1202 tons)
# The main pollution source in Baltimore City is "NONPOINT" type.
##############################################################
library(ggplot2)

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

# Baltimore City Data.

Baltimore<-NEI[NEI$fips=="24510",]

#Group by years and type

Totals <- aggregate(Emissions ~ year + type,
                                          Baltimore, sum)

#Create plot

png("plot3.png", width=640, height=480)

g<-qplot(as.factor(year), Emissions, data = Totals, 
      group = type,
      color = type, 
      geom = c("point", "line"),
      ylab = "Total Emissions PM2.5 (tons)", 
      xlab = "Year",
      main = "Total Emissions in Baltimore City from 1999 to 2008")

print(g)
dev.off()
