#load dataset
all = read.csv("C:/Users/pifu3/Downloads/2024 mlb batting data.csv")
qualified = read.csv("C:/Users/pifu3/Downloads/2024 mlb batting data (qualified).csv")
df2 = read.csv("C:/Users/pifu3/Downloads/2023 mlb batting data (qualified).csv")
#the file path is different depending on your computer
#the file can be downloaded from https://github.com/hermesfu/mlb-data-collector
#I also include the files in the submission

#part 1

#compare two data set
par(mfrow=c(2,2))
hist(all$G, breaks = seq(0, 170, 10))
hist(all$AB, breaks = seq(0, 700, 20))
hist(qualified$G, breaks = seq(0, 170, 10))
hist(qualified$AB, breaks = seq(0, 700, 20))

#shortcut for the future code
df = qualified
attach(df)

#basic info of data
dim(all)
head(all)
dim(qualified)
head(qualified)

#basic info of different columns
unique(position)
unique(TEAM)

boxplot(R, RBI, names=c('R', 'RBI'))
boxplot(H-X2B-X3B-HR, X2B, X3B, HR, names=c('1B', '2B', '3B', 'HR'))
boxplot(SO, BB, names=c('SO', 'BB'))
boxplot(SB, CS, names=c('SB', 'CS'))
boxplot(AVG, OBP, SLG, OPS, names=c('AVG', 'OBP', 'SLG', 'OPS'))

#part 2

#1. ANOVA for Home Runs Based on Positions

boxplot(HR~position)
aggregate(HR, by=list(position), sd)
qqnorm(HRanova$residuals)
HRanova=aov(HR~as.factor(position))
summary(HRanova)
pairwise.t.test(HR, position, p.adj='bonferroni', pool.sd=FALSE)

#2. ANOVA for Stolen Bases Based on Positions

boxplot(SB~position)
aggregate(SB, by=list(position), sd)
qqnorm(SBanova$residuals)
SBanova=aov(SB~as.factor(position))
summary(SBanova)
pairwise.t.test(SB, position, p.adj='bonferroni', pool.sd=FALSE)

#3. Classification of positions

library(nnet)
all = multinom(position~G+AB+R+H+X2B+X3B+HR+RBI+BB+SO+SB+CS+AVG+OBP+SLG+OPS)
summary(all)

#testing for the first model
results = round(predict(all, df, type='prob'), 3)
cbind(position, apply(results, 1, function(row) names(row)[which.max(row)]))
sum(position == apply(results, 1, function(row) names(row)[which.max(row)])) / length(position)
prop.test(x=c(sum(position == apply(results, 1, function(row) names(row)[which.max(row)])), length(position)/9),
          n=c(length(position),length(position)), alternative='greater')

results = round(predict(all, df2, type='prob'), 3)
cbind(df2$position, apply(results, 1, function(row) names(row)[which.max(row)]))
sum(df2$position == apply(results, 1, function(row) names(row)[which.max(row)])) / length(df2$position)
prop.test(x=c(sum(df2$position == apply(results, 1, function(row) names(row)[which.max(row)])), length(df2$position)/9),
          n=c(length(df2$position),length(df2$position)), alternative='greater')

less = step(all)
summary(less)

#testing for the reduced model
results = round(predict(less, df, type='prob'), 3)
cbind(position, apply(results, 1, function(row) names(row)[which.max(row)]))
sum(position == apply(results, 1, function(row) names(row)[which.max(row)])) / length(position)
prop.test(x=c(sum(position == apply(results, 1, function(row) names(row)[which.max(row)])), length(position)/9),
          n=c(length(position),length(position)), alternative='greater')

results = round(predict(less, df2, type='prob'), 3)
cbind(df2$position, apply(results, 1, function(row) names(row)[which.max(row)]))
sum(df2$position == apply(results, 1, function(row) names(row)[which.max(row)])) / length(df2$position)
prop.test(x=c(sum(df2$position == apply(results, 1, function(row) names(row)[which.max(row)])), length(df2$position)/9),
          n=c(length(df2$position),length(df2$position)), alternative='greater')