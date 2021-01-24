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
  
  x[22,1] = 'STATEWIDE'
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
  
  x[22,1] = 'STATEWIDE'
  
  return(x)
}


####################################################
# dec2019


dec2019 = read_csv("./tabula-2019-12-voter-registration-by-county.csv")

dec2019 = preprocess(dec2019,'2019-11-30')




####################################################
# jan2020


jan2020 = read_csv("./tabula-2020-01-voter-registration-by-county.csv")

jan2020 = preprocess(jan2020,'2019-12-31')




####################################################
# feb2020


feb2020 = read_csv("./tabula-2020-02-voter-registration-by-county.csv")


feb2020 = preprocess2(feb2020,'2020-02-01')



####################################################
# mar2020


mar2020 = read_csv("./tabula-2020-03-voter-registration-by-county.csv")

mar2020 = preprocess2(mar2020,'2020-03-01')



####################################################
# apr2020


apr2020 = read_csv("./tabula-2020-04-voter-registration-by-county.csv")


apr2020 = preprocess2(apr2020,'2020-04-01')



####################################################
# may2020


may2020 = read_csv("./tabula-2020-05-voter-registration-by-county.csv")
may2020 = preprocess2(may2020,'2020-05-01')



####################################################
# june2020


june2020 = read_csv("./tabula-2020-06-voter-registration-by-county.csv")
june2020 = preprocess2(june2020,'2020-06-01')




####################################################
# july2020


july2020 = read_csv("./tabula-2020-07-voter-registration-by-county.csv")
july2020 = preprocess2(july2020,'2020-07-01')




####################################################
# aug2020


aug2020 = read_csv("./tabula-2020-08-voter-registration-by-county.csv")
aug2020 = preprocess2(aug2020,'2020-08-01')




####################################################
# sep2020


sep2020 = read_csv("./tabula-2020-09-voter-registration-by-county.csv")
sep2020 = preprocess2(sep2020,'2020-09-01')




####################################################
# oct2020


oct2020 = read_csv("./tabula-2020-10-voter-registration-by-county.csv")
oct2020 = preprocess2(oct2020,'2020-10-01')




####################################################
# nov2020


nov2020 = read_csv("./tabula-2020-11-voter-registration-by-county.csv")
nov2020 = preprocess2(nov2020,'2020-11-01')




####################################################
# dec2020


dec2020 = read_csv("./tabula-2020-12-voter-registration-by-county.csv")
dec2020 = preprocess2(dec2020,'2020-12-01')




####################################################
#combine monthly dataframes


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

# change all county names to uppercase

df_2020$County = toupper(df_2020$County)


#####################################################

calculate_change = function(x,y) {
  
  x = df_2020 %>%
    filter(df_2020$County == y)
  
  
  x$Monthly_Change = 0
  x$Percent_Monthly_Change = 0
  
  
  for (i in 1:length(x$Monthly_Change)) {
    if (i == 1) {
      x$Monthly_Change[i] = 0
      x$Percent_Monthly_Change[i] = 0
    } else {
      x$Monthly_Change[i] = x$Total[i] - x$Total[i - 1]
      x$Percent_Monthly_Change[i] = x$Monthly_Change[i] / x$Total[i] * 100
    }
  }
  
  x$Cumulative_Change = 0
  x$Percent_Cumulative_Change = 0
  
  
  
  for (i in 1:length(x$Cumulative_Change)) {
    if (i == 1) {
      x$Monthly_Change[i] = 0
      x$Percent_Cumulative_Change[i] = 0
    } else {
      x$Cumulative_Change[i] = x$Total[i] - x$Total[1]
      x$Percent_Cumulative_Change[i] = x$Cumulative_Change[i] / x$Total[1] * 100
    }
  }
  
  x = x[-1,]
  
  return(x)
}

##########################

atlantic_2020 = calculate_change(atlantic_2020, 'ATLANTIC')


bergen_2020 = calculate_change(bergen_2020, 'BERGEN')


burlington_2020 = calculate_change(burlington_2020, 'BURLINGTON')


camden_2020 = calculate_change(camden_2020, 'CAMDEN')


capemay_2020 = calculate_change(capemay_2020, 'CAPE MAY')


cumberland_2020 = calculate_change(cumberland_2020, 'CUMBERLAND')


essex_2020 = calculate_change(essex_2020, 'ESSEX')


gloucester_2020 = calculate_change(gloucester_2020, 'GLOUCESTER')


hudson_2020 = calculate_change(hudson_2020, 'HUDSON')


hunterdon_2020 = calculate_change(hunterdon_2020, 'HUNTERDON')


mercer_2020 = calculate_change(mercer_2020, 'MERCER')


middlesex_2020 = calculate_change(middlesex_2020, 'MIDDLESEX')


monmouth_2020 = calculate_change(monmouth_2020, 'MONMOUTH')


morris_2020 = calculate_change(morris_2020, 'MORRIS')


ocean_2020 = calculate_change(ocean_2020, 'OCEAN')


passaic_2020 = calculate_change(passaic_2020, 'PASSAIC')


salem_2020 = calculate_change(salem_2020, 'SALEM')


somerset_2020 = calculate_change(somerset_2020, 'SOMERSET')


sussex_2020 = calculate_change(sussex_2020, 'SUSSEX')


union_2020 = calculate_change(union_2020, 'UNION')


warren_2020 = calculate_change(warren_2020, 'WARREN')


statewide_2020 = calculate_change(statewide_2020, 'STATEWIDE')


#combine back into df_2020


df_2020 = rbind(atlantic_2020,
                bergen_2020,
                burlington_2020,
                camden_2020,
                capemay_2020,
                cumberland_2020,
                essex_2020,
                gloucester_2020,
                hudson_2020,
                hunterdon_2020,
                mercer_2020,
                middlesex_2020,
                monmouth_2020,
                morris_2020,
                ocean_2020,
                passaic_2020,
                salem_2020,
                somerset_2020,
                sussex_2020,
                union_2020,
                warren_2020,
                statewide_2020)


#######################

#write to csv
write.csv(df_2020, 'C:\\Users\\aidan\\Documents\\GitHub\\County_Voter_Reg\\df_2020.csv')