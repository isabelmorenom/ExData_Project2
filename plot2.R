###############################################################
#                      PLOT2.R
# QUESTION 2.
#
#Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this 
#question.
#
# ANSWER.
#
# As we can see in plot2.png, the PM2.5 decreased, but in 2005
# increased over the 2002 year.
#      1999     2002     2005     2008 
#   3274.180 2453.916 3091.354 1862.282 
##############################################################


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

# Group by year.

Totals<-tapply(Baltimore$Emissions,Baltimore$year,sum)

#Create plot2.png

png("plot2.png")
barplot(
  (Totals),
  names.arg=names(Totals),
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions from Baltimore City,Maryland"
)
dev.off()

