library(shiny)
#By Roman Feldblum; 2014-10-13
# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Monthly Payment Fixed Rate Mortgage Calculator"),
    
    # Sidebar with a slider input for number of observations
    sidebarPanel(
        h6("Select number of years you would like to have mortgage for."),
        h6("Select fixed interest rates range to compare monthly payment options."),
        h6("Enter total mortgage amount"),
        h5(" "),
        sliderInput("years", 
                    "Select Number Of Years:", 
                    min = 10,
                    max = 40, 
                    value = 15,
                    step = 5),
        sliderInput("range", "Desired Fixed Interest Rate Range:",
                    min = 2.5, max = 13, value = c(3.25,7.5), step = 0.25),
        textInput("amount", "Enter Mortgage Amount $$$", value = "200000" )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("distPlot"),
        h4(textOutput("text1")),
        h4(textOutput("text2")),
        tableOutput("values")
    )
))
