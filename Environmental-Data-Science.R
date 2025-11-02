# Principles of Data Science – Environmental Data Example
# Author: Baraka Mitigoa
# Purpose: Analyze air quality data using R
# Dataset: airquality (built-in R dataset)

# 1. Load Libraries
library(tidyverse)
library(ggplot2)
library(dplyr)
library(caret)

# 2. Load Dataset
data("airquality")
df <- airquality

# 3. Inspect the Data
head(df)
summary(df)
str(df)

# Rename columns for readability
colnames(df) <- c("Ozone", "SolarRadiation", "Wind", "Temperature", "Month", "Day")

# 4. Handle Missing Values
# Check for missing values
colSums(is.na(df))

# Replace NA in Ozone and SolarRadiation with column means
df$Ozone[is.na(df$Ozone)] <- mean(df$Ozone, na.rm = TRUE)
df$SolarRadiation[is.na(df$SolarRadiation)] <- mean(df$SolarRadiation, na.rm = TRUE)

# 5. Descriptive Statistics
summary(df$Ozone)
mean(df$Temperature)
sd(df$Wind)

# 6. Data Visualization

# Ozone levels by month
ggplot(df, aes(x = factor(Month), y = Ozone, fill = factor(Month))) +
  geom_boxplot() +
  labs(title = "Monthly Ozone Levels in New York (1973)",
       x = "Month", y = "Ozone (ppb)") +
  theme_minimal()

# Relationship between temperature and ozone
ggplot(df, aes(x = Temperature, y = Ozone)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Relationship between Temperature and Ozone Levels",
       x = "Temperature (°F)", y = "Ozone (ppb)") +
  theme_minimal()

# 7. Simple Linear Regression
# Predict Ozone based on Temperature, Wind, and Solar Radiation
model <- lm(Ozone ~ Temperature + Wind + SolarRadiation, data = df)
summary(model)

# 8. Evaluate Model
predictions <- predict(model, df)
cor(predictions, df$Ozone)  # correlation between predicted and actual

# 9. Save Outputs
write.csv(df, "cleaned_airquality_data.csv", row.names = FALSE)
saveRDS(model, "airquality_model.rds")

# Print message
cat("Analysis complete! Cleaned data and model saved successfully.\n")
