DDP - Course Project Presentation
========================================================
author: Miguel Ángel García
date: 2016-02-28
transition: rotate

- An Airports and Airlines App

Project Motivation
========================================================

For this project, I choose to use the [**Open Flights**](http://openflights.org/data.html) 
data. In particular, this datasets:

- *Airports:* Contains data for airports around the world
- *Airlines:* Contains data for world wide airlines

I would like to do a prediction model for flights (for
example, predicting the delayed time) using this data and
data from the [Bureau of Transportation Statistics](http://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0) but, 
unfortunately, I haven't enough time to do it.

Loading the Data
========================================================
First, we load and name the datasets:

```r
airports <- read.csv("airports.dat", header = FALSE)
names(airports) <- c("AirportID", "Name", "City", "Country", "IATA_FAA", "ICAO", "Latitude", "Longitude", "Altitude", "Timezone", "DST", "TZName")
airlines <- read.csv("airlines.dat", header = FALSE, na.strings = "\\N")
names(airlines) <- c("AirlineID", "Name", "Alias", "IATA", "ICAO", "Callsign", "Country", "Active")
```
Notice that we have the *longitude* and *latitude* data, so
I'll have to use it!

Exploratory Data Analysis Express!
========================================================
We can summarize the data to obtain the number of 
airports and airlines by country and plot it (in this 
presentation, I'm using `ggplot2`) 

![plot of chunk unnamed-chunk-2](mag-ddp-presentation-figure/unnamed-chunk-2-1.png)
Final Conclusions
========================================================
After finish all the work, I concluded that:

- Making an Shiny app is easy and fun
- Using `rCharts` it's a little tricky
- Working with maps is fun and spectacular
- Sadly, I haven't made a prediction model

You can try my app on [this shinyapp link](https://miguel-angel-garcia.shinyapps.io/magShiny/).

Many thanks!

**Miguel Ángel García**
