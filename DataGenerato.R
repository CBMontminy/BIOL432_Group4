library("readr")

Data=read_csv("Abundance_Data.csv")
str(Data)

# pH Stress
pH_3=subset(Data,treatment_id=="C3")
pH_5=subset(Data,treatment_id=="C5")
pH_7=subset(Data,treatment_id=="C7")
pH_8=subset(Data,treatment_id=="C8")


# Temperature Stress
"18C"=subset(Data, treatment_id=="CD18")
"23C"=subset(Data, treatment_id=="CD23")
"37C"=subset(Data, treatment_id=="HS37")
"42C"=subset(Data, treatment_id=="HS42")
"48C"=subset(Data, treatment_id=="HS48")

# Osmolarity Stress
NaCl=subset(Data, treatment_id=="NC")
KCl=subset(Data, treatment_id=="KC")

# Control

UT=subset(Data, treatment_id=="UT")


pHDat=rbind(pH_3, pH_5, pH_7, pH_8, UT)
TempDat=rbind("18C", "23C", "37C", "42C", "48C", UT)
OsmoDat=rbind(NaCl, KCl, UT)
write.csv(pHDat, file="pHDat.csv")
write.csv(TempDat, file="TempDat.csv")
write.csv(OsmoDat, file="OsmoDat.csv")
