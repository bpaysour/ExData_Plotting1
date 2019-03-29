options(stringsAsFactors = FALSE);
setwd("~/JHU_DataScienceCourse/CourseProjects/Course4/Week1");
###############################################################################################################
###Read in only the data for 2007/02/01 - 2007/02/02, omitting the header.  Then read the file with the		###
###header, and use the header to assign variable names to the selected data.								###
###############################################################################################################
data1 <- read.table("household_power_consumption.txt", header  = FALSE, sep = ";", skip = 66637, nrows = 2880);
dataHeader <- read.table("household_power_consumption.txt", header  = TRUE, sep = ";", nrows = 1);
colnames(data1) <- colnames(dataHeader);
###############################################################################################################
###Identify any values of '?' as missing, and convert the Date and Time variables to Date/Time objects.		###
###############################################################################################################
library(dplyr);
newdata <- data1 %>% na_if("?");
newdata$DateTime <- paste(newdata$Date, "-", newdata$Time, sep = "");
newdata$DateTime <- strptime(newdata$DateTime, format = "%d/%m/%Y-%H:%M:%S");
newdata$Date <- as.Date(newdata$Date, format = "%d/%m/%Y");
###############################################################################################################
###Plot the second chart required for the assignment, and write to a .png file.								###
###############################################################################################################
png(filename = "plot2.png", width = 480, height = 480);
plot(newdata$DateTime, newdata$Global_active_power, type = "l", 
	col = "black", main = "", xlab = "", ylab = "Global Active Power (kilowatt)", 
	cex.axis = 0.8, cex.lab = 0.8);
dev.off();
