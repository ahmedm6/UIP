library(readxl)
library(tidyverse)
library(reshape2)
library(ggplot2)

USi <- read_excel("DGS10.xlsx",
                  sheet = "FRED Graph",
                  skip = 11,
                  col_names = c("Date", "Rate"))

USiplot <- ggplot(USi, aes(Date, Rate)) +
  geom_line(color = "blue", size = 0.5) +
  ggtitle("US Interest Rates from 1962-2020") +
  theme(plot.title = element_text(hjust = 0.5))

USiplot


JPi <- read_excel("IRLTLT01JPM156N.xls",
                  sheet = "FRED Graph",
                  skip = 11,
                  col_names = c("Date", "Rate"))

JPiplot <- ggplot(JPi, aes(Date, Rate)) +
  geom_line(color = "blue", size = 0.5) +
  ggtitle("Japan Interest Rates from 1962-2020") +
  theme(plot.title = element_text(hjust = 0.5))

JPiplot


FXUSJP <- read_excel("EXJPUS.xls",
                     sheet = "FRED Graph",
                     skip = 11,
                     col_names = c("Date", "FX"))

FXplot <- ggplot(FXUSJP, aes(Date, FX)) +
  geom_line(color = "steelblue", size = 0.5) +
  ggtitle("Japan/US Foreign Exchange Rates from 1971-2020") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylab("JPY per 1 USD") 

FXplot


data <- merge( JPi, USi, by = "Date")
colnames(data)[2:3] <- c("Japan_IR", "US_IR")
data <- merge( data , FXUSJP , by = "Date")

#--------------------------

#plots for part 2, "Description of Data"

USJPIR <- ggplot(data = data, aes(Date))+
  geom_line(aes(y = Japan_IR, color = "Japan IR" ))+
  geom_line(aes(y = US_IR, color="US IR"))+
  labs(colour = "Legend", x = "Year", y = "Interest Rate")+
  theme(legend.position = c(1, 1),legend.justification = c(1, 1))+
  scale_color_manual(values = c("steelblue","darkred")) +
  ggtitle("Japan and US Interest Rates from 1989-2020") +
  theme(plot.title = element_text(hjust = 0.5)) 

USJPIR

FXplot

#-------------------------

# part 3, testing for UIP
 
data$dIR <- data$Japan_IR - data$US_IR # adding R(jpy) - R(usd)



p1 <- ggplot(data, aes(x = Date, y = dIR)) +
  geom_line(color = "blue", size = 0.5) +
  ggtitle("Interest Rate Differential") +
  theme(plot.title = element_text(hjust = 0.5))

p1

data <- data %>%
  mutate(dFX = (lead(FX, 12)/FX - 1) * 100) #adding delta s


p2 <- ggplot(data, aes(dIR, dFX)) +
  geom_point(color = "steelblue") + 
  xlab("Interest Rate Differential") +
  ylab("Change of Foreign Exchange Rate") +
  ggtitle("Interest Rate Differential vs Change of Foreign Exchange Rate") +
  theme(plot.title = element_text(hjust = 0.5))

p2

olsData <- lm(dFX ~ dIR, data)
summary(olsData)

