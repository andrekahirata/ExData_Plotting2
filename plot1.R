#Carrega as bases
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

years <- c(1999, 2002, 2005, 2008)
yearlySum <- c()

for (i in years) {
      yearlySum <- append(yearlySum, sum(NEI[NEI$year == i, "Emissions"], na.rm=TRUE))
}

png(file="plot1.png")

plot(years, yearlySum, type="l", ylab="Total Yearly Emissions")

dev.off()