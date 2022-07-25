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


#2010Revenue

#Open database

REVENUE2010 <- readRDS(“C:/Users/tatis/Dropbox (ASU)/0000. Invest in Open Infrastructure/Databases NODC/Revenue 2010-2019/REVENUE2010.rds”)

#View database
View (REVENUE2010)

# filter cases
FRevenue2010 = filter(REVENUE2010, ORG_EIN == "941156476" | ORG_EIN == "461496217" | ORG_EIN == "043502255" | ORG_EIN == "453588477" | ORG_EIN == "260389639" | ORG_EIN == "452677817" | ORG_EIN == "522065453" | ORG_EIN == "461599252" | ORG_EIN == "133857105" | ORG_EIN == "231365979" | ORG_EIN == "454547709" | ORG_EIN == "275142743" | ORG_EIN == "680492065" | ORG_EIN == "461685419" | ORG_EIN == "463871312" | ORG_EIN == "843111259" | ORG_EIN == "814921243" | ORG_EIN == "521447747" | ORG_EIN == "814396672")

# save database in a folder in RDS format
# saveRDS(FRevenue2010, file = "FRevenue2010.rds")

#save database in a folder in CSV format
write.table(FRevenue2010, file = "FRevenue2010.csv", sep=",")

# delete rm(Revenue2010)

#syntax ends
