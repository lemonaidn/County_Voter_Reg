library(tidyverse)
library(readr)



###################################################
# function for preprocessing
# combine 3rd parties into an "other" column
# add a column with reporting date for each file


preprocess = function(x,y)
{
  x['Total_Third_Party'] = x['GRE'] +
    x['LIB'] +
    x['RFP']+
    x['CON']+
    x['NAT']+
    x['CNV']+
    x['SSP']
  
  x['Reporting_Date'] = as.Date(y)
  x = x[,c('County', 'Reporting_Date', 'Total', 'UNA', 'DEM', 'REP',
           'Total_Third_Party', 'GRE', 'LIB', 'RFP', 'CON',
           'NAT', 'CNV', 'SSP')]
  return(x)
}




####################################################
# same function as above, but accounts for a capitalized 'COUNTY' column
# and lowercases it for uniformity with other files


preprocess2 = function(x,y)
{
  x['Total_Third_Party'] = x['GRE'] +
    x['LIB'] +
    x['RFP']+
    x['CON']+
    x['NAT']+
    x['CNV']+
    x['SSP']
  
  x['Reporting_Date'] = as.Date(y)
  x = x[,c('COUNTY', 'Reporting_Date', 'Total', 'UNA', 'DEM', 'REP',
           'Total_Third_Party', 'GRE', 'LIB', 'RFP', 'CON',
           'NAT', 'CNV', 'SSP')]
  
  x = x %>%
    rename(County = COUNTY)
  
  return(x)
}


####################################################
# dec2019


dec2019 = read_csv("2020 Voter Reg by County/tabula-2019-12-voter-registration-by-county.csv")

dec2019 = preprocess(dec2019,'2019-11-30')
dec2019



####################################################
# jan2020


jan2020 = read_csv("2020 Voter Reg by County/tabula-2020-01-voter-registration-by-county.csv")

jan2020 = preprocess(jan2020,'2019-12-31')
jan2020



####################################################
# feb2020


feb2020 = read_csv("2020 Voter Reg by County/tabula-2020-02-voter-registration-by-county.csv")


feb2020 = preprocess2(feb2020,'2020-02-01')
feb2020


####################################################
# mar2020


mar2020 = read_csv("2020 Voter Reg by County/tabula-2020-03-voter-registration-by-county.csv")

mar2020 = preprocess2(mar2020,'2020-03-01')
mar2020


####################################################
# apr2020


apr2020 = read_csv("2020 Voter Reg by County/tabula-2020-04-voter-registration-by-county.csv")


apr2020 = preprocess2(apr2020,'2020-04-01')
apr2020


####################################################
# may2020


may2020 = read_csv("2020 Voter Reg by County/tabula-2020-05-voter-registration-by-county.csv")
may2020 = preprocess2(may2020,'2020-05-01')
may2020


####################################################
# june2020


june2020 = read_csv("2020 Voter Reg by County/tabula-2020-06-voter-registration-by-county.csv")
june2020 = preprocess2(june2020,'2020-06-01')
june2020



####################################################
# july2020


july2020 = read_csv("2020 Voter Reg by County/tabula-2020-07-voter-registration-by-county.csv")
july2020 = preprocess2(july2020,'2020-07-01')
july2020



####################################################
# aug2020


aug2020 = read_csv("2020 Voter Reg by County/tabula-2020-08-voter-registration-by-county.csv")
aug2020 = preprocess2(aug2020,'2020-08-01')
aug2020



####################################################
# sep2020


sep2020 = read_csv("2020 Voter Reg by County/tabula-2020-09-voter-registration-by-county.csv")
sep2020 = preprocess2(sep2020,'2020-09-01')
sep2020



####################################################
# oct2020


oct2020 = read_csv("2020 Voter Reg by County/tabula-2020-10-voter-registration-by-county.csv")
oct2020 = preprocess2(oct2020,'2020-10-01')
oct2020



####################################################
# nov2020


nov2020 = read_csv("2020 Voter Reg by County/tabula-2020-11-voter-registration-by-county.csv")
nov2020 = preprocess2(nov2020,'2020-11-01')
nov2020



####################################################
# dec2020


dec2020 = read_csv("2020 Voter Reg by County/tabula-2020-12-voter-registration-by-county.csv")
dec2020 = preprocess2(dec2020,'2020-12-01')
dec2020



####################################################
#combine monthly dataframes and write to csv


df_2020 = rbind(dec2019,
                jan2020,
                feb2020,
                mar2020,
                apr2020,
                may2020,
                june2020,
                july2020,
                aug2020,
                sep2020,
                oct2020,
                nov2020,
                dec2020)

write.csv(df_2020, 'C:\\Users\\aidan\\Documents\\GitHub\\County_Voter_Reg\\df_2020.csv')
