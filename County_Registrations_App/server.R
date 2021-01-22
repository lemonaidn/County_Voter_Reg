#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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


function(input, output) {
    
    output$tableonesix=renderTable(
        df_2016 %>%
            filter(County==input$County)
    )
    
    output$tabletwozero=renderTable(
        df_2020 %>%
            filter(County==input$County)
    )
    
}
