# File: load_data.R
# Description: Loads the airports open data and summarizes some variables.
# Author: Miguel Ángel García
# Course: Coursera - Developing Data Products

# First, we load the needed libraries
library(dplyr)

# We download the data from its original source
# The airports data first
if(!exists("airports"))
{
    # The download is commented because it doesn't work on shinyapp (cURL is needed)
    #    download.file("https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat", 
    #                   "airports.dat")
    airports <- read.csv("airports.dat", header = FALSE)
    names(airports) <- c("AirportID", "Name", "City", "Country", "IATA_FAA", "ICAO", "Latitude", 
                         "Longitude", "Altitude", "Timezone", "DST", "TZName")
}

# The airlines data second
if(!exists("airlines"))
{
    # The download is commented because it doesn't work on shinyapp (cURL is needed)
    #     download.file("https://raw.githubusercontent.com/jpatokal/openflights/master/data/airlines.dat",
    #                   "airlines.dat")
    airlines <- read.csv("airlines.dat", header = FALSE, na.strings = "\\N")
    names(airlines) <- c("AirlineID", "Name", "Alias", "IATA", "ICAO", "Callsign", "Country",
                         "Active")
}

# Count number of airports by country
if(!exists("countryAirports"))
    countryAirports <- airports %>%
        group_by(Country) %>%
        summarize(numAirports = n()) %>%
        arrange(desc(numAirports))

# Count number of total airlines by country
if(!exists("countryAirlines"))
    countryAirlines <- airlines %>%
        group_by(Country) %>%
        summarize(numAirlines = n()) %>%
        arrange(desc(numAirlines))

# Count number of total active airlines by country
if(!exists("countryActAirlines"))
    countryActAirlines <- airlines %>%
        filter(Active == "Y") %>%
        group_by(Country) %>%
        summarize(numAirlines = n()) %>%
        arrange(desc(numAirlines))

# Join tables
if(!exists("countryAirData"))
    countryAirData <- inner_join(countryAirports, countryAirlines)
if(!exists("countryActAirData"))
    countryActAirData <- inner_join(countryAirports, countryActAirlines)
