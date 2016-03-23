###############################################################
#                      PLOT5.R
# QUESTION 5.
#
# How have emissions from motor vehicle sources changed from
# 1999-2008 in Baltimore City?
#
# ANSWER.
#
# As we can see in plot5.png,from 1999 to 2002, the emissions
# of PM2.5 decreased to media of 10 years.
# summary(Total)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 88.28  119.90  132.40  175.00  187.40  346.80
# The values of emissions per year:
#       1999      2002      2005      2008 
#   346.82000 134.30882 130.43038  88.27546
# 
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

#Get Data of Baltimore

Baltimore<-NEI[NEI$fips=="24510",]

#Get Data of motor vehicle
#Two categories: Onroad and Nonpoint.
#Four EI.Sector
#[1] Mobile - On-Road Gasoline Light Duty Vehicles
#[2] Mobile - On-Road Gasoline Heavy Duty Vehicles
#[3] Mobile - On-Road Diesel Light Duty Vehicles  
#[4] Mobile - On-Road Diesel Heavy Duty Vehicles

vehicles<-SCC[grepl("Vehicles", SCC$EI.Sector, 
                            ignore.case = TRUE),]


unique(vehicles$Data.Category)
unique(vehicles$EI.Sector)

#Merge Data by SCC.
#In Baltimore all emissions of vehicles are from "ON-ROAD"
#source.

Total<-merge (Baltimore,vehicles,by="SCC")

unique(Total$type)

#Group by years

Total <- tapply(Total$Emissions,Total$year, sum)

summary(Total)

# Create plot.

png("plot5.png",width=640, height=480)
barplot(
  (Total),
  names.arg=names(Total),
  xlab="Year",
  ylab="PM2.5 Emissions (tons)",
  main="Total PM2.5 Emissions from Motor Vehicle in Baltimore City"
)
abline(h=median(Total),col="red")
dev.off()
