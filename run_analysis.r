setwd("./Documents/R/jhu/Project")

features = read.table("features.txt", header = FALSE)
activity_labels = read.table("activity_labels.txt", header = FALSE)

# Reading train data
subject_train = read.table("subject_train.txt", header = FALSE)
x_train = read.table("X_train.txt", header = FALSE)
y_train = read.table("y_train.txt", header = FALSE)

# Reading test data
subject_test = read.table("subject_test.txt", header = FALSE)
x_test = read.table("X_test.txt", header = FALSE)
y_test = read.table("y_test.txt", header = FALSE)

# 1. Merges the training and the test sets to create one data set
x = rbind(x_train, x_test)
y = rbind(y_train, y_test)
subject = rbind(subject_train, subject_test)

# 4. label the datasets
names(x) = features[,2]
names(y) = "activity"
names(subject) = "subject"

data = cbind(subject, y, x)

# 2. Extract mean snd standard deviation
x = data[,grep("mean|std",names(x))]

# 3. Name the activies
data$activity = activity_labels[data$activity,2]

# 5. Tidy data with average of each variable/activity/subject
library(plyr)
tidy = aggregate(data, by = list(activity = data$activity, subject = data$subject), mean)

# Remove unnecessary columns
tidy = tidy[,-c(3:4)]

write.table(tidy, "tidy.txt", row.name=FALSE)