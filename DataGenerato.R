library("readr")

Data=read_csv("Abundance_Data.csv")
str(Data)

# pH Stress
pH_3=subset(Data,treatment_id=="C3")
pH_5=subset(Data,treatment_id=="C5")
pH_7=subset(Data,treatment_id=="C7")
pH_8=subset(Data,treatment_id=="C8")


# Temperature Stress
C18=subset(Data, treatment_id=="CD18")
C23=subset(Data, treatment_id=="CD23")
C37=subset(Data, treatment_id=="HS37")
C42=subset(Data, treatment_id=="HS42")
C48=subset(Data, treatment_id=="HS48")


# Osmolarity Stress
NaCl=subset(Data, treatment_id=="NC")
KCl=subset(Data, treatment_id=="KC")

# Control
UT=subset(Data, treatment_id=="UT")


pHDat=rbind(pH_3, pH_5, pH_7, pH_8)
TempDat=rbind(C18, C23, C37, C42, C48)
OsmoDat=rbind(NaCl, KCl)
Control=(UT)


MergeDat=rbind(pHDat, TempDat, OsmoDat, Control)
MergeDat

write.csv(MergeDat, file="MergeDat.csv")
