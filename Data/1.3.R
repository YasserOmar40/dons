
# Author: Colin J. Carlson, Yasser Omar
# DONs versions: 1.1.0001 to 1.1.0002
# Content: fix the taxonomy of the outbreak disease names

library(tidyverse)

setwd("/Users/yasseromar/Desktop/dons/Data")

raw <- read_csv("/Users/yasseromar/Desktop/dons/Data/DON-1.3.0001.csv")

raw # Look at the data

raw %>% pull(`Pathogen`) %>% sort %>% unique # See the names

# This step below does the re-factoring. 

dictionary <-  c("Chikunguny" = "Chikungunya",
                 "Disease" = "Cholera",
                 "Japanese Ecephalitis" = "Japanese Encephalitis", 
                 "Meningococcal Disease" = "Meningitis",
                 "Rift Valley" = "Rift Valley Fever",
                 "Typhus Fever" = "Typhoid Fever",
                 "Unknown Illness" = "AUnknown") 

df %>% 
  mutate(var1 = str_replace(var1, " ", ""))
raw %>% mutate(`Disease/pathogen name` = recode(`Disease/pathogen name`, 
                                                !!!dictionary)) -> raw
raw %>% pull(`Disease/pathogen name`) %>% sort %>% unique # See the names
write.csv(raw,'DON-1.2.0001.csv')