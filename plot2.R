#Carrega as bases
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- c()
years <- c(1999, 2008)

for (i in years){
      Baltimore <- append(Baltimore, 
                          sum(NEI[NEI$fips==24510 
                                  & NEI$year==i,"Emissions"]))
}

png(file="plot2.png")

barplot(Baltimore, years, 
        main="Total emissions from PM2.5 in Baltimore",
        names.arg = as.character(years))

dev.off()