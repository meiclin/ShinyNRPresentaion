library(shiny)

# Define UI for random distribution application 
shinyUI(pageWithSidebar(
        
        # Application title
        headerPanel("Distribution Exercises"),
        
        # Sidebar with controls to select the random distribution type
        # and number of observations to generate. Note the use of the br()
        # element to introduce extra vertical spacing
        sidebarPanel(
                selectInput("dataset", "Choose a dataset:", 
                            choices = c("rock", "pressure", "cars", "iris")),
                
                selectInput("x", "Choose factor for x:",
                            choices = c( "rock$area", "rock$peri", "rock$shape", "rock$perm",
                                         "pressure$temperature", "pressure$pressure", 
                                         "cars$speed", "cars$dist",
                                         "iris$Sepal.Length", "iris$Sepal.Width", 
                                         "iris$Petal.Length", "iris$Petal.Width", "iris$Species")),

                selectInput("y", "Choose factor for y:",
                            choices = c("rock$area", "rock$peri", "rock$shape", "rock$perm",
                                        "pressure$temperature", "pressure$pressure", 
                                        "cars$speed", "cars$dist",
                                        "iris$Sepal.Length", "iris$Sepal.Width", 
                                        "iris$Petal.Length", "iris$Petal.Width", "iris$Species")),

                radioButtons("dist", "Distribution type:",
                             list("Normal" = "norm",
                                  "Uniform" = "unif",
                                  "Log-normal" = "lnorm",
                                  "Exponential" = "exp")),
                br(),
                
                sliderInput("n", 
                            "Number of observations:", 
                            value = 500,
                            min = 1, 
                            max = 1000)
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(
                tabsetPanel(
                        tabPanel("Scatter Plot", plotOutput("plot1"), height = 400, width = 400),
                        tabPanel("Distribution Plot", plotOutput("plot2")),
                        tabPanel("Summary", verbatimTextOutput("summary")), 
                        tabPanel("Table", tableOutput("table"))
                )
        )
))