#Carrega as bases
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

Baltimore <- NEI[NEI$fips==24510,]

years <- names(table(Baltimore$year))
types <- names(table(Baltimore$type))

pm25 <- data.frame(year=integer(),
                   type=character(),
                   pm25=double(),
                   stringsAsFactors=FALSE)

for (i in years){
      for (n in types){
            aux <- length(pm25[,1]) + 1
            pm25[aux,1] <- as.integer(i)
            pm25[aux,2] <- n
            pm25[aux,3] <- as.double(sum(Baltimore$Emissions[Baltimore$year==i & 
                                                                  Baltimore$type==n]))
      }
}


png(file="plot3.png")

print(ggplot(pm25, aes(year, pm25)) + geom_point() + facet_wrap( ~ type, ncol=2 ))

dev.off()