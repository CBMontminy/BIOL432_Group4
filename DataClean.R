library("readr")

Data=read_csv("Abundance_Data.csv")
str(Data)

#subset the full dataset to include only the treatments that we are analyzing
CombinedData<-Data[Data$treatment_id == "C3"|Data$treatment_id =="C5"|
                     Data$treatment_id =="C7"|Data$treatment_id =="C8"|
                     Data$treatment_id =="CD18"|Data$treatment_id =="CD23"|
                     Data$treatment_id =="HS37"|Data$treatment_id =="HS42"|
                     Data$treatment_id =="HS48"|Data$treatment_id =="NC"|
                     Data$treatment_id =="KC"|Data$treatment_id =="UT",]

#check dimensions of dataset
dim(CombinedData)

#remove NA's from dataset
CombinedData<-na.omit(CombinedData)

#check to see that some rows have been removed
dim(CombinedData)

write.csv(CombinedData)