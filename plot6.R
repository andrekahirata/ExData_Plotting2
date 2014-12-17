#Carrega as bases
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- NEI[NEI$fips=="24510",]
LACounty <- NEI[NEI$fips=="06037",]

Motor_vehicle <- SCC[SCC$Data.Category == "Onroad","SCC"]

years <- c(1999, 2002, 2005, 2008)

BaltMotor <- c()
LACMotor <- c()

for (y in years){
      yearSum <- 0
      for (i in Motor_vehicle) {
            yearSum <- yearSum + sum(Baltimore[Baltimore$SCC==i & Baltimore$year==y,"Emissions"])
      }
      BaltMotor <- append(BaltMotor, yearSum)
}

for (y in years){
      yearSum <- 0
      for (i in Motor_vehicle) {
            yearSum <- yearSum + sum(LACounty[LACounty$SCC==i & LACounty$year==y,"Emissions"])
      }
      LACMotor <- append(LACMotor, yearSum)
}

pm25 <- rbind.data.frame(data.frame(fips="06037", years=as.character(years), Emissions=LACMotor), 
                         data.frame(fips="24510", years=as.character(years), Emissions=BaltMotor))

levels(pm25$fips) <- c("Los Angeles County", "Baltimore City")

png("plot6.png")


g <- ggplot(pm25, aes(years, Emissions))

g + geom_point() +
    facet_wrap ( ~ fips) +
    scale_y_continuous(trans=log_trans()) +
    labs(y = "Emissions (log scale)")+
    labs(title="PM2.5 Motor Vehicle Emissions")

dev.off()