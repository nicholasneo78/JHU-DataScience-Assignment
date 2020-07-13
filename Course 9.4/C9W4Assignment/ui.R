library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict the Price of the Diamond"),
  
  # Sidebar with options selectors 
  sidebarLayout(
    sidebarPanel(
      helpText("This application predicts the price of a diamond."),
      h3(helpText("Your choice:")),
      numericInput("car", label = h4("# of Carats"), step = 0.01, value = 2),
      selectInput("cut", label = h4("Cut type"), 
                  choices = list("Unknown" = "*", "Fair" = "Fair", "Good" = "^Good",
                                 "Very Good" = "Very Good", "Premium" = "Premium",
                                 "Ideal" = "Ideal")),
      selectInput("col", label = h4("Color"), 
                  choices = list("Unknown" = "*", "D" = "D", "E" = "E",
                                 "F" = "F", "G" ="G",
                                 "H" = "H", "I" = "I",
                                 "J" = "J")),
      selectInput("clar", label = h4("Diamond Clarity"), 
                  choices = list("Unknown" = "*", "I1" = "I1", "SI2" = "SI2",
                                 "SI1" = "SI1", "VS2" = "VS2", "VS1" = "VS1",
                                 "VVS2" = "VVS2", "VVS1" = "VVS1", "IF" = "IF" ))
    ),
    
    # Show a plot with diamonds and regression line
    mainPanel(
      plotOutput("distPlot"),
      h3("Predicted value of this diamond is:"),
      h3(textOutput("result"))
    )
  )
))