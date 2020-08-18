
# Author: Colin J. Carlson, Yasser Omar
# DONs versions: 1.1.0001 to 1.1.0002
# Content: fix the taxonomy of the outbreak disease names

library(tidyverse)

setwd("/Users/yasseromar/Desktop")

raw <- read_csv("/Users/yasseromar/Desktop/dons-master/Data/DON-1.1.0001.csv")

raw # Look at the data

raw %>% pull(`Disease/pathogen name`) %>% sort %>% unique # See the names

# This step below does the re-factoring. 

dictionary <-  c("Ebola" = "Ebola haemorrhagic fever",
                 "Yellow Fever" = "Yellow fever",
                 "Zika virus disease" = "Zika virus", 
                 "Acute diarrhoeal disease" = "Acute diarrhoea",
                 "Diarrhoeal diseases" = "Acute diarrhoea",
                 "Acute watery diarrhoeal syndrome" = "Acute diarrhoea",
                 "Acute watery diarrhoea" = "Acute diarrhoea",
                 "Acute haemorrhagic fever syndrome" = "Relapsing fever",
                 "Acute neurological syndrom" = "Acute neurological syndrome",
                 "Encephalitis" = "Acute neurological syndrome",
                 "Acute respiratory syndrome" = "Acute respiratory infection",
                 "Acute Respiratory Syndrome" = "Acute respiratory infection",
                 "Avian Influenza" = "Avian influenza",
                 "Chikingunya" = "Chikungunya",
                 "Cholera-like diarrhoeal disease" = "Cholera",
                 "Cholera/acute diarrhoea" = "Cholera",
                 "Cholera/diarrhoea" = "Cholera",
                 "Diarrhoeal disease/cholera" = "Cholera",
                 "Crimean-Congo Haemorragic Fever" = "Crimean-Congo hemorrhagic fever",
                 "Crimean-Congo haemorrhagic fever" = "Crimean-Congo hemorrhagic fever",
                 "Crimean-Congo heamorrhagic fever" = "Crimean-Congo hemorrhagic fever",
                 "cVDPV2s" = "cVDPV2",
                 "Acute haemorrhagic fever syndrom" = "Dengue fever",
                 "Dengue" = "Dengue fever",
                 "Dengue haemorrhagic fever" = "Dengue fever",
                 "Dengue Haemorrhagic fever" = "Dengue fever",
                 "Dengue/dengue haemorrhagic fever" = "Dengue fever",
                 "Dengue/Dengue haemorrhagic fever" = "Dengue fever",
                 "Haemorrhagic dengue fever" = "Dengue fever",
                 "Dengue Fever" = "Dengue fever",
                 "Acute Haemorrhagic Fever" = "Ebola haemorrhagic fever",
                 "Ebola haemorrhagic fever" = "Ebola haemorrhagic fever",
                 "EHF" = "Ebola haemorrhagic fever",
                 "EVD" = "Ebola haemorrhagic fever",
                 "Ebola Reston Virus (ERV)" = "Ebola Reston Virus", #is it different that the Ebola?
                 "Ebola-like Reston virus" = "Ebola Reston Virus",
                 "Ebola-Reston virus" = "Ebola Reston Virus",
                 "Enterovirus" = "Acute respiratory infection", #the same like the influenza!
                 "EV-D68" = "Acute respiratory infection", #the same like the influenza!
                 "E. Coli O157" = "E. coli O157",
                 "Food-borne intoxication" = "Food poisoning",
                 "Guillan-Barr\xe9 syndrome" = "Guillain-Barr\xe9 syndrome", #this line doesn’t work, I think because it's "Guillain-BarrÈ syndrome" in the original excel and the character "È" wasn't identified by R
                 "H5 avian infuenza" = "H5N1",
                 "A/H5 Avian Influenza" = "H5N1",
                 "A(H9N2)" = "H9N2",
                 "Haemorrhagic fever syndrome" = "Haemorrhagic fever",
                 "Haemorrhagic Fever" = "Haemorrhagic fever",
                 "Hantavirus disease" = "Hantavirus",
                 "Hantavirus Pulmonary Syndrome" = "Hantavirus",
                 "Hendra-like Virus" = "Nipah virus",
                 "Hendra-like Virus (Nipah virus)" = "Nipah virus",
                 "Acute hepatitis E" = "Hepatitis E",
                 "Influenza" = "Acute respiratory infection", #doesn't clarify which type of influenza
                 "Influenza A/H3N2" = "H3N2",
                 "Influenze A(H5)" = "H5N1", #not sure about this
                 "Japanese Encephalitis (JE)" = "Japanese encephalitis",
                 "Japanese Encephalitis" = "Japanese encephalitis",
                 "Lassa Fever" = "Lassa fever",
                 "Lead intoxication" = "Lead poisoning",
                 "Legionnaires' disease" = "Legionellosis",
                 "Legionnaires' Disease" = "Legionellosis",
                 "Leshmaniasis" = "Leishmaniasis",
                 "Listeriosis" = "Listeria",
                 "Marburg" = "Marburg haemorrhagic fever",
                 "Cerebrospinal meningitis" = "Meningitis", #check the outbreak of Meningitis!
                 "Meningococcal disease" = "Meningitis",
                 "Meningococcal disease, serogroup W135" = "Meningitis",
                 "Meningococcal infection" = "Meningitis",
                 "Meningococcal meningitis" = "Meningitis",
                 "Meningococcemia-like illness" = "Meningitis",
                 "Meninococcal disease" = "Meningitis",
                 "Meningococcal Disease" = "Meningitis",
                 "Meninococcal septicaemia" = "Meningitis",
                 "Meningococcal Meningitis" = "Meningitis",
                 "MVD" = "Marburg haemorrhagic fever",
                 "nCoV" = "MERS-CoV",
                 "Nipah-like virus" = "Nipah virus",
                 "Plague" = "Bubonic Plague", #not sure they are the same!
                 "Pneumonia of unknown cause" = "Covid19",
                 "Novel Coronavirus" = "Covid19",
                 "Poliomelitis" = "Polio",
                 "Poliomyelitis" = "Polio",
                 "RVF" = "Rift Valley fever",
                 "Rift Valley Fever" = "Rift Valley fever",
                 "S-OtrH3N2" = "H3N2",
                 "Salmonella Agona" = "Salmonellosis", #not sure
                 "Salmonella Enteritidis" = "Salmonellosis", #not sure
                 "Shigella" = "Salmonellosis",
                 "Shigella dysenteriae type 1" = "Shigellosis",
                 "Staphylococcal food intoxication" = "Food poisoning",
                 "Sylvatic yellow fever" = "Yellow fever",
                 "Typhoid Fever" = "Typhoid fever",
                 "Undiagnosed Febrile Illness" = "Ebola haemorrhagic fever",
                 "Viral haemorrhagic fever" = "Marburg haemorrhagic fever",
                 "Viral haemorrhagic fever/Marburg" = "Marburg haemorrhagic fever",
                 "Viral meningitis" = "Meningitis",
                 "West Nile virus" = "West Nile fever",
                 "WNV" = "West Nile fever",
                 "unknown" = "Unknown") 

raw %>% mutate(`Disease/pathogen name` = recode(`Disease/pathogen name`, 
                                                !!!dictionary)) -> raw
raw %>% pull(`Disease/pathogen name`) %>% sort %>% unique # See the names

