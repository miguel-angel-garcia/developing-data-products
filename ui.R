# File: ui.R
# Description: User interface for the Shiny app.
# Author: Miguel Ángel García
# Course: Coursera - Developing Data Products

# Inits libraries needed
library(shiny)
require(rCharts)

# Loads and process the data
source("load_data.R")

# Sets global parameters
options(RCHART_LIB = 'polycharts')
countriesName <- as.character(sort(unique(airports$Country)))

# User interface
shinyUI(pageWithSidebar(
    headerPanel("Airports and Airlines around the World"),
    
    # On the sidebar we will have all the controls conditioned by the panels tabs
    sidebarPanel(
        conditionalPanel( # Plots panel
            condition = "input.panels == 1",
            h3("Filters for the plots tab"),
            sliderInput(inputId = "top",
                        label = h4("Show countries"),
                        value = c(1, 10),
                        min = 1,
                        max = max(c(nlevels(unique(airports$Country)), 
                                    nlevels(unique(airlines$Country))))),
            checkboxInput(inputId = "active",
                          label = "Only active airlines",
                          value = FALSE)
        ),
        conditionalPanel( # Maps panel
            condition = "input.panels == 2",
            h3("Filter for the map"),
            selectInput("country",
                        label = "Choose airports by country",
                        choices = as.list(countriesName),
                        selected = "Spain")
        ),
        conditionalPanel( # Help panel
            condition = "input.panels == 3",
            h3("About"),
            p("Author: Miguel Ángel García"),
            p("Date: 2016-02-28"),
            p("Course: Developing Data Products"),
            p("Source data: ", 
              a("OpenFlights", href = "http://openflights.org/data.html"),
            p(em("(Sorry for my english! ;-)")))
        )
    ),

    # On the main panel, we will have the tabs with charts and map
    mainPanel(
        tabsetPanel(
            tabPanel("Plots", value = 1,
                     h2("Airports and Airlines by Country"),
                     p("The bars shows airports and the dots shows airlines. You can filter to show only active airlines."),
                     showOutput("chartTop", "polycharts"),
                     showOutput("chartBotton", "polycharts")
            ),
            tabPanel("Maps", value = 2,
                     h2("Map of Airports around the World"),
                     showOutput("map", "leaflet")
            ),
            tabPanel("Help", value = 3,
                     h2("Airports and Airlines App User Help"),
                     HTML('
<p>This Shiny app shows the number of airports and airlines by country. 
The data comes from the <a href ="http://openflights.org/data.html">OpenFlights.org</a> web page.</p>
<h3>Sections of the screen</h3>
<p>The main page is divided in two section:</p>
<ul>
    <li><strong>Side bar: </strong>
        <p>You will found here all the controls needed to filter the data.</p>
    </li>
    <li><strong>Main panel: </strong>
        <p>The charts and graphs will be in this section.</p>
    </li>
</ul>

<h3>The tabs</h3>
<p>On the top of the screen you\'ll see three different tabs. Each one let you navigate through the 
different options of the app. At this moment, there are:</p>
<ul>
    <li><strong>Plots: </strong>
        <p>This is the default tab. It shows you the number of airports and airlines for each country 
through two graphics. The one at the <strong>top</strong> shows the number of airports by country on 
the bars and the number of airlines by country on the points. The one at the <strong>botton</strong> 
shows the same measures but using two dimensions: on the <i>X</i> axis is the airlines data and 
on the <i>Y</i> axis is the airports data. You can select how many countries will be displayed by 
using the slider on the side bar. Or, if you want to show only the active airlines, you can use the 
check bok on the side bar.</p>
    </li>
    <li><strong>Maps: </strong>
        <p>This tab show you a geographic map with all the airports by country marked in. You can 
choose your desire country by using the input selector on the side bar panel.</p>
    </li>
    <li><strong>Help: </strong>
        <p>Shows this help!</p>
    </li>
</ul>

<h3>Further development</h3>
<p>The data from Open Flights is very interesting, but it lacks from the features needed to make 
a prediction model. This could be supplied by the use of the data from the 
<a href="http://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0">Bureau of Transportation Statistics</a> 
which contains scheduled and actual departure and arrival times for passanger flights. 
Using this dataset, we could make a predictor for the predicted delay time for a flight. Unfortunately, 
I haven\'t time enough to do this...</p>
                ')),
            id = "panels"
        )
    )
))