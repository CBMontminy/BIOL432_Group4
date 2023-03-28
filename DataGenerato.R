library("readr")

Data=read_csv("Abundance_Data.csv")
str(Data)

#subset the full dataset to include only the treatments that we are analyzing
CombinedData<-Data[Data$treatment_id == "C3"|Data$treatment_id =="C8"|
                     Data$treatment_id =="CS23"| Data$treatment_id =="HS42"|
                     Data$treatment_id =="NC"|Data$treatment_id =="UT",]

dim(CombinedData)

CombinedData<-na.omit(CombinedData)

dim(CombinedData)

write.csv(CombinedData, 'CombinedData.csv')