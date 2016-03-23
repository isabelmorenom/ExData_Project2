###############################################################
#                      PLOT6.R
# QUESTION 6.
#
# Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles 
# County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?
#
# ANSWER.
#
# As we can see in plot6.png, Baltimore reduced the PM2.5 
# emissions in 258 tons. However, Los Angeles increased in
# 170 tons in the same period. In 2008 the difference between
# Los Angeles and Baltimore is 4013 tons in PM2.5 emissions.
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


#Get Data of Baltimore

Baltimore<-NEI[NEI$fips=="24510",]
vehicles<-SCC[grepl("Vehicles", SCC$EI.Sector, 
                    ignore.case = TRUE),]
dfB<-merge (Baltimore,vehicles,by="SCC")
TotalB <- aggregate (Emissions ~ year ,
                    dfB, sum)

summary(TotalB$Emissions)

#Get Data of Los Angeles
#In Los Angeles the emissions of PM2.5 from motor vehicles
# are from "ON-ROAD"  and "POINT" sources.
# The "POINT" source appears in 2002. The main source is "ON-ROAD".
#  year    type Emissions
#1 1999 ON-ROAD  3931.120
#2 2002 ON-ROAD  4273.710
#3 2005 ON-ROAD  4601.415
#4 2008 ON-ROAD  4101.321
#5 2002   POINT     0.320

LA<-NEI[NEI$fips=="06037",]
dfLA<-merge (LA,vehicles,by="SCC")
TotalLA <- aggregate (Emissions ~ year ,
                     dfLA, sum)
unique(dfLA$type)
summary(TotalLA$Emissions)

#Create a dataframe with the two counties.

TotalB$city<-"Baltimore City"
TotalLA$city<-"Los Angeles County"
Total<-rbind(TotalB,TotalLA)


#Create plot.

png("plot6.png",width=640, height=480,units="px",bg="transparent")

g <- ggplot(Total, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) +
  theme_bw() +
  labs(x="Year", 
        y="Total PM2.5 Emission (tons)") +
  labs(title="Total Emissions PM2.5 from Motor Vehicle in Baltimore and Los Angeles(1999-2008)")
  

print(g)

dev.off()

