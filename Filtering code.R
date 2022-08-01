####
#install 'R Markdown' use to generate high quality reports that can be shared with an audience
install.packages( "rmarkdown" )

#install 'knitr' use for dynamic report generation with R
install.packages( "knitr" )

#install 'dplyr' that is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges
install.packages ("dplyr")

# install 'pander' to provide a minimal and easy tool for rendering R objects into Pandoc's markdown. The package is also capable of exporting/converting complex Pandoc documents (reports) in various ways.
install.packages ('pander')

#
install.packages ('markdown' )

#
install.packages ('mime')

#
install.packages ('Lahman')

#
install.packages ('tidyverse')


# call libraries
library (dplyr)
library (tidyverse)

#SYNTAX FOR REVENUE FILES 2010-2019

#Syntax starts for Revenue 2010

#Open database

REVENUE2010 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2010.rds")

#View database
View (REVENUE2010)

# filter cases
FRevenue2010 = filter(REVENUE2010, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2010[is.na(FRevenue2010)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2010, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2010.csv", row.names = FALSE)

# delete rm(Revenue2010)
rm(REVENUE2010)
rm(FRevenue2010)
#Syntax ends for Revenue 2010

###############

#Syntax starts for Revenue 2011

#Open database

REVENUE2011 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2011.rds")

#View database
View (REVENUE2011)

# filter cases
FRevenue2011 = filter(REVENUE2011, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2011[is.na(FRevenue2011)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2011, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2011.csv", row.names = FALSE)

# delete rm(Revenue2011)
rm(REVENUE2011)
rm(FRevenue2011)

#Syntax ends for Revenue 2011

###########

#Syntax starts for Revenue 2012

#Open database

REVENUE2012 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2012.rds")

#View database
View (REVENUE2012)

# filter cases
FRevenue2012 = filter(REVENUE2012, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2012[is.na(FRevenue2012)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2012, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2012.csv", row.names = FALSE)

# delete rm(Revenue2012)
rm(REVENUE2012)
rm(FRevenue2012)

#Syntax ends for Revenue 2012

###############

#Syntax starts for Revenue 2013

#Open database

REVENUE2013 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2013.rds")

#View database
View (REVENUE2013)

# filter cases
FRevenue2013 = filter(REVENUE2013, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2013[is.na(FRevenue2013)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2013, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2013.csv", row.names = FALSE)


# delete rm(Revenue2013)
rm(REVENUE2013)
rm(FRevenue2013)

#Syntax ends for Revenue 2013

###############
#Syntax starts for Revenue 2014

#Open database

REVENUE2014 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2014.rds")

#View database
View (REVENUE2014)

# filter cases
FRevenue2014 = filter(REVENUE2014, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2014[is.na(FRevenue2014)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2014, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2014.csv", row.names = FALSE)


# delete rm(Revenue2014)
rm(REVENUE2014)
rm(FRevenue2014)

#Syntax ends for Revenue 2014

###############
#Syntax starts for Revenue 2015

#Open database

REVENUE2015 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2015.rds")

#View database
View (REVENUE2015)

# filter cases
FRevenue2015 = filter(REVENUE2015, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2015[is.na(FRevenue2015)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2015, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2015.csv", row.names = FALSE)


# delete rm(Revenue2015)
rm(REVENUE2015)
rm(FRevenue2015)

#Syntax ends for Revenue 2015

###############
#Syntax starts for Revenue 2016

#Open database

REVENUE2016 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2016.rds")

#View database
View (REVENUE2016)

# filter cases
FRevenue2016 = filter(REVENUE2016, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2016[is.na(FRevenue2016)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2016, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2016.csv", row.names = FALSE)


# delete rm(Revenue2016)
rm(REVENUE2016)
rm(FRevenue2016)

#Syntax ends for Revenue 2016

###############
#Syntax starts for Revenue 2017

#Open database

REVENUE2017 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2017.rds")

#View database
View (REVENUE2017)

# filter cases
FRevenue2017 = filter(REVENUE2017, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2017[is.na(FRevenue2017)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2017, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2017.csv", row.names = FALSE)

# delete rm(Revenue2017)
rm(REVENUE2017)
rm(FRevenue2017)

#Syntax ends for Revenue 2017

###############

#Syntax starts for Revenue 2018

#Open database

REVENUE2018 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2018.rds")

#View database
View (REVENUE2018)

# filter cases
FRevenue2018 = filter(REVENUE2018, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2018[is.na(FRevenue2018)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2018, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2018.csv", row.names = FALSE)

# delete rm(Revenue2018)
rm(REVENUE2018)
rm(FRevenue2018)

#Syntax ends for Revenue 2018

###############
#Syntax starts for Revenue 2019

#Open database

REVENUE2019 <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2019.rds")

#View database
View (REVENUE2019)

# filter cases
FRevenue2019 = filter(REVENUE2019, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
FRevenue2019[is.na(FRevenue2019)] = 0

#save database in a folder in CSV format
write.csv(FRevenue2019, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FRevenue2019.csv", row.names = FALSE)


# delete rm(Revenue2019)
rm(REVENUE2019)
rm(FRevenue2019)

#Syntax ends for Revenue 2019

###############

#SYNTAX FOR EXPENSES FILES 2010-2019 STARTS

#Syntax starts for Expenses 2010

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2010.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2010.csv", row.names = FALSE)

# delete rm(dataold and data)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2010

################

#Syntax starts for Expenses 2011

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2011.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2011.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2011

###############

#Syntax starts for Expenses 2012

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2012.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2012.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2012

################
#Syntax starts for Expenses 2013

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2013.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2013.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2013

################

#Syntax starts for Expenses 2014

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2014.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2014.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2014

################

#Syntax starts for Expenses 2015

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2015.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2015.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2015

################

#Syntax starts for Expenses 2016

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2016.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2016.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2016

################

#Syntax starts for Expenses 2017

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2017.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2017.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2017

################

#Syntax starts for Expenses 2018

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2018.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2018.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2018

################
#Syntax starts for Expenses 2019

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Expenses 2010-2019/EXPENSES2019.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FExpenses2019.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Expenses 2019

################

#SYNTAX FOR BALANCE SHEET 2010-2019 STARTS

#Syntax starts for Balance Sheet 2010

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2010.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2010.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2010

################

#Syntax starts for Balance Sheet 2011

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2011.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2011.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2011

################

#Syntax starts for Balance Sheet 2012

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2012.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2012.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2012

################

#Syntax starts for Balance Sheet 2013

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2013.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2013.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2013

################

#Syntax starts for Balance Sheet 2014

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2014.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2014.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2014

################

#Syntax starts for Balance Sheet 2015

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2015.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2015.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2015

################

#Syntax starts for Balance Sheet 2016

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2016.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2016.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2016

################

#Syntax starts for Balance Sheet 2017

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2017.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2017.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2017

################

#Syntax starts for Balance Sheet 2018

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2018.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2018.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2018

################

#Syntax starts for Balance Sheet 2019

#Open database

dataold <- readRDS("C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Balance Sheet 2010-2019/BALANCESHEET2019.rds")

# filter cases
data = filter(dataold, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# assign NA with 0
data[is.na(data)] = 0

#save database in a folder in CSV format
write.csv(data, "C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/R project/Filtered cases/FBalance2019.csv", row.names = FALSE)

# delete rm(dataold)
rm(dataold)
rm(data)
#Syntax ends for Balance Sheet 2019

################

