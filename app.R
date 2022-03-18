library(shiny)
library(shinythemes)
library(shinipsum)
library(tidyverse)

base_theme <- theme_bw() + theme(
  axis.ticks = element_blank()
)

ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel("MI School Data: An Alternative Approach"),
  tabsetPanel(type = "tabs",

    tabPanel("Methodology",
      fluidRow(
        column(4, uiOutput(outputId = "about")),
        column(4, plotOutput(outputId = "rPlot"), offset = 2)
      )
    ),

    tabPanel("School Lookup",
      fluidRow(
        column(4, random_text(nwords = 100, offset = 1))
      )
    ),

    tabPanel("School Comparison",
      fluidRow(
        column(4, random_text(nwords = 100, offset = 2))
      )
    ),

    tabPanel("Analyze",
      fluidRow(
        column(4, random_text(nwords = 100, offset = 3))
      )
    )

  )
)

server <- function(input, output) {
  output$rPlot <- renderPlot({
    random_ggplot("point") + base_theme
  })

  output$about <- renderUI({
    HTML(read_file("txts/about.html"))
  })
}

shinyApp(ui=ui, server = server)