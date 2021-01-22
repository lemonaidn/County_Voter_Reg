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
    output$onesix=renderPlot(
        df_2016 %>%
            filter(County==input$County) %>%
            ggplot(aes(x = Reporting_Date,
                       y = Percent_Monthly_Change,
                       fill = Percent_Monthly_Change > 0)) +
            geom_col() + theme_economist_white() + scale_fill_tableau() + guides(fill = "none")
        
        
    )
    
    output$twozero=renderPlot(
        df_2020 %>%
            filter(County==input$County) %>%
            ggplot(aes(x = Reporting_Date,
                       y = Percent_Monthly_Change,
                       fill = Percent_Monthly_Change > 0)) +
            geom_col() + theme_economist_white() + scale_fill_tableau() + guides(fill = "none")
    )
    
    output$tableonesix=renderTable(
        df_2016 %>%
            filter(County==input$County)
    )
    
    output$tabletwozero=renderTable(
        df_2020 %>%
            filter(County==input$County)
    )
    
}
