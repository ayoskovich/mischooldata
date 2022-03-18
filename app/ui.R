
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