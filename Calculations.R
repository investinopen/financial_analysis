#put libraries
library (dplyr)
library (tidyverse)

###SYNTAX FOR 2010 STARTS

##Calculations for year start

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

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2010.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2010.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2010.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2010.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2010.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2010.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT
    
#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2010.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

###SYNTAX FOR 2011 STARTS

##Calculations start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2011.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2011.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2011.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2011.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2011.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2011.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2011.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2011.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)


###SYNTAX FOR 2012 STARTS

##Calculations for year start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2012.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2012.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2012.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2012.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2012.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2012.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2012.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2012.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

###SYNTAX FOR 2013 STARTS

##Calculations for year start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2013.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2013.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2013.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2013.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2013.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2013.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2013.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2013.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

###SYNTAX FOR 2014 STARTS

##Calculations for year start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2014.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2014.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2014.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2014.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2014.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2014.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2014.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2014.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

###SYNTAX FOR 2015 STARTS

##Calculations for year start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2015.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2015.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2015.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2015.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2015.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2015.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2015.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2015.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

###SYNTAX FOR 2016 STARTS

##Calculations for year start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2016.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2016.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2016.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2016.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2016.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2016.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2016.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2016.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

###SYNTAX FOR 2017 STARTS

##Calculations for year start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2017.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2017.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2017.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2017.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2017.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2017.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2017.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2017.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

###SYNTAX FOR 2018 STARTS

##Calculations for year start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2018.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2018.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2018.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2018.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2018.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2018.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2018.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2018.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

###SYNTAX FOR 2019 STARTS

##Calculations for year start

#a)Revenue calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2019.csv")

#Create contributions revenue 
data$revcont <- data$F9_08_REV_CONTR_FED_CAMP + data$F9_08_REV_CONTR_MEMBSHIP_DUE + data$F9_08_REV_CONTR_FUNDR_EVNT + data$F9_08_REV_CONTR_RLTD_ORG + data$F9_08_REV_CONTR_OTH

#Create investment revenue
data$revinvest <- data$F9_08_REV_OTH_INVEST_INCOME_TOT + data$F9_08_REV_OTH_INVEST_BOND_TOT + data$F9_08_REV_OTH_RENT_NET_TOT + data$F9_08_REV_OTH_SALE_GAIN_NET_TOT

#Create Revenue from Special Events
data$revse <- data$F9_08_REV_OTH_FUNDR_NET_TOT + data$F9_08_REV_OTH_GAMING_NET_TOT

#Create Other revenue
data$revother <-data$F9_08_REV_OTH_ROY_TOT + data$F9_08_REV_MISC_TOT_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2019.csv", row.names = FALSE)

#Delete data
rm(data)

#b)Expenses calculations

#Open data
data <-read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2019.csv")

#Create personnel expenses
data$expper <- data$F9_09_EXP_COMP_DTK_TOT + data$F9_09_EXP_COMP_DSQ_PERS_TOT + data$F9_09_EXP_OTH_SAL_WAGE_TOT + data$F9_09_EXP_PENSION_CONTR_TOT + data$F9_09_EXP_OTH_EMPL_BEN_TOT + data$F9_09_EXP_PAYROLL_TAX_TOT

#Save data
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2019.csv", row.names = FALSE)

#Delete data
rm(data)

##Creation of variables ends

##Preparation for ratio calculations start

#Create a dataset with all variables for year
library(tidyverse)

#Put together all inputs for analysis
data1 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CRevenue2019.csv") 
data2 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with calculations/CExpenses2019.csv")
data3 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2019.csv")

#Select variables/items of interest in each dataset
data1a <- data1[,c("RETURN_VERSION", "ORG_EIN", "ORG_NAME_L1", "RETURN_TYPE", "TAX_YEAR", "revcont", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "F9_08_REV_OTH_INV_NET_TOT", "revother", "F9_08_REV_TOT_TOT")]
data2a <- data2[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_FUNDR", "expper", "F9_09_EXP_TOT_TOT")] 
data3a <- data3[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY")]

#Merge the three datasets with all the variables/items of interest 
df_list <- list(data1a, data2a, data3a) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')


##Calculations for ratios start

# Ratio 1. Days cash on hand
dataall$ratio1 <- dataall$F9_10_ASSET_CASH_EOY/(dataall$F9_09_EXP_TOT_TOT/365)

# Ratio 2. Leverage ratio
dataall$ratio2 <-dataall$F9_10_LIAB_TOT_EOY/dataall$F9_10_ASSET_TOT_EOY

# Ratio 3. Reliance on a revenue source ratio 
dataall$largestrev <- pmax(dataall$revcont, dataall$F9_08_REV_CONTR_GOVT_GRANT, dataall$F9_08_REV_PROG_TOT_TOT, dataall$revinvest, dataall$revse, dataall$F9_08_REV_OTH_INV_NET_TOT, dataall$revother)
dataall$ratio3 <-dataall$largestrev/dataall$F9_08_REV_TOT_TOT 

# Ratio 4. Government reliance ratio
dataall$ratio4 <-dataall$F9_08_REV_CONTR_GOVT_GRANT/dataall$F9_08_REV_TOT_TOT 

# Ratio 5. Contributions reliance ratio
dataall$ratio5 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT 

# Ratio 6. Programme service revenue reliance  
dataall$ratio6 <-dataall$F9_08_REV_PROG_TOT_TOT/dataall$F9_08_REV_TOT_TOT

# Ratio 7. Programme expense ratio 
dataall$ratio7 <-dataall$F9_09_EXP_TOT_PROG/dataall$F9_09_EXP_TOT_TOT

# Ratio 8. Administrative expense ratio
dataall$ratio8 <-dataall$F9_09_EXP_TOT_MGMT/dataall$F9_09_EXP_TOT_TOT

# Ratio 9. Fundraising expense ratio
dataall$ratio9 <-dataall$F9_09_EXP_TOT_FUNDR/dataall$F9_09_EXP_TOT_TOT

# Ratio 10. Personnel expense ratio  
dataall$ratio10 <-dataall$revcont/dataall$F9_08_REV_TOT_TOT

#save table
write.csv(dataall,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2019.csv", row.names = FALSE)

#delete data
rm(dataall)
rm(data1)
rm(data2)
rm(data3)
rm(data1a)
rm(data2a)
rm(data3a)
rm(df_list)

#### Calculations ends 
###
#creating databases per organization

#open databases per year
data2010 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2010.csv") 
data2011 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2011.csv") 
data2012 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2012.csv") 
data2013 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2013.csv") 
data2014 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2014.csv") 
data2015 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2015.csv") 
data2016 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2016.csv") 
data2017 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2017.csv") 
data2018 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2018.csv") 
data2019 <- read.csv("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets with ratios/Data2019.csv") 

#separate elements per organization
dataorg_2010 <- data2010[data2010$ORG_EIN == '941156476',]
dataorg_2011 <- data2011[data2011$ORG_EIN == '941156476',]
dataorg_2012 <- data2012[data2012$ORG_EIN == '941156476',]
dataorg_2013 <- data2013[data2013$ORG_EIN == '941156476',]
dataorg_2014 <- data2014[data2014$ORG_EIN == '941156476',]
dataorg_2015 <- data2015[data2015$ORG_EIN == '941156476',]
dataorg_2016 <- data2016[data2016$ORG_EIN == '941156476',]
dataorg_2017 <- data2017[data2017$ORG_EIN == '941156476',]
dataorg_2018 <- data2018[data2018$ORG_EIN == '941156476',]
dataorg_2019 <- data2019[data2019$ORG_EIN == '941156476',]

#merge the 10 rows per each year in a single dataset: https://r-lang.com/rbind-in-r/#:~:text=To%20merge%20two%20data%20frames,()%20stands%20for%20row%20binding. 
combinedDf <- rbind(dataorg_2010, dataorg_2011, dataorg_2012, dataorg_2013, dataorg_2014, dataorg_2015, dataorg_2016, dataorg_2017, dataorg_2018, dataorg_2019)

#save table
write.csv(combinedDf,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per organization/941156476.csv", row.names = FALSE)

#Transpose the table, #note the number 5 is for the column 5"year" that serves as a header
data_t <- setNames(data.frame(t(combinedDf[ , - 5])), combinedDf[ , 5])

#save transposed table NOTE, ROW NAMES CHANGED TO TRUE!!!!
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per organization transposed/941156476.csv", row.names = TRUE)
