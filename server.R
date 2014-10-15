library(shiny)
#By Roman Feldblum; 2014-10-13
# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
    
    # Expression that generates a plot of the distribution. The expression
    # is wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should be automatically 
    #     re-executed when inputs change
    #  2) Its output type is a plot 
    #
    
    
    
    getMotgage <- function (i, y, p)
    {
        r = i/100/12
        n = y * 12
        return ((r / (1 - (1 + r) ^ -n)) * p)
    }
    
    get_df <- function()
    {
        df <- data.frame(Interest = numeric(0), "Monthly_Payment" = numeric(0))
        
        start_end <- strsplit(paste(input$range, collapse=' '), " ")
        
        #print(start_end[[1]][2])
        
        start <- as.numeric(start_end[[1]][1])
        end <- as.numeric(start_end[[1]][2])
        step <- 0.25
        row = 1
        year = input$years
        
        while (start <= end)
        {
            my_mortgage <- getMotgage(start, year, as.numeric(input$amount))
            #print(my_mortgage)
            df[row,] <- c(start, my_mortgage)
            start <- start + step
            row = row + 1
        }
        return (df)
    }
    
    output$distPlot <- renderPlot({

        df <- get_df()
        
        #plot(df, type ="S", main = paste(paste(input$years, " year fixed mortage. $ Amount ="), input$amount))
        plot(df, type ="l", main = paste(paste(input$years, " year fixed mortage. $ Amount ="), input$amount), col = "red", 
             lwd = 3, lty = 2)
        my.at <- round(df$Interest,4)
        #my.at1 <- df$Payment
        axis(1, at = my.at, labels = my.at)
        #axis(2, at = my.at1, labels = my.at1)

    })
    
#data table

sliderValues <- reactive({
    
    # Compose data frame
    df <- get_df()
}) 

# Show the values using an HTML table
output$values <- renderTable({
    sliderValues()
})
    

output$text1 <- renderText({ 
    paste(input$years, " year fixed mortage.")
})

output$text2 <- renderText({ 
    paste("$ Amount =", input$amount)
})
    
})