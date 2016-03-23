##########################################################
#
#    Code to download data for Project 2 of Coursera
#
##########################################################
  
  path<-getwd()
  
  #Get data
  
  f <- "exdata-data-NEI_data.zip"
  if (!file.exists("exdata-data-NEI_data.zip")){
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
   
    download.file(url, file.path(path, f))
  }  
    #Unzip file
    
    executable <-file.path("C:/Program Files/WinRAR/WinRaR.exe")
    parameter <- "x"
    cmd <- paste(paste0("\"", executable, "\""), parameter, paste0("\"", file.path(path, 
                                                                                   f), "\""))
    system(cmd)
  

