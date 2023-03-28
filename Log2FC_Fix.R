
library(dplyr)
library(tidyr)

Data=read.csv("CombinedData.csv")
Data=Data[c("gene", "treatment_id", "abundance_log2")]
names(Data)=c("Gene", "Treatment", "Abundance")



AvgDat= Data %>%
  group_by(Gene, Treatment) %>%
  summarize(AvgCount=mean(Abundance))


WideDat=AvgDat %>%
  pivot_wider(names_from="Treatment", values_from="AvgCount")
NumericData <- as.data.frame(WideDat[,2:7])
row.names(NumericData) <-  WideDat$Gene 


NumericData2=NumericData



for(i in 1:5) {
  for(j in (i+1):6) {
    colname= paste0("Log2FC_", names(NumericData)[i], "_", names(NumericData)[j])
    NumericData[[colname]]=NumericData[[i]] - NumericData[[j]]
  }
}






for (i in 1:5) {
  for (j in (i+1):6) {
    colname=paste0("P_", names(NumericData2)[i], "_", names(NumericData2)[j])
    NumericData2[[colname]]= pbinom(2^NumericData2[[i]], round(2^NumericData2[[i]] + 2^NumericData2[[j]]), p=0.5)
  }
}



FinalData=cbind(WideDat[1], NumericData,NumericData2[7:21])

nrow(WideDat)
nrow(FinalData)
write.csv(FinalData, "FinalData.csv")

