
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
NumericData=as.numeric(NumericData)
NumericData2=NumericData
NumericData2$C3=as.numeric(NumericData2$C3)
NumericData2$C8=as.numeric(NumericData2$C8)


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

ncol(NumericData2)
FinalData=cbind(Data[1], NumericData,NumericData2[7:21])
write.csv(FinalData, "FinalData.csv")
