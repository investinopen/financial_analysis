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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT
    
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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
dataall$ratio10 <-dataall$expper/dataall$F9_08_REV_TOT_TOT

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
###

#######Creating databases per ratio

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

library (tidyverse)

# Ratio 1. Days cash on hand
ratio2010 <- data2010[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2010 <- ratio2010%>% 
  rename (
    cash_2010 = F9_10_ASSET_CASH_EOY, 
    expenses_2010 = F9_09_EXP_TOT_TOT, 
    ratio1_2010=ratio1
  )

ratio2011 <- data2011[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2011 <- ratio2011%>% 
  rename (
    cash_2011 = F9_10_ASSET_CASH_EOY, 
    expenses_2011 = F9_09_EXP_TOT_TOT, 
    ratio1_2011=ratio1
  )

ratio2012 <- data2012[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2012 <- ratio2012%>% 
  rename (
    cash_2012 = F9_10_ASSET_CASH_EOY, 
    expenses_2012 = F9_09_EXP_TOT_TOT, 
    ratio1_2012=ratio1
  )

ratio2013 <- data2013[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2013 <- ratio2013%>% 
  rename (
    cash_2013 = F9_10_ASSET_CASH_EOY, 
    expenses_2013 = F9_09_EXP_TOT_TOT, 
    ratio1_2013=ratio1
  )

ratio2014 <- data2014[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2014 <- ratio2014%>% 
  rename (
    cash_2014 = F9_10_ASSET_CASH_EOY, 
    expenses_2014 = F9_09_EXP_TOT_TOT, 
    ratio1_2014=ratio1
  )

ratio2015 <- data2015[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2015 <- ratio2015%>% 
  rename (
    cash_2015 = F9_10_ASSET_CASH_EOY, 
    expenses_2015 = F9_09_EXP_TOT_TOT, 
    ratio1_2015=ratio1
  )

ratio2016 <- data2016[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2016 <- ratio2016%>% 
  rename (
    cash_2016 = F9_10_ASSET_CASH_EOY, 
    expenses_2016 = F9_09_EXP_TOT_TOT, 
    ratio1_2016=ratio1
  )

ratio2017 <- data2017[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2017 <- ratio2017%>% 
  rename (
    cash_2017 = F9_10_ASSET_CASH_EOY, 
    expenses_2017 = F9_09_EXP_TOT_TOT, 
    ratio1_2017=ratio1
  )

ratio2018 <- data2018[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2018 <- ratio2018%>% 
  rename (
    cash_2018 = F9_10_ASSET_CASH_EOY, 
    expenses_2018 = F9_09_EXP_TOT_TOT, 
    ratio1_2018=ratio1
  )

ratio2019 <- data2019[,c("ORG_EIN", "F9_10_ASSET_CASH_EOY", "F9_09_EXP_TOT_TOT", "ratio1")]
ratio2019 <- ratio2019%>% 
  rename (
    cash_2019 = F9_10_ASSET_CASH_EOY, 
    expenses_2019 = F9_09_EXP_TOT_TOT, 
    ratio1_2019=ratio1
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/1.Days_cash.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

#Ratio 2: Leverage ratio
#Select variables/items of interest in each dataset
ratio2010 <- data2010[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2010 <- ratio2010%>% 
  rename (
    assets_2010 = F9_10_ASSET_TOT_EOY, 
    liabilities_2010 = F9_10_LIAB_TOT_EOY, 
    ratio2_2010=ratio2
    )

ratio2011 <- data2011[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2011 <- ratio2011 %>% 
  rename (
    assets_2011 = F9_10_ASSET_TOT_EOY, 
    liabilities_2011 = F9_10_LIAB_TOT_EOY, 
    ratio2_2011=ratio2
  )

ratio2012 <- data2012[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2012 <- ratio2012 %>% 
  rename (
    assets_2012 = F9_10_ASSET_TOT_EOY, 
    liabilities_2012 = F9_10_LIAB_TOT_EOY, 
    ratio2_2012=ratio2
  )

ratio2013 <- data2013[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2013 <- ratio2013 %>% 
  rename (
    assets_2013 = F9_10_ASSET_TOT_EOY, 
    liabilities_2013 = F9_10_LIAB_TOT_EOY, 
    ratio2_2013=ratio2
  )

ratio2014 <- data2014[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2014 <- ratio2014 %>% 
  rename (
    assets_2014 = F9_10_ASSET_TOT_EOY, 
    liabilities_2014 = F9_10_LIAB_TOT_EOY, 
    ratio2_2014=ratio2
  )

ratio2015 <- data2015[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2015 <- ratio2015 %>% 
  rename (
    assets_2015 = F9_10_ASSET_TOT_EOY, 
    liabilities_2015 = F9_10_LIAB_TOT_EOY, 
    ratio2_2015=ratio2
  )

ratio2016 <- data2016[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2016 <- ratio2016 %>% 
  rename (
    assets_2016 = F9_10_ASSET_TOT_EOY, 
    liabilities_2016 = F9_10_LIAB_TOT_EOY, 
    ratio2_2016=ratio2
  )

ratio2017 <- data2017[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2017 <- ratio2017 %>% 
  rename (
    assets_2017 = F9_10_ASSET_TOT_EOY, 
    liabilities_2017 = F9_10_LIAB_TOT_EOY, 
    ratio2_2017=ratio2
  )

ratio2018 <- data2018[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2018 <- ratio2018 %>% 
  rename (
    assets_2018 = F9_10_ASSET_TOT_EOY, 
    liabilities_2018 = F9_10_LIAB_TOT_EOY, 
    ratio2_2018=ratio2
  )

ratio2019 <- data2019[,c("ORG_EIN", "F9_10_ASSET_TOT_EOY", "F9_10_LIAB_TOT_EOY", "ratio2")]
ratio2019 <- ratio2019 %>% 
  rename (
    assets_2019 = F9_10_ASSET_TOT_EOY, 
    liabilities_2019 = F9_10_LIAB_TOT_EOY, 
    ratio2_2019=ratio2
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/2.Leverage_ratio.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

# Ratio 3. Reliance on a revenue source ratio 
ratio2010 <- data2010[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2010 <- ratio2010%>% 
  rename (
    revcont_2010 = revcont,
    revgov_2010 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2010 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2010 = revinvest,
    revse_2010 = revse,
    revinv_2010 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2010 = revother,
    largestrev_2010 = largestrev,
    revtot_2010 = F9_08_REV_TOT_TOT,
    ratio3_2010 = ratio3
  )
    
ratio2011 <- data2011[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2011 <- ratio2011%>% 
  rename (
    revcont_2011 = revcont,
    revgov_2011 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2011 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2011 = revinvest,
    revse_2011 = revse,
    revinv_2011 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2011 = revother,
    largestrev_2011 = largestrev,
    revtot_2011 = F9_08_REV_TOT_TOT,
    ratio3_2011 = ratio3
  )

ratio2012 <- data2012[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2012 <- ratio2012%>% 
  rename (
    revcont_2012 = revcont,
    revgov_2012 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2012 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2012 = revinvest,
    revse_2012 = revse,
    revinv_2012 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2012 = revother,
    largestrev_2012 = largestrev,
    revtot_2012 = F9_08_REV_TOT_TOT,
    ratio3_2012 = ratio3
  )

ratio2013 <- data2013[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2013 <- ratio2013%>% 
  rename (
    revcont_2013 = revcont,
    revgov_2013 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2013 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2013 = revinvest,
    revse_2013 = revse,
    revinv_2013 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2013 = revother,
    largestrev_2013 = largestrev,
    revtot_2013 = F9_08_REV_TOT_TOT,
    ratio3_2013 = ratio3
  )

ratio2014 <- data2014[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2014 <- ratio2014%>% 
  rename (
    revcont_2014 = revcont,
    revgov_2014 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2014 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2014 = revinvest,
    revse_2014 = revse,
    revinv_2014 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2014 = revother,
    largestrev_2014 = largestrev,
    revtot_2014 = F9_08_REV_TOT_TOT,
    ratio3_2014 = ratio3
  )
ratio2015 <- data2015[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2015 <- ratio2015%>% 
  rename (
    revcont_2015 = revcont,
    revgov_2015 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2015 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2015 = revinvest,
    revse_2015 = revse,
    revinv_2015 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2015 = revother,
    largestrev_2015 = largestrev,
    revtot_2015 = F9_08_REV_TOT_TOT,
    ratio3_2015 = ratio3
  )
ratio2016 <- data2016[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2016 <- ratio2016%>% 
  rename (
    revcont_2016 = revcont,
    revgov_2016 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2016 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2016 = revinvest,
    revse_2016 = revse,
    revinv_2016 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2016 = revother,
    largestrev_2016 = largestrev,
    revtot_2016 = F9_08_REV_TOT_TOT,
    ratio3_2016 = ratio3
  )
ratio2017 <- data2017[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2017 <- ratio2017%>% 
  rename (
    revcont_2017 = revcont,
    revgov_2017 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2017 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2017 = revinvest,
    revse_2017 = revse,
    revinv_2017 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2017 = revother,
    largestrev_2017 = largestrev,
    revtot_2017 = F9_08_REV_TOT_TOT,
    ratio3_2017 = ratio3
  )
ratio2018 <- data2018[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2018 <- ratio2018%>% 
  rename (
    revcont_2018 = revcont,
    revgov_2018 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2018 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2018 = revinvest,
    revse_2018 = revse,
    revinv_2018 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2018 = revother,
    largestrev_2018 = largestrev,
    revtot_2018 = F9_08_REV_TOT_TOT,
    ratio3_2018 = ratio3
  )
ratio2019 <- data2019[,c("ORG_EIN", "revcont","F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_PROG_TOT_TOT", "revinvest", "revse", "F9_08_REV_OTH_INV_NET_TOT", "revother", "largestrev","F9_08_REV_TOT_TOT", "ratio3")]
ratio2019 <- ratio2019%>% 
  rename (
    revcont_2019 = revcont,
    revgov_2019 = F9_08_REV_CONTR_GOVT_GRANT,
    revprog_2019 = F9_08_REV_PROG_TOT_TOT,
    revinvest_2019 = revinvest,
    revse_2019 = revse,
    revinv_2019 = F9_08_REV_OTH_INV_NET_TOT,
    revother_2019 = revother,
    largestrev_2019 = largestrev,
    revtot_2019 = F9_08_REV_TOT_TOT,
    ratio3_2019 = ratio3
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/3.Reliance_revenue.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

# Ratio 4. Government reliance ratio
ratio2010 <- data2010[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2010 <- ratio2010%>% 
  rename (
    revgov_2010 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2010 = F9_08_REV_TOT_TOT,
    ratio4_2010 = ratio4
  )

ratio2011 <- data2011[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2011 <- ratio2011%>% 
  rename (
    revgov_2011 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2011 = F9_08_REV_TOT_TOT,
    ratio4_2011 = ratio4
  )

ratio2012 <- data2012[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2012 <- ratio2012%>% 
  rename (
    revgov_2012 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2012 = F9_08_REV_TOT_TOT,
    ratio4_2012 = ratio4
  )

ratio2013 <- data2013[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2013 <- ratio2013%>% 
  rename (
    revgov_2013 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2013 = F9_08_REV_TOT_TOT,
    ratio4_2013 = ratio4
  )

ratio2014 <- data2014[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2014 <- ratio2014%>% 
  rename (
    revgov_2014 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2014 = F9_08_REV_TOT_TOT,
    ratio4_2014 = ratio4
  )

ratio2015 <- data2015[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2015 <- ratio2015%>% 
  rename (
    revgov_2015 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2015 = F9_08_REV_TOT_TOT,
    ratio4_2015 = ratio4
  )

ratio2016 <- data2016[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2016 <- ratio2016%>% 
  rename (
    revgov_2016 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2016 = F9_08_REV_TOT_TOT,
    ratio4_2016 = ratio4
  )

ratio2017 <- data2017[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2017 <- ratio2017%>% 
  rename (
    revgov_2017 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2017 = F9_08_REV_TOT_TOT,
    ratio4_2017 = ratio4
  )

ratio2018 <- data2018[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2018 <- ratio2018%>% 
  rename (
    revgov_2018 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2018 = F9_08_REV_TOT_TOT,
    ratio4_2018 = ratio4
  )
ratio2019 <- data2019[,c("ORG_EIN", "F9_08_REV_CONTR_GOVT_GRANT", "F9_08_REV_TOT_TOT", "ratio4")]
ratio2019 <- ratio2019%>% 
  rename (
    revgov_2019 = F9_08_REV_CONTR_GOVT_GRANT,
    revtot_2019 = F9_08_REV_TOT_TOT,
    ratio4_2019 = ratio4
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/4.Government_reliance.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

# Ratio 5. Contributions reliance ratio
ratio2010 <- data2010[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2010 <- ratio2010%>% 
  rename (
    revcont_2010 = revcont,
    revtot_2010 = F9_08_REV_TOT_TOT,
    ratio5_2010 = ratio5
  )

ratio2011 <- data2011[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2011 <- ratio2011%>% 
  rename (
    revcont_2011 = revcont,
    revtot_2011 = F9_08_REV_TOT_TOT,
    ratio5_2011 = ratio5
  )

ratio2012 <- data2012[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2012 <- ratio2012%>% 
  rename (
    revcont_2012 = revcont,
    revtot_2012 = F9_08_REV_TOT_TOT,
    ratio5_2012 = ratio5
  )

ratio2013 <- data2013[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2013 <- ratio2013%>% 
  rename (
    revcont_2013 = revcont,
    revtot_2013 = F9_08_REV_TOT_TOT,
    ratio5_2013 = ratio5
  )

ratio2014 <- data2014[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2014 <- ratio2014%>% 
  rename (
    revcont_2014 = revcont,
    revtot_2014 = F9_08_REV_TOT_TOT,
    ratio5_2014 = ratio5
  )

ratio2015 <- data2015[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2015 <- ratio2015%>% 
  rename (
    revcont_2015 = revcont,
    revtot_2015 = F9_08_REV_TOT_TOT,
    ratio5_2015 = ratio5
  )

ratio2016 <- data2016[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2016 <- ratio2016%>% 
  rename (
    revcont_2016 = revcont,
    revtot_2016 = F9_08_REV_TOT_TOT,
    ratio5_2016 = ratio5
  )

ratio2017 <- data2017[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2017 <- ratio2017%>% 
  rename (
    revcont_2017 = revcont,
    revtot_2017 = F9_08_REV_TOT_TOT,
    ratio5_2017 = ratio5
  )

ratio2018 <- data2018[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2018 <- ratio2018%>% 
  rename (
    revcont_2018 = revcont,
    revtot_2018 = F9_08_REV_TOT_TOT,
    ratio5_2018 = ratio5
  )

ratio2019 <- data2019[,c("ORG_EIN", "revcont", "F9_08_REV_TOT_TOT", "ratio5")]
ratio2019 <- ratio2019%>% 
  rename (
    revcont_2019 = revcont,
    revtot_2019 = F9_08_REV_TOT_TOT,
    ratio5_2019 = ratio5
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/5.Contributions_reliance.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

# Ratio 6. Programme service revenue reliance  
ratio2010 <- data2010[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2010 <- ratio2010%>% 
  rename (
    revprog_2010 = F9_08_REV_PROG_TOT_TOT,
    revtot_2010 = F9_08_REV_TOT_TOT,
    ratio6_2010 = ratio6
  )

ratio2011 <- data2011[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2011 <- ratio2011%>% 
  rename (
    revprog_2011 = F9_08_REV_PROG_TOT_TOT,
    revtot_2011 = F9_08_REV_TOT_TOT,
    ratio6_2011 = ratio6
  )

ratio2012 <- data2012[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2012 <- ratio2012%>% 
  rename (
    revprog_2012 = F9_08_REV_PROG_TOT_TOT,
    revtot_2012 = F9_08_REV_TOT_TOT,
    ratio6_2012 = ratio6
  )

ratio2013 <- data2013[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2013 <- ratio2013%>% 
  rename (
    revprog_2013 = F9_08_REV_PROG_TOT_TOT,
    revtot_2013 = F9_08_REV_TOT_TOT,
    ratio6_2013 = ratio6
  )

ratio2014 <- data2014[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2014 <- ratio2014%>% 
  rename (
    revprog_2014 = F9_08_REV_PROG_TOT_TOT,
    revtot_2014 = F9_08_REV_TOT_TOT,
    ratio6_2014 = ratio6
  )

ratio2015 <- data2015[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2015 <- ratio2015%>% 
  rename (
    revprog_2015 = F9_08_REV_PROG_TOT_TOT,
    revtot_2015 = F9_08_REV_TOT_TOT,
    ratio6_2015 = ratio6
  )

ratio2016 <- data2016[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2016 <- ratio2016%>% 
  rename (
    revprog_2016 = F9_08_REV_PROG_TOT_TOT,
    revtot_2016 = F9_08_REV_TOT_TOT,
    ratio6_2016 = ratio6
  )

ratio2017 <- data2017[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2017 <- ratio2017%>% 
  rename (
    revprog_2017 = F9_08_REV_PROG_TOT_TOT,
    revtot_2017 = F9_08_REV_TOT_TOT,
    ratio6_2017 = ratio6
  )

ratio2018 <- data2018[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2018 <- ratio2018%>% 
  rename (
    revprog_2018 = F9_08_REV_PROG_TOT_TOT,
    revtot_2018 = F9_08_REV_TOT_TOT,
    ratio6_2018 = ratio6
  )

ratio2019 <- data2019[,c("ORG_EIN", "F9_08_REV_PROG_TOT_TOT", "F9_08_REV_TOT_TOT", "ratio6")]
ratio2019 <- ratio2019%>% 
  rename (
    revprog_2019 = F9_08_REV_PROG_TOT_TOT,
    revtot_2019 = F9_08_REV_TOT_TOT,
    ratio6_2019 = ratio6
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/6.Programme_reliance.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

# Ratio 7. Programme expense ratio 
ratio2010 <- data2010[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2010 <- ratio2010%>% 
  rename (
    expprog_2010 = F9_09_EXP_TOT_PROG,
    exptot_2010 = F9_09_EXP_TOT_TOT,
    ratio7_2010 = ratio7
  )
ratio2011 <- data2011[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2011 <- ratio2011%>% 
  rename (
    expprog_2011 = F9_09_EXP_TOT_PROG,
    exptot_2011 = F9_09_EXP_TOT_TOT,
    ratio7_2011 = ratio7
  )
ratio2012 <- data2012[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2012 <- ratio2012%>% 
  rename (
    expprog_2012 = F9_09_EXP_TOT_PROG,
    exptot_2012 = F9_09_EXP_TOT_TOT,
    ratio7_2012 = ratio7
  )
ratio2013 <- data2013[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2013 <- ratio2013%>% 
  rename (
    expprog_2013 = F9_09_EXP_TOT_PROG,
    exptot_2013 = F9_09_EXP_TOT_TOT,
    ratio7_2013 = ratio7
  )
ratio2014 <- data2014[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2014 <- ratio2014%>% 
  rename (
    expprog_2014 = F9_09_EXP_TOT_PROG,
    exptot_2014 = F9_09_EXP_TOT_TOT,
    ratio7_2014 = ratio7
  )
ratio2015 <- data2015[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2015 <- ratio2015%>% 
  rename (
    expprog_2015 = F9_09_EXP_TOT_PROG,
    exptot_2015 = F9_09_EXP_TOT_TOT,
    ratio7_2015 = ratio7
  )
ratio2016 <- data2016[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2016 <- ratio2016%>% 
  rename (
    expprog_2016 = F9_09_EXP_TOT_PROG,
    exptot_2016 = F9_09_EXP_TOT_TOT,
    ratio7_2016 = ratio7
  )
ratio2017 <- data2017[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2017 <- ratio2017%>% 
  rename (
    expprog_2017 = F9_09_EXP_TOT_PROG,
    exptot_2017 = F9_09_EXP_TOT_TOT,
    ratio7_2017 = ratio7
  )
ratio2018 <- data2018[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2018 <- ratio2018%>% 
  rename (
    expprog_2018 = F9_09_EXP_TOT_PROG,
    exptot_2018 = F9_09_EXP_TOT_TOT,
    ratio7_2018 = ratio7
  )
ratio2019 <- data2019[,c("ORG_EIN", "F9_09_EXP_TOT_PROG", "F9_09_EXP_TOT_TOT", "ratio7")]
ratio2019 <- ratio2019%>% 
  rename (
    expprog_2019 = F9_09_EXP_TOT_PROG,
    exptot_2019 = F9_09_EXP_TOT_TOT,
    ratio7_2019 = ratio7
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/7.Programme_expense.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

# Ratio 8. Administrative expense ratio
ratio2010 <- data2010[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2010 <- ratio2010%>% 
  rename (
    expmgmt_2010 = F9_09_EXP_TOT_MGMT,
    exptot_2010 = F9_09_EXP_TOT_TOT,
    ratio8_2010 = ratio8
  )
ratio2011 <- data2011[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2011 <- ratio2011%>% 
  rename (
    expmgmt_2011 = F9_09_EXP_TOT_MGMT,
    exptot_2011 = F9_09_EXP_TOT_TOT,
    ratio8_2011 = ratio8
  )
ratio2012 <- data2012[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2012 <- ratio2012%>% 
  rename (
    expmgmt_2012 = F9_09_EXP_TOT_MGMT,
    exptot_2012 = F9_09_EXP_TOT_TOT,
    ratio8_2012 = ratio8
  )
ratio2013 <- data2013[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2013 <- ratio2013%>% 
  rename (
    expmgmt_2013 = F9_09_EXP_TOT_MGMT,
    exptot_2013 = F9_09_EXP_TOT_TOT,
    ratio8_2013 = ratio8
  )
ratio2014 <- data2014[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2014 <- ratio2014%>% 
  rename (
    expmgmt_2014 = F9_09_EXP_TOT_MGMT,
    exptot_2014 = F9_09_EXP_TOT_TOT,
    ratio8_2014 = ratio8
  )
ratio2015 <- data2015[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2015 <- ratio2015%>% 
  rename (
    expmgmt_2015 = F9_09_EXP_TOT_MGMT,
    exptot_2015 = F9_09_EXP_TOT_TOT,
    ratio8_2015 = ratio8
  )
ratio2016 <- data2016[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2016 <- ratio2016%>% 
  rename (
    expmgmt_2016 = F9_09_EXP_TOT_MGMT,
    exptot_2016 = F9_09_EXP_TOT_TOT,
    ratio8_2016 = ratio8
  )
ratio2017 <- data2017[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2017 <- ratio2017%>% 
  rename (
    expmgmt_2017 = F9_09_EXP_TOT_MGMT,
    exptot_2017 = F9_09_EXP_TOT_TOT,
    ratio8_2017 = ratio8
  )
ratio2018 <- data2018[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2018 <- ratio2018%>% 
  rename (
    expmgmt_2018 = F9_09_EXP_TOT_MGMT,
    exptot_2018 = F9_09_EXP_TOT_TOT,
    ratio8_2018 = ratio8
  )
ratio2019 <- data2019[,c("ORG_EIN", "F9_09_EXP_TOT_MGMT", "F9_09_EXP_TOT_TOT", "ratio8")]
ratio2019 <- ratio2019%>% 
  rename (
    expmgmt_2019 = F9_09_EXP_TOT_MGMT,
    exptot_2019 = F9_09_EXP_TOT_TOT,
    ratio8_2019 = ratio8
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/8.Administrative_expense.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

# Ratio 9. Fundraising expense ratio
ratio2010 <- data2010[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2010 <- ratio2010%>% 
  rename (
    expfunr_2010 = F9_09_EXP_TOT_FUNDR,
    exptot_2010 = F9_09_EXP_TOT_TOT,
    ratio7_2010 = ratio9
  )

ratio2011 <- data2011[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2011 <- ratio2011%>% 
  rename (
    expfunr_2011 = F9_09_EXP_TOT_FUNDR,
    exptot_2011 = F9_09_EXP_TOT_TOT,
    ratio7_2011 = ratio9
  )

ratio2012 <- data2012[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2012 <- ratio2012%>% 
  rename (
    expfunr_2012 = F9_09_EXP_TOT_FUNDR,
    exptot_2012 = F9_09_EXP_TOT_TOT,
    ratio7_2012 = ratio9
  )

ratio2013 <- data2013[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2013 <- ratio2013%>% 
  rename (
    expfunr_2013 = F9_09_EXP_TOT_FUNDR,
    exptot_2013 = F9_09_EXP_TOT_TOT,
    ratio7_2013 = ratio9
  )

ratio2014 <- data2014[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2014 <- ratio2014%>% 
  rename (
    expfunr_2014 = F9_09_EXP_TOT_FUNDR,
    exptot_2014 = F9_09_EXP_TOT_TOT,
    ratio7_2014 = ratio9
  )

ratio2015 <- data2015[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2015 <- ratio2015%>% 
  rename (
    expfunr_2015 = F9_09_EXP_TOT_FUNDR,
    exptot_2015 = F9_09_EXP_TOT_TOT,
    ratio7_2015 = ratio9
  )

ratio2016 <- data2016[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2016 <- ratio2016%>% 
  rename (
    expfunr_2016 = F9_09_EXP_TOT_FUNDR,
    exptot_2016 = F9_09_EXP_TOT_TOT,
    ratio7_2016 = ratio9
  )

ratio2017 <- data2017[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2017 <- ratio2017%>% 
  rename (
    expfunr_2017 = F9_09_EXP_TOT_FUNDR,
    exptot_2017 = F9_09_EXP_TOT_TOT,
    ratio7_2017 = ratio9
  )

ratio2018 <- data2018[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2018 <- ratio2018%>% 
  rename (
    expfunr_2018 = F9_09_EXP_TOT_FUNDR,
    exptot_2018 = F9_09_EXP_TOT_TOT,
    ratio7_2018 = ratio9
  )

ratio2019 <- data2019[,c("ORG_EIN", "F9_09_EXP_TOT_FUNDR", "F9_09_EXP_TOT_TOT", "ratio9")]
ratio2019 <- ratio2019%>% 
  rename (
    expfunr_2019 = F9_09_EXP_TOT_FUNDR,
    exptot_2019 = F9_09_EXP_TOT_TOT,
    ratio7_2019 = ratio9
  )

#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/9.Fundraising_expense.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)

# Ratio 10. Personnel expense ratio  
ratio2010 <- data2010[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2010 <- ratio2010%>% 
  rename (
    expper_2010 = expper,
    revtot_2010 = F9_08_REV_TOT_TOT,
    ratio10_2010 = ratio10
  )

ratio2011 <- data2011[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2011 <- ratio2011%>% 
  rename (
    expper_2011 = expper,
    revtot_2011 = F9_08_REV_TOT_TOT,
    ratio10_2011 = ratio10
  )

ratio2012 <- data2012[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2012 <- ratio2012%>% 
  rename (
    expper_2012 = expper,
    revtot_2012 = F9_08_REV_TOT_TOT,
    ratio10_2012 = ratio10
  )

ratio2013 <- data2013[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2013 <- ratio2013%>% 
  rename (
    expper_2013 = expper,
    revtot_2013 = F9_08_REV_TOT_TOT,
    ratio10_2013 = ratio10
  )

ratio2014 <- data2014[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2014 <- ratio2014%>% 
  rename (
    expper_2014 = expper,
    revtot_2014 = F9_08_REV_TOT_TOT,
    ratio10_2014 = ratio10
  )

ratio2015 <- data2015[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2015 <- ratio2015%>% 
  rename (
    expper_2015 = expper,
    revtot_2015 = F9_08_REV_TOT_TOT,
    ratio10_2015 = ratio10
  )

ratio2016 <- data2016[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2016 <- ratio2016%>% 
  rename (
    expper_2016 = expper,
    revtot_2016 = F9_08_REV_TOT_TOT,
    ratio10_2016 = ratio10
  )

ratio2017 <- data2017[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2017 <- ratio2017%>% 
  rename (
    expper_2017 = expper,
    revtot_2017 = F9_08_REV_TOT_TOT,
    ratio10_2017 = ratio10
  )

ratio2018 <- data2018[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2018 <- ratio2018%>% 
  rename (
    expper_2018 = expper,
    revtot_2018 = F9_08_REV_TOT_TOT,
    ratio10_2018 = ratio10
  )

ratio2019 <- data2019[,c("ORG_EIN", "expper", "F9_08_REV_TOT_TOT", "ratio10")]
ratio2019 <- ratio2019%>% 
  rename (
    expper_2019 = expper,
    revtot_2019 = F9_08_REV_TOT_TOT,
    ratio10_2019 = ratio10
  )


#Merge the 10 datasets with all the variables/items of interest 
df_list <- list(ratio2010, ratio2011, ratio2012, ratio2013, ratio2014, ratio2015, ratio2016, ratio2017, ratio2018, ratio2019) 
dataall <- df_list %>% reduce(full_join, by='ORG_EIN')
data_t <- setNames(data.frame(t(dataall[ , - 1])), dataall[ , 1])
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per ratio/10.Personnel_expense.csv", row.names = TRUE)

#Delete databases no longer in use
rm(df_list)
rm(dataall)
rm(data_t)
rm(ratio2010)
rm(ratio2011)
rm(ratio2012)
rm(ratio2013)
rm(ratio2014)
rm(ratio2015)
rm(ratio2016)
rm(ratio2017)
rm(ratio2018)
rm(ratio2019)



########################################

###creating databases per organization (Note I am still working on this!!!)

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

# #separate elements per organization
# dataorg_2010 <- 
# dataorg_2011 <- 
# dataorg_2012 <- 
# dataorg_2013 <- 
# dataorg_2014 <- 
# dataorg_2015 <- 
# dataorg_2016 <- 
# dataorg_2017 <- 
# dataorg_2018 <- 
# dataorg_2019 <- 

# #merge the 10 rows per each year in a single dataset: https://r-lang.com/rbind-in-r/#:~:text=To%20merge%20two%20data%20frames,()%20stands%20for%20row%20binding. 
# combinedDf <- rbind(dataorg_2010, dataorg_2011, dataorg_2012, dataorg_2013, dataorg_2014, dataorg_2015, dataorg_2016, dataorg_2017, dataorg_2018, dataorg_2019)

# do this with a for loop (https://www.geeksforgeeks.org/for-loop-in-r/)
# You'll need to:
# + create a list of EINs
# + for loop to go through the list using a variable temporarily holding the EIN value
# + pass the EIN variable to the filename as well as the ORG_EIN filters

#merge
combinedDf <- rbind(data2010[data2010$ORG_EIN == '941156476',],data2011[data2011$ORG_EIN == '941156476',],data2012[data2012$ORG_EIN == '941156476',],data2013[data2013$ORG_EIN == '941156476',],data2014[data2014$ORG_EIN == '941156476',],data2015[data2015$ORG_EIN == '941156476',],data2016[data2016$ORG_EIN == '941156476',],data2017[data2017$ORG_EIN == '941156476',],data2018[data2018$ORG_EIN == '941156476',],data2019[data2019$ORG_EIN == '941156476',]


#save table
write.csv(combinedDf,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per organization/941156476.csv", row.names = FALSE)

#Transpose the table, #note the number 5 is for the column 5"year" that serves as a header
data_t <- setNames(data.frame(t(combinedDf[ , - 5])), combinedDf[ , 5])

#save transposed table NOTE, ROW NAMES CHANGED TO TRUE!!!!
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per organization transposed/941156476.csv", row.names = TRUE)


# pivot form for the database
subset <- select(combinedDf, ORG_EIN, TAX_YEAR,ratio1, ratio2, ratio3, ratio4, ratio5, ratio6, ratio7, ratio8, ratio9, ratio10)
database_form <- subset %>% 
     tidyr::pivot_longer(cols = starts_with("ratio"), 
         names_to = "Measure", 
         values_to = "Value", 
         names_prefix = "ratio_")
#### Check last line
write.csv(data_t,"C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Datasets per organization transposed/database_form.csv", row.names = TRUE)
