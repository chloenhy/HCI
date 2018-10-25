# In this dataset providede by Dr Duncan Brumby, 6 participants carried out the Fitt's Law activity 
# by clicking a red circle appearing among other dark circle in 4 different levels of ID, 
# and with 2 different devices, namely mouse and trackpad.

# Goal: To investigate if there is a difference in TP between mouse and trackpad.

1 - Data Cleaning
# read csv file
exp <- read.csv(file="allParticipants.csv", header=TRUE, sep=",")

# remove training data
exp1 <- exp[!(exp$Type == "training"),]

2 - Summary statistics for Time used for all trials
> summary(exp1$Time)
   Min. 1st Qu.  Median    Mean 3rd Qu. 
  505.0   697.0   775.0   810.3   887.0 
   Max. 
 1531.0 

Mean time Histogram 
hist(exp1$Time,labels = T, main = "Movement Time distribution
    ", xlab = ("Movement Time (millisec)"), ylab = ("Freq"))

3 - Compute Index of Difficulty for each level

> log2(225/60 + 1)
[1] 2.247928
> log2(325/60 + 1)
[1] 2.681824
> log2(225/35 + 1)
[1] 2.893085
> log2(325/35 + 1)
[1] 3.36257


4 - Marginal mean for the Time for each Index of Difficulty 
Method 1: 
q4 <- aggregate(exp1$Time, list(exp1$ID), mean)

Method 2:
# create subset for each ID 
first <- subset(exp1, col1<=2.247928)
second <- subset(exp1, ID>2.247928 & ID<=2.681825)
third <- subset(exp1, ID>2.681825 & ID<=2.893086)
fourth <- subset(exp1, ID > 2.893085)

# find mean
> mean(first$Time)
[1] 729.2583
> mean(second$Time)
[1] 799.2583
> mean(third$Time)
[1] 820.2167
> mean(fourth$Time)
[1] 892.4167

5 - Scatter plot: ID v.s. Time
Method 1:
q4 <- setNames(q4, c("ID", "meanTime"))
plotq4 <- plot(q4, type='p', main="Effect of ID on movement time", xlab="ID (bits)", ylab="Mean Time (millisecond)")
plotq4 <- abline(lm(q4$meanTime~q4$ID)) # challenge 2

# add device ~ time, challenge 3
deviceTable <- aggregate(exp1$Time, list(exp1$Device, exp1$ID), mean)
deviceTable <- setNames(deviceTable, c("Device", "ID", "meanTime"))

mouse <- subset(deviceTable, deviceTable$Device=='Mouse')
trackpad <- subset(deviceTable, deviceTable$Device=='Trackpad')
xyplot(deviceTable$meanTime ~ mouse$ID + trackpad$ID, col = c("black", "red"), auto.key=T,  type = c('p','p'))

# above need to add regression line for each device




Method 2: 
q5 <- data.frame(ID = c(2.247928, 2.681824, 2.893085, 3.36257), meanTime = c(mean(first$Time), mean(second$Time), mean(third$Time), mean(fourth$Time))
plot(q5)
abline(lm(q5$meanTime~q5$ID))
print(lm(q5$meanTime~q5$ID))

                 
6 - Compute Throughput 
exp1$throughput <- (exp1$ID/(exp1$Time/1000))
                 
7 - Compute mean TP by devices
TPbyDevice <- aggregate(exp1$throughput, list(exp1$Device), mean)
TPbyDevice <- setNames(TPbyDevice, c("Device", "TP"))
TPbyDevice
    Device       TP
1    Mouse 3.666732
2 Trackpad 3.423902
                 
                 
8 - Bar chart: Device v.s. mean TP 
barplot(TPbyDevice$TP, ylab = "Throughput (bits/sec)", main="Throuhput of mouse and trackpad", names.arg=c("Mouse", "Trackpad"))
                 
