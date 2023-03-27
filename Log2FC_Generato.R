
data<-read.csv("CombinedData.csv")
unique(data$treatment_id)

library(dplyr)
library(tidyr)

df_mean <- data %>% 
  group_by(systematic_name, gene, treatment_id) %>% 
  summarize(abundance_log2 = mean(abundance_log2))

# reshape data frame to wide format
df_wide <- pivot_wider(df_mean, id_cols = c("systematic_name", "gene"), names_from = treatment_id, values_from = abundance_log2)

treatment_combinations <- combn(colnames(df_wide)[3:ncol(df_wide)], 2, simplify = FALSE)

# create data frame with log2FC values for each unique combination of two treatments
df_log2FC <- df_wide %>% 
  mutate(!!!setNames(lapply(treatment_combinations, function(x) {
    col1 <- x[1]
    col2 <- x[2]
    new_col <- paste0("log2FC_", col1, "_", col2)
    new_col_val <- (df_wide[[col2]] - df_wide[[col1]])
    return(new_col_val)
  }), sapply(treatment_combinations, paste, collapse = "_"))) 

# inspect the data frame
df_log2FC

write.csv(df_log2FC, "df_log2FC.csv")