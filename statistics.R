# Set working directory
setwd("/Users/niklas/Documents/OU/S206 – Environmental science/antarctica-project/data_analysis/")

# Load dataset
data <- read.csv("final_mm_data.csv")
albedo <- data$albedo
temperature <- data$temperature

summary(data)

# calculate Spearman rank correlation between albedo and temperature
cor.test(data$albedo, data$temperature, method = 'spearman')