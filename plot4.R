###############################################################
#                      PLOT4.R
# QUESTION 4.
#
# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999-2008?
#
# ANSWER.
#
# As we can see in plot4.png, all types of pollution sources
# (POINT and NONPOINT) decreased from 1999 to 2008. In 2002
# and 2005, the emissions by NONPOINT sources were the same
# (65034 tons) and by POINT increased from 481755 tons (2002)
# to 487847 tons (2005). The main pollution source is POINT for
# the emissions from coal combustion.
# 
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

#Get data from coal combustion (SSC$EI.Sector)

coal<-SCC[grepl("Coal",SCC$EI.Sector,ignore.case=TRUE),]

#EI.Sector from coal combustion
#[1] Fuel Comb - Electric Generation - Coal     
#[2] Fuel Comb - Industrial Boilers, ICEs - Coal
#[3] Fuel Comb - Comm/Institutional - Coal   

unique(coal$EI.Sector)

#Merge  NEI and coal data frames by SCC variable

Totalcoal<-merge (NEI,coal,by="SCC")

#Types of sources

unique(Totalcoal$type)

#Emissions Group by years and type

Totals <- aggregate(Emissions ~ year + type,
                    Totalcoal, sum)


#Create plot

png("plot4.png", width=640, height=480)

qplot(year,
      Emissions,
      data=Totals, 
      color=type,
      geom="line") +
  stat_summary(fun.y = "sum",
               fun.ymin = "sum",
               fun.ymax = "sum", 
               color = "black",
               aes(shape="total"),
               geom="line") +
  geom_line(aes(size="total", shape = NA)) +
  ggtitle("Total Emissions PM2.5 from Coal Combustion in US") +
  xlab("Year") +
  ylab("Total Emissions PM2.5(tons)") 
  
dev.off()


