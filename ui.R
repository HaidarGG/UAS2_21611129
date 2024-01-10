library(shiny)
library(tidyverse)
library(shinydashboard)
library(MASS)
library(ggplot2)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("lumen"),
  titlePanel("Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload CSV File", multiple = FALSE, accept = ".csv"),
      br(),
      actionButton("analyzeBtn", "Statistical Analysis Results")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Data", DT::dataTableOutput('tbl')), # Data dalam tabel
        tabPanel("Summary Data", verbatimTextOutput("summaryText")),
        tabPanel("Box Plot", 
          fluidPage(
            sidebarLayout(
              sidebarPanel(
                h5("select variables for the boxplot:"),
                selectInput("var_box", "Variabel:", ""),
                
              ),
              plotOutput("boxPlot")))),
        tabPanel("Bar Plot", 
          fluidPage(
            sidebarLayout(
              sidebarPanel(
                h5("select variables for the barplot:"),
                selectInput("var_bar", "Variabel:", "")
                
              ),
              plotOutput("barPlot")))),
        tabPanel("Data and ANOVA Test Results", 
          fluidPage(
            titlePanel("Analysis of Variance"),
            sidebarLayout(
              sidebarPanel(
                selectInput("vardipen", label = h3("Dependen"),
                  list("y" = "y"), selected = 1),
                
                selectInput("varindepen", label = h3("Independen"),
                  list("group" = "group"), selected = 1)
                
              ),
              
              mainPanel(
                titlePanel("Data"),
                DT::dataTableOutput('tbl1'),
                titlePanel("Result"),
                verbatimTextOutput("anovaText")
              )
            )
          )
        )
      )
    )
  )
)