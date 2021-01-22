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

df_2016 = read.csv('df_2016.csv')
df_2020 = read.csv('df_2020.csv')

# Define UI for application
fluidPage(theme = shinytheme('cerulean'),
          
          # Application title
          titlePanel("NJ Voter Registration"),
          
          sidebarLayout(
              # Drop-down menu with region options
              
              mainPanel(
                  selectizeInput(inputId = 'County', label= 'Region',
                                 choices = df_2016$County),
            
              ),
              
              mainPanel(
                  tabsetPanel(
                      
                      tabPanel('Home',
                               "Data is sourced from the NJ Division of Elections Voter Registration Statistics Archive, which can be accessed at https://www.state.nj.us/state/elections/election-information-svrs.shtml",
                               "Please use the drop-down menu above to select whether to view statewide statistics, or data for a specific county.",
                      ),
                      
                      tabPanel('2016 Data',
                               'The dataframe for your selection is provided here.',
                               tableOutput('tableonesix')
                      ),

                      tabPanel('2020 Data',
                               'The dataframe for your selection is provided here.',
                               tableOutput('tabletwozero')
                      )
                      
                  )
              )
          )
          
)