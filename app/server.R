server <- function(input, output) {
  output$rPlot <- renderPlot({
    random_ggplot("point") + base_theme
  })

  output$about <- renderUI({
    HTML(read_file("txts/about.html"))
  })
}