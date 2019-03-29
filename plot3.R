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
###Plot the third chart required for the assignment, and write to a .png file.								###
###############################################################################################################
png(filename = "plot3.png", width = 480, height = 480);
plot(newdata$DateTime, newdata$Sub_metering_1, type = "n", 
	col = "black", main = "", xlab = "", ylab = "Energy sub metering", 
	cex.axis = 0.8, cex.lab = 0.8);
points(newdata$DateTime, newdata$Sub_metering_1, type = "l", col = "black");
points(newdata$DateTime, newdata$Sub_metering_2, type = "l", col = "red");
points(newdata$DateTime, newdata$Sub_metering_3, type = "l", col = "blue");
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	cex = 0.8, lty = c(1, 1, 1), col = c("black", "red", "blue"));
dev.off();
