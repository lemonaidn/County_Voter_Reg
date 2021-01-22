#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(shinythemes)
library(lubridate)

# Define UI for application
fluidPage(theme = shinytheme('cerulean'),
          
          # Application title
          titlePanel("NJ Voter Registration"),
          
          sidebarLayout(
              # Show a plot of the generated distribution
              
              mainPanel(
                  selectizeInput(inputId = 'County', label= 'Statewide',
                                 choices = df_2016$County),
              ),
              mainPanel(
                  tabsetPanel(
                      
                      tabPanel('Home',
                               'This web app provides insights into voter registration rates across New Jersey, and demonstrates the impact caused by COVID on voter registration rates.',
                               "Data is sourced from the NJ Division of Elections Voter Registration Statistics Archive, which can be accessed at https://www.state.nj.us/state/elections/election-information-svrs.shtml",
                               "An analysis of the data reveals the intense impact that COVID had on the ability of NJ citizens to register to vote.",
                               "While there was only one instance of near- or below-zero Percent Change in monthly registrations across all congressional districts in 2016, there were at least 12 such incidents in 2020.",
                               "This was followed by an unprecedented rush of new registrations leading up to the 2020 voter registration deadline.",
                               "These numbers suggest the importance of alternative registration methods for voters, and highlights the difficulty that citizens may have when in-person egistration is unavailable or inconvenient.",
                               "Please use the drop-down menu above to select whether to view statewide statistics, or data for a specific county.",
                               "You can also select year, and whether to generate visualizations or data tables, using the blue tabs above.",
                               "Requests and suggestions for additional functionality can be sent to hughes@nextsteppolitics.com"
                      ),
                      
                      tabPanel('2016 Plot',
                               'The following graph displays month-to-month % change in voter registration for your selected year and region.',
                               'For example, % change on May 31, 2016 represents % change since the PREVIOUS reporting date, NOT cumulative growth since the beginning of the year.
                (If dates on the x-axis appear compressed, please ensure the application window is fully maximized.)',
                               plotOutput('onesix')
                      ),
                      tabPanel('2016 Data',
                               'The dataframe for your selection is provided here. Please note that although the dataframe includes voter reg statistics by
                  party affiliation, the "Net Monthly Change" and "Percent Monthly Change" columns (and the graphic displayed in the "Plot" tab) are calculated from the "Total" column
                  for all registrations, regardless of party affiliation. The option to calculate & visualize change by party affiliation may be added in a future update.',
                               tableOutput('tableonesix')
                      ),
                      tabPanel('2020 Plot',
                               'The following graph displays month-to-month % change in voter registration for your selected year and region.',
                               'For example, % change on May 31, 2016 represents % change since the PREVIOUS reporting date, NOT cumulative growth since the beginning of the year.
                (If dates on the x-axis appear compressed, please ensure the application window is fully maximized.)',
                               plotOutput('twozero')
                      ),
                      tabPanel('2020 Data',
                               'The dataframe for your selection is provided here. Please note that although the dataframe includes voter reg statistics by
                  party affiliation, the "Net Monthly Change" and "Percent Monthly Change" columns (and the graphic displayed in the "Plot" tab) are calculated from the "Total" column
                  for all registrations, regardless of party affiliation. The option to calculate & visualize change by party affiliation may be added in a future update.',
                               tableOutput('tabletwozero')
                      )
                      
                  )
              )
          )
          
)