#put libraries
library (dplyr)
library (tidyverse)

###Calculations 2010

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2010.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2010.csv", row.names = FALSE)

#delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2010.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2010.csv", row.names = FALSE)

#delete data
rm(data)

#ends creation of variables

#create a dataset with all variables per year

library(tidyverse)

#2010 inputs for the analysis together
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2010.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2010.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2010.csv")

#only select the varaibles of interest in each dataset
data1a <- data1[,c("ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#merging the three datasets
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


#calculations for ratios

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio WORKED!
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio WORKED! 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio WORKED!
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio WORKED!
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance WORKED!  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio WORKED!  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT
    
#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2010.csv", row.names = FALSE)

#delete data
rm(dataall)


