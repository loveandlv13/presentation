# this is my comment
# this app will demonstrate the normal distribution and visualize zscores

library(shiny)

# UI for app that draws a histogram from a random sample
ui <- fluidPage(

    # application title
    titlePanel("Presenation demonstration"),

    sliderInput("size",
                "Sample size (n)",
                min = 100,
                max = 10000,
                value = 500),
    
    sliderInput("mean",
                "Mean (μ)",
                min = 100,
                max = 500,
                value = 200),
    
    sliderInput("sd",
                "Standard dev (σ)",
                min = 1,
                max = 50,
                value = 5),

    # Show a plot of the generated distribution
    fluidRow(
            column(6, plotOutput("distPlot")),
            column(6, plotOutput("densPlot"))
      )
  
)

# the back end is where the magic happens!

server <- function(input, output) {
  
  # truncate the vector to inputted sample size so graphs displays one
  # consistent data set until mean / sd are changed
  
    # reactive to generate sample data
  
    sampleData <- reactive(
      rnorm(n = 10000, mean = input$mean, sd = input$sd)
      )
    
    # generate freq histogram 
    output$distPlot <- renderPlot({
      
      hist(sampleData()[1:input$size], col = 'pink', border = 'white',
           xlab = 'n',
           main = 'Histogram of sample (frequency)'
             )
    }, res = 96)
    
    # generate density histogram
    output$densPlot <- renderPlot({
      
        hist(sampleData()[1:input$size], col = 'gold', border = 'white',
             freq = FALSE,
             xlab = 'n',
             main = 'Histogram of sample (density)'
        )
      
      curve(dnorm(x, mean=input$mean, sd=input$sd), 
           add=TRUE, col="black", 
          lwd=3
      )
    }, res = 96)
}

# run application
shinyApp(ui = ui, server = server)
