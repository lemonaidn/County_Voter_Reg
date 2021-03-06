library(plotly)
library(tidyverse)
library(htmlwidgets)
Sys.setenv("plotly_username"="lemonaidn")
Sys.setenv("plotly_api_key"="CbT4Hgp9LiutDMPEpWs2")

# check number of instances of negative registrations in 2016

df_2016 = read.csv('df_2016.csv')

df_2016 = df_2016 %>%
  select(-1)

negative_2016 = df_2016 %>%
  filter(Percent_Monthly_Change <= 0)
negative_2016

# 13 instances



# check number of instances of negative registrations in 2020

df_2020 = read.csv('df_2020.csv')

df_2020 = df_2020 %>%
  select(-1)

negative_2020 = df_2020 %>%
  filter(Percent_Monthly_Change <= 0)

# 38 instances



# plot 2016 statewide percentages

x = list(title = 'Reporting Date (2016)')
y = list(title = 'Growth Since Previous Reporting Date (%)')

statewide_2016 = df_2016 %>%
  filter(County == 'STATEWIDE')

fig_monthly_statewide_2016 = plot_ly(
  x = statewide_2016$Reporting_Date,
  y = statewide_2016$Percent_Monthly_Change,
  name = 'Month-to-Month Statewide Changes (%) 2016',
  type = 'bar'
)
fig_monthly_statewide_2016 = fig_monthly_statewide_2016 %>%
  layout(xaxis = x,
         yaxis = y)

fig_monthly_statewide_2016


api_create(fig_monthly_statewide_2016, filename = "fig_monthly_statewide_2016")


# plot 2020 statewide percentages

x = list(title = 'Reporting Date (2020)')
y = list(title = 'Growth Since Previous Reporting Date (%)')

statewide_2020 = df_2020 %>%
  filter(County == 'STATEWIDE')

fig_monthly_statewide_2020 = plot_ly(
  x = statewide_2020$Reporting_Date,
  y = statewide_2020$Percent_Monthly_Change,
  name = 'Month-to-Month Statewide Changes (%) 2020',
  type = 'bar'
)
fig_monthly_statewide_2020 = fig_monthly_statewide_2020 %>%
  layout(xaxis = x,
         yaxis = y)

fig_monthly_statewide_2020


api_create(fig_monthly_statewide_2020, filename = "fig_monthly_statewide_2020")


################################

# Plotting statewide cumulative growth

x = list(title = 'Reporting Date (2016)')
y = list(title = 'Cumulative Growth (%)')

fig_cumulative_statewide_2016 = plot_ly(
  x = statewide_2016$Reporting_Date,
  y = statewide_2016$Percent_Cumulative_Change,
  type = 'scatter',
  mode = 'lines+markers')
fig_cumulative_statewide_2016 = fig_cumulative_statewide_2016 %>%
  layout(xaxis = x,
         yaxis = y)
fig_cumulative_statewide_2016

api_create(fig_cumulative_statewide_2016, filename = "fig_cumulative_statewide_2016")






x = list(title = 'Reporting Date (2020)')
y = list(title = 'Cumulative Growth (%)')

fig_cumulative_statewide_2020 = plot_ly(
  x = statewide_2020$Reporting_Date,
  y = statewide_2020$Percent_Cumulative_Change,
  type = 'scatter',
  mode = 'lines+markers')
fig_cumulative_statewide_2020 = fig_cumulative_statewide_2020 %>%
  layout(xaxis = x,
         yaxis = y)
fig_cumulative_statewide_2020

api_create(fig_cumulative_statewide_2020, filename = "fig_cumulative_statewide_2020")


#################################


# Get counts of negative registration months by county

counts_negative_2016 = dplyr::count(negative_2016, County, sort = TRUE)
counts_negative_2016

counts_negative_2020 = dplyr::count(negative_2020, County, sort = TRUE)
counts_negative_2020

months_negative_2016 = dplyr::count(negative_2016, Reporting_Date, sort = TRUE)
months_negative_2016

months_negative_2020 = dplyr::count(negative_2020, Reporting_Date, sort = TRUE)
months_negative_2020


# create a list of all NJ county names

county_names =  unique(df_2016$County)
county_names = county_names[county_names != 'STATEWIDE']

# if county has no negatives, add them to the counts df as 0's


for (i in county_names) {
  if (i %in% counts_negative_2016$County) {
    next
  } else {
    counts_negative_2016[nrow(counts_negative_2016) + 1,] = list(County = i, n = 0)
  }
}

for (i in county_names) {
  if (i %in% counts_negative_2020$County) {
    next
  } else {
    counts_negative_2020[nrow(counts_negative_2020) + 1,] = list(County = i, n = 0)
  }
}


fig_negative_2016 = plot_ly(
  counts_negative_2016,
  x = counts_negative_2016$n,
  y = counts_negative_2016$County,
  type = 'bar',
  color = counts_negative_2016$County)
fig_negative_2016 = fig_negative_2016 %>%
  layout(
    xaxis = list(
      title = 'Number of months with negative registration growth (2016)',
      dtick = 1,
      range = c(0,4)
      ),   
    yaxis = list(
         autorange = 'reversed'
       )
  )
fig_negative_2016


api_create(fig_negative_2016, filename = "fig_negative_2016")


fig_negative_2020 = plot_ly(
  counts_negative_2020,
  x = counts_negative_2020$n,
  y = counts_negative_2020$County,
  type = 'bar',
  color = counts_negative_2020$County)
fig_negative_2020 = fig_negative_2020 %>%
  layout(
    xaxis = list(
      title = 'Number of months with negative registration growth (2020)',
      dtick = 1,
      range = c(0,4)
    ),   
    yaxis = list(
      autorange = 'reversed'
    )
  )
fig_negative_2020


api_create(fig_negative_2020, filename = "fig_negative_2020")

# Graph the worst affected county: Mercer

mercer_2016 = df_2016 %>%
  filter(County == 'MERCER')

x = list(title = 'Reporting Date (2016)')
y = list(title = 'Growth Since Previous Reporting Date (%)')


fig_monthly_mercer_2016 = plot_ly(
  x = mercer_2016$Reporting_Date,
  y = mercer_2016$Percent_Monthly_Change,
  name = 'Month-to-Month Changes (%) 2016',
  type = 'bar'
)
fig_monthly_mercer_2016 = fig_monthly_mercer_2016 %>%
  layout(xaxis = x,
         yaxis = y)

fig_monthly_mercer_2016


api_create(fig_monthly_mercer_2016, filename = "fig_monthly_mercer_2016")




mercer_2020 = df_2020 %>%
  filter(County == 'MERCER')

x = list(title = 'Reporting Date (2020)')
y = list(title = 'Growth Since Previous Reporting Date (%)')


fig_monthly_mercer_2020 = plot_ly(
  x = mercer_2020$Reporting_Date,
  y = mercer_2020$Percent_Monthly_Change,
  name = 'Month-to-Month Changes (%) 2020',
  type = 'bar'
)
fig_monthly_mercer_2020 = fig_monthly_mercer_2020 %>%
  layout(xaxis = x,
         yaxis = y)

fig_monthly_mercer_2020


api_create(fig_monthly_mercer_2020, filename = "fig_monthly_mercer_2020")
