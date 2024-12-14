#Calculate the % reduction in seq length after TEtrimmer
setwd("~/Desktop/TEtrimmersummaryfiles/EGLrun")
df=read.table("summary.txt",header=T)
filter_skipped <- df[df[[13]] != "skipped", ]
filter_skipped[,6:7]
cons_length <- sum(df[6])
input_length <- sum(df[7])
print(cons_length)
print(input_length)
percent_reduced <- ((input_length-cons_length)/input_length)*100
cat("TE sequence length reduced by an average of ",percent_reduced,"%", sep = "")