library(shiny)
library(datasets)

# Define server logic for random distribution application
shinyServer(function(input, output) {
        
        # Reactive expression to generate the requested distribution. This is 
        # called whenever the inputs change. The renderers defined 
        # below then all use the value computed from this expression
        data <- reactive({  
                dist <- switch(input$dist,
                               norm = rnorm,
                               unif = runif,
                               lnorm = rlnorm,
                               exp = rexp,
                               rnorm)
                
                dist(input$n)
        })
        
        datasetInput <- reactive({
                switch(input$dataset,
                       "rock" = rock,
                       "pressure" = pressure,
                       "cars" = cars)
        })
        
        xdata <- reactive({
                switch(input$x,
                       "rock$area" = rock$area, 
                       "rock$peri" = rock$peri, 
                       "rock$shape" = rock$shape, 
                       "rock$perm" = rock$shape,
                       "pressure$temperature" = pressure$temperature, 
                       "pressure$pressure" = pressure$pressure, 
                       "cars$speed" = cars$speed, 
                       "cars$dist" = cars$dist,
                       "iris$Sepal.Length" = iris$Sepal.Length, 
                       "iris$Sepal.Width" = iris$Sepal.Width, 
                       "iris$Petal.Length" = iris$Petal.Length, 
                       "iris$Petal.Width" = iris$Petal.Width, 
                       "iris$Species" = iris$Species)
        })
        
        ydata <- reactive({
                switch(input$y,
                       "rock$area" = rock$area, 
                       "rock$peri" = rock$peri, 
                       "rock$shape" = rock$shape, 
                       "rock$perm" = rock$shape,
                       "pressure$temperature" = pressure$temperature, 
                       "pressure$pressure" = pressure$pressure, 
                       "cars$speed" = cars$speed, 
                       "cars$dist" = cars$dist,
                       "iris$Sepal.Length" = iris$Sepal.Length, 
                       "iris$Sepal.Width" = iris$Sepal.Width, 
                       "iris$Petal.Length" = iris$Petal.Length, 
                       "iris$Petal.Width" = iris$Petal.Width, 
                       "iris$Species" = iris$Species)
        })
        # Generate a plot of the data. Also uses the inputs to build the 
        # plot label. Note that the dependencies on both the inputs and
        # the 'data' reactive expression are both tracked, and all expressions 
        # are called in the sequence implied by the dependency graph
        output$plot1 <- renderPlot({
                x <- input$x
                y <- input$y
                plot(xdata(), ydata(), 
                     main=paste('Scatter plot of', y, ' and ', x, sep=''),
                     xlab=x, ylab=y, pch=19)
                abline(lm(ydata() ~ xdata()))
                reg <- lm(ydata() ~ xdata())
                text(paste(ydata(), '=', round(lm(ydata() ~ xdata())$coef[1], 2), 
                                 '+', round(reg$coef[2], 2), '*', xdata()))
                

        })
        
         output$plot2 <- renderPlot({                
                dist <- input$dist
                n <- input$n
                hist(data(), 
                     main=paste('r', dist, '(', n, ')', sep=''))
                
                
        })
        
        # Generate a summary of the data
        output$summary <- renderPrint({
                summary(data())
                summary(datasetInput())
        })
        
        # Generate an HTML table view of the data
        output$table <- renderTable({
                data.frame(x=data())
                head(datasetInput(), n = input$n)
        })
})