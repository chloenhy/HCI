

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
XXXX

Mean time Histogram 
xxxxx

3 - Compute Index of Difficulty for each level

> log2(225/60 + 1)
[1] 2.247928
> log2(325/60 + 1)
[1] 2.681824
> log2(225/35 + 1)
[1] 2.893085
> log2(325/35 + 1)
[1] 3.36257


4 - 
