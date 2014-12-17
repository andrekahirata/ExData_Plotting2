#Carrega as bases
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

sectors <- levels(SCC$EI.Sector)[grep("Coal", levels(SCC$EI.Sector)[])]

SCC_coal <- factor(SCC[SCC$EI.Sector==sectors[1] | 
                   SCC$EI.Sector==sectors[2] |
                   SCC$EI.Sector==sectors[3],1])
NEI_coal <- data.frame(year=integer(),
                       Emissions=double())

for (i in 1:length(NEI$SCC)) {
      if (!is.na(match(NEI$SCC[i], SCC_coal))) {
            aux_df <- length(NEI_coal[,1])+1
            NEI_coal[aux_df,"year"] <- NEI$year[i]
            NEI_coal[aux_df,"Emissions"] <- NEI$Emissions[i]
      }
}

years <- c(1999, 2002, 2005, 2008)
sum_coal <- c()

for (year in years) {
      sum_coal <- append(sum_coal, sum(NEI_coal[NEI_coal$year==year, 2]))
}

png("plot4.png")

print(qplot(years, sum_coal, main = "USA PM2.5 Emissions from coal combustion-related sources", ylab = "yearly emissions"))

dev.off()