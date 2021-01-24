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
# dec2015


dec2015 = read_csv("./tabula-2015-12-voter-registration-by-county.csv")
dec2015 = dec2015%>%
  select(-X11)

dec2015 = preprocess(dec2015,'2015-11-30')




####################################################
# jan2016


jan2016 = read_csv("./tabula-2016-01-voter-registration-by-county.csv")
jan2016 = jan2016%>%
  select(-X11)

jan2016 = preprocess(jan2016,'2015-12-31')




####################################################
# feb2016


feb2016 = read_csv("./tabula-2016-02-voter-registration-by-county.csv")
feb2016 = feb2016%>%
  select(-X11)

feb2016 = preprocess(feb2016,'2016-01-31')



####################################################
# mar2016


mar2016 = read_csv("./tabula-2016-03-voter-registration-by-county.csv")
mar2016 = mar2016%>%
  select(-X11)

mar2016 = preprocess(mar2016,'2016-03-02')



####################################################
# apr2016


apr2016 = read_csv("./tabula-2016-04-voter-registration-by-county.csv")
apr2016 = apr2016%>%
  select(-X11)

apr2016 = preprocess(apr2016,'2016-03-31')



####################################################
# may2016


may2016 = read_csv("./tabula-2016-05-voter-registration-by-county.csv")
may2016 = preprocess(may2016,'2016-04-30')



####################################################
# june2016


june2016 = read_csv("./tabula-2016-06-voter-registration-by-county.csv")
june2016 = preprocess(june2016,'2016-05-31')




####################################################
# july2016


july2016 = read_csv("./tabula-2016-07-voter-registration-by-county.csv")
july2016 = preprocess(july2016,'2016-06-30')




####################################################
# aug2016


aug2016 = read_csv("./tabula-2016-08-voter-registration-by-county.csv")
aug2016 = preprocess(aug2016,'2016-08-05')




####################################################
# sep2016


sep2016 = read_csv("./tabula-2016-09-voter-registration-by-county.csv")
sep2016 = preprocess(sep2016,'2016-08-31')




####################################################
# oct2016


oct2016 = read_csv("./tabula-2016-10-voter-registration-by-county.csv")
oct2016 = preprocess(oct2016,'2016-10-05')




####################################################
# nov2016


nov2016 = read_csv("./tabula-2016-11-voter-registration-by-county.csv")
nov2016 = preprocess(nov2016,'2016-11-07')




####################################################
# dec2016


dec2016 = read_csv("./tabula-2016-12-voter-registration-by-county.csv")
dec2016 = preprocess(dec2016,'2016-11-30')




####################################################
#combine monthly dataframes


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

# change all county names to uppercase

df_2016$County = toupper(df_2016$County)


#####################################################

calculate_change = function(x,y) {
  
  x = df_2016 %>%
    filter(df_2016$County == y)
  
  
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

atlantic_2016 = calculate_change(atlantic_2016, 'ATLANTIC')
atlantic_2016

bergen_2016 = calculate_change(bergen_2016, 'BERGEN')


burlington_2016 = calculate_change(burlington_2016, 'BURLINGTON')


camden_2016 = calculate_change(camden_2016, 'CAMDEN')


capemay_2016 = calculate_change(capemay_2016, 'CAPE MAY')


cumberland_2016 = calculate_change(cumberland_2016, 'CUMBERLAND')


essex_2016 = calculate_change(essex_2016, 'ESSEX')


gloucester_2016 = calculate_change(gloucester_2016, 'GLOUCESTER')


hudson_2016 = calculate_change(hudson_2016, 'HUDSON')


hunterdon_2016 = calculate_change(hunterdon_2016, 'HUNTERDON')


mercer_2016 = calculate_change(mercer_2016, 'MERCER')


middlesex_2016 = calculate_change(middlesex_2016, 'MIDDLESEX')


monmouth_2016 = calculate_change(monmouth_2016, 'MONMOUTH')


morris_2016 = calculate_change(morris_2016, 'MORRIS')


ocean_2016 = calculate_change(ocean_2016, 'OCEAN')


passaic_2016 = calculate_change(passaic_2016, 'PASSAIC')


salem_2016 = calculate_change(salem_2016, 'SALEM')


somerset_2016 = calculate_change(somerset_2016, 'SOMERSET')


sussex_2016 = calculate_change(sussex_2016, 'SUSSEX')


union_2016 = calculate_change(union_2016, 'UNION')


warren_2016 = calculate_change(warren_2016, 'WARREN')


statewide_2016 = calculate_change(statewide_2016, 'STATEWIDE')


#combine back into df_2016


df_2016 = rbind(atlantic_2016,
                bergen_2016,
                burlington_2016,
                camden_2016,
                capemay_2016,
                cumberland_2016,
                essex_2016,
                gloucester_2016,
                hudson_2016,
                hunterdon_2016,
                mercer_2016,
                middlesex_2016,
                monmouth_2016,
                morris_2016,
                ocean_2016,
                passaic_2016,
                salem_2016,
                somerset_2016,
                sussex_2016,
                union_2016,
                warren_2016,
                statewide_2016)


#######################

#write to csv
write.csv(df_2016, 'C:\\Users\\aidan\\Documents\\GitHub\\County_Voter_Reg\\df_2016.csv')
