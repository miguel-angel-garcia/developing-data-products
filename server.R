# File: server.R
# Description: Data process for the Shiny app.
# Author: Miguel Ángel García
# Course: Coursera - Developing Data Products

# Inits libraries needed
library(shiny)
require(rCharts)

# Sets global parameters
options(RCHART_WIDTH = 800)

# Shiny loop
shinyServer(function(input, output) 
{
    # Calculates the filtering data for active/inactive airlines
    topAirData <- reactive(
    {
        if(input$active)
            return(countryActAirData[input$top[1]:input$top[2], ])
        else
            return(countryAirData[input$top[1]:input$top[2], ])
    })

    # Renders char for airports and airlines bar plot
    output$chartTop <- renderChart(
    {
        # Initialize bar plot for number of airports by country
        p1 <- rPlot(x = list(var = "Country", sort = "numAirports"), y = "numAirports", 
                    color = "Country", data = topAirData(), type = 'bar')
        
        p1$layer(x = "Country", y = "numAirlines", color = list(const = "black"),
                 data = topAirData(), type = 'point', size = list(const = 2))

        # Format the x and y axis labels
        p1$guides(x = list(title = "", ticks = topAirData()$Country))
        p1$guides(y = list(title = ""))
        
        # Set the height of the plot and attach it to the dom
        p1$addParams(height = 300, dom = 'chartTop')
        
        # Print the chart
        return(p1)
    })

    # Renders char for airports and airlines point plot
    output$chartBotton <- renderChart(
    {
        # Initialize point plot for number of airlines by country
        p2 <- rPlot(numAirports ~ numAirlines, color = "Country", 
                    data = topAirData(), type = 'point')
        
        # Format the x and y axis labels
        p2$guides(x = list(title = "# Airlines", ticks = topAirData()$Country))
        p2$guides(y = list(title = "# Airports"))
        
        # Set the height of the plot and attach it to the dom
        p2$addParams(height = 300, dom = 'chartBotton')
        return(p2)
    })
    
    # Renders the map form airports by country
    output$map <- renderMap(
    {
        # Firts, we filter the airports by the selected country
        airportsByCountry <- subset(airports, Country == input$country)
        
        # We create the map using de leaflet object
        map <- Leaflet$new()
        # Sets the view for the country at the middle point of its airports
        map$setView(c(mean(airportsByCountry$Latitude), mean(airportsByCountry$Longitude)), 
                    zoom = 4)
        # Sets the airports points on the map
        for(i in 1:dim(airportsByCountry)[1])
        {
            map$marker(c(airportsByCountry[i,]$Latitude, airportsByCountry[i,]$Longitude), 
                       bindPopup = airportsByCountry[i,]$Name)
        }
        return(map)
    })
})