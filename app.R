# this is my comment
# this app will demonstrate the normal distribution and visualize zscores

library(shiny)

# UI for app that draws a histogram from a random sample
ui <- fluidPage(

    # application title
    titlePanel("Presenation demonstration"),

    # input for sample size, mean, and SD
    sidebarLayout(
        sidebarPanel(
            sliderInput("size",
                        "Sample size (n)",
                        min = 10,
                        max = 1000,
                        value = 500),
            
            sliderInput("mean",
                        "Mean (μ)",
                        min = 1,
                        max = 500,
                        value = 25),
            
            sliderInput("sd",
                        "Standard dev (σ)",
                        min = 1,
                        max = 50,
                        value = 5),
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# the back end is where the magic happens!

server <- function(input, output) {
  
    # reactive to generate sample data
  
    sampleData <- reactive(
      rnorm(n = input$size, mean = input$mean, sd = input$sd)
      )
    
    # generate histogram
    output$distPlot <- renderPlot({
        hist(sampleData(), col = 'pink', border = 'white',
             xlab = 'n',
             main = 'Histogram of sample'
             )
    })
}

# run application
shinyApp(ui = ui, server = server)
