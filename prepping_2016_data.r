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
# dec2015


dec2015 = read_csv("2016 Voter Reg by County/tabula-2015-12-voter-registration-by-county.csv")
dec2015 = dec2015%>%
  select(-X11)

dec2015 = preprocess(dec2015,'2015-11-30')
dec2015



####################################################
# jan2016


jan2016 = read_csv("2016 Voter Reg by County/tabula-2016-01-voter-registration-by-county.csv")
jan2016 = jan2016%>%
  select(-X11)

jan2016 = preprocess(jan2016,'2015-12-31')
jan2016



####################################################
# feb2016


feb2016 = read_csv("2016 Voter Reg by County/tabula-2016-02-voter-registration-by-county.csv")
feb2016 = feb2016%>%
  select(-X11)

feb2016 = preprocess(feb2016,'2016-01-31')
feb2016


####################################################
# mar2016


mar2016 = read_csv("2016 Voter Reg by County/tabula-2016-03-voter-registration-by-county.csv")
mar2016 = mar2016%>%
  select(-X11)

mar2016 = preprocess(mar2016,'2016-03-02')
mar2016


####################################################
# apr2016


apr2016 = read_csv("2016 Voter Reg by County/tabula-2016-04-voter-registration-by-county.csv")
apr2016 = apr2016%>%
  select(-X11)

apr2016 = preprocess(apr2016,'2016-03-31')
apr2016


####################################################
# may2016


may2016 = read_csv("2016 Voter Reg by County/tabula-2016-05-voter-registration-by-county.csv")
may2016 = preprocess(may2016,'2016-04-30')
may2016


####################################################
# june2016


june2016 = read_csv("2016 Voter Reg by County/tabula-2016-06-voter-registration-by-county.csv")
june2016 = preprocess(june2016,'2016-05-31')
june2016



####################################################
# july2016


july2016 = read_csv("2016 Voter Reg by County/tabula-2016-07-voter-registration-by-county.csv")
july2016 = preprocess(july2016,'2016-06-30')
july2016



####################################################
# aug2016


aug2016 = read_csv("2016 Voter Reg by County/tabula-2016-08-voter-registration-by-county.csv")
aug2016 = preprocess(aug2016,'2016-08-05')
aug2016



####################################################
# sep2016


sep2016 = read_csv("2016 Voter Reg by County/tabula-2016-09-voter-registration-by-county.csv")
sep2016 = preprocess(sep2016,'2016-08-31')
sep2016



####################################################
# oct2016


oct2016 = read_csv("2016 Voter Reg by County/tabula-2016-10-voter-registration-by-county.csv")
oct2016 = preprocess(oct2016,'2016-10-05')
oct2016



####################################################
# nov2016


nov2016 = read_csv("2016 Voter Reg by County/tabula-2016-11-voter-registration-by-county.csv")
nov2016 = preprocess(nov2016,'2016-11-07')
nov2016



####################################################
# dec2016


dec2016 = read_csv("2016 Voter Reg by County/tabula-2016-12-voter-registration-by-county.csv")
dec2016 = preprocess(dec2016,'2016-11-30')
dec2016



####################################################
#combine monthly dataframes and write to csv


df_2016 = rbind(dec2015,
      jan2016,
      feb2016,
      mar2016,
      apr2016,
      may2016,
      june2016,
      july2016,
      aug2016,
      sep2016,
      oct2016,
      nov2016,
      dec2016)

write.csv(df_2016, 'C:\\Users\\aidan\\Documents\\GitHub\\County_Voter_Reg\\df_2016.csv')
