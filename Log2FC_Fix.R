
library(dplyr)
library(tidyr)

Data=read.csv("CombinedData.csv")
Data=select(Data, c("gene", "treatment_id", "abundance_log2"))
names(Data)=c("Gene", "Treatment", "Abundance")

AvgDat= Data %>%
  group_by(Gene, Treatment) %>%
  summarize(AvgCount=mean(Abundance))


WideDat=AvgDat %>%
  pivot_wider(names_from="Treatment", values_from="AvgCount")

NumericData = WideDat[, c(2:7)]


for(i in 1:5) {
  for(j in (i+1):6) {
    colname= paste0("Log2FC_", names(NumericData)[i], "_", names(NumericData)[j])
    NumericData[[colname]]=NumericData[[i]] - NumericData[[j]]
  }
}

Data=cbind(WideDat[1], NumericData)
