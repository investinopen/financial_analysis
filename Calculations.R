#put libraries
library (dplyr)
library (tidyverse)

FRevenue2010 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Try1/FRevenue2010.rds")
data <- FRevenue2010

#Transforming variables to numeric.

data$F9_08_REV_CONTR_FED_CAMP <- as.numeric(as.character(data$F9_08_REV_CONTR_FED_CAMP))
#If NA = 0

data$F9_08_REV_CONTR_MEMBSHIP_DUE <- as.numeric(as.character(data$F9_08_REV_CONTR_MEMBSHIP_DUE))

data$F9_08_REV_CONTR_FUNDR_EVNT <- as.numeric(as.character(data$F9_08_REV_CONTR_FUNDR_EVNT))

data$F9_08_REV_CONTR_RLTD_ORG <- as.numeric(as.character(data$F9_08_REV_CONTR_RLTD_ORG))

data$F9_08_REV_CONTR_OTH <- as.numeric(as.character(data$F9_08_REV_CONTR_OTH))

#data <-mutate(data,contrtotal= F9_08_REV_CONTR_FED_CAMP + F9_08_REV_CONTR_MEMBSHIP_DUE + F9_08_REV_CONTR_FUNDR_EVNT + F9_08_REV_CONTR_RLTD_ORG + F9_08_REV_CONTR_OTH)

#create a new column
data$contrtotal <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#NA cases???
#data$contrtotal <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH
#NA = 0
#If NA, = 0