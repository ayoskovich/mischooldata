library(shiny)
library(shinythemes)
library(shinipsum)

ui <- fluidPage(
  theme = shinytheme('slate'),
  titlePanel('MI School Data: An Alternative Approach'),
  tabsetPanel(type='tabs',
    tabPanel("About This", 
      fluidRow(
        column(4, random_text(nwords = 100)),
        column(4, plotOutput(outputId = 'rPlot'), offset = 2)
      )
    ),
    tabPanel("Individual Lookup",
      fluidRow(
        column(4, random_text(nwords = 100, offset = 1))
      )
    ),
    tabPanel("Comparison",
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
    random_ggplot('point')
  })
}

shinyApp(ui=ui, server = server)