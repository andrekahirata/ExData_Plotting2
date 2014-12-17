#Carrega as bases
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- NEI[NEI$fips==24510,]
LACounty <- NEI[NEI$fips==06037,]

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
            yearSum <- yearSum + sum(Baltimore[Baltimore$SCC==i & Baltimore$year==y,"Emissions"])
      }
      LACMotor <- append(LACMotor, yearSum)
}

Baltframe <- rbind(years, BaltMotor)
LACframe <- rbind(years, LACMotor)

png("plot6.png")

print(qplot(years, sumMotor, 
            main="PM2.5 Emissions from Motor Vehicle sources",
            ylab="Yearly Emissions"))

dev.off()