library(shiny)
library(shinythemes)
library(shinipsum)

ui <- fluidPage(
  theme = shinytheme('slate'),
  titlePanel('MI School Data: An Alternative Approach'),
  sidebarLayout(
    sidebarPanel(random_text(nwords = 50)),
    mainPanel(
      tabsetPanel(type='tabs',
        tabPanel("About This", random_text(nwords = 100)),
        tabPanel("Individual Lookup", random_text(nwords = 100, offset = 1)),
        tabPanel("Comparison", random_text(nwords = 100, offset = 2)),
        tabPanel("Analyze", random_text(nwords = 100, offset = 3))
      )
    )
  )
)

server <- function(input, output) {

}

shinyApp(ui=ui, server = server)