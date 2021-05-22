library(Biostrings)
library(tidyverse)
library(here)

fishcard_fasta <- readDNAStringSet(file = here("Data","local_database","Reference_db","trimmed","fishcard_12S_all_.fasta"))
fishcard_taxonomy <- read.table(file = here("Data","local_database","Reference_db","trimmed","fishcard_12S_all_taxonomy.txt"), sep="\t")
CA_fishes <- read.csv(file = here("Data","CA_fish_species","CA_fish_list_20210216.csv" ), header = T)
names(fishcard_fasta) %>% as_tibble() -> fishcard_fasta_accessions


#Which species are missing from taxonomy file
setdiff(fishcard_fasta_accessions$value,fishcard_taxonomy$V1 ) -> fishcard_accessions_without_taxonomy

#Which species are missing from the fasta file
setdiff(fishcard_taxonomy$V1,fishcard_fasta_accessions$value )
setdiff(fishcard_fasta_accessions$value,fishcard_taxonomy$V1)


c19_fasta <- readDNAStringSet(file = here("Data","global_database","Reference_db","trimmed","c19_fishcard_.fasta"))
c19_taxonomy <- read.table(file = here("Data","global_database","Reference_db","trimmed","c19_fishcard_taxonomy.txt"), sep="\t")
names(c19_fasta) %>% as_tibble() -> c19_fasta_accessions


#Check if there are CA species in Global not in Local
c19_taxonomy %>% 
  separate(V2, into = c("D","P","C","O","F","G","S"), sep=";", remove=FALSE) %>% 
  filter(., S %in% CA_fishes$Walker_Miller_Lea_Combo_20210216) -> global_db_CA_fishes

setdiff(global_db_CA_fishes$V1, fishcard_taxonomy$V1) -> CCLME_fishes_to_be_added_local_db


#Which species are missing from taxonomy file
setdiff(c19_fasta_accessions$value,c19_taxonomy$V1) -> c19_accessions_without_taxonomy
#Which species are missing from the fasta file
setdiff(c19_taxonomy$V1,c19_fasta_accessions$value )

genbank_fasta <- readDNAStringSet(file = here("Data","genbank_database","Reference_db","trimmed","12S_Oct2019_.fasta"))
genbank_taxonomy <- read.table(file = here("Data","genbank_database","Reference_db","trimmed","12S_Oct2019_taxonomy.txt"), sep="\t")

#genbank_taxonomy %>% 
#  mutate(., V2 =str_replace_all(V2, ";NA;",";;")) ->genbank_taxonomy

#write.table(genbank_taxonomy, file = here("Data","genbank_database","Reference_db","trimmed","12S_Oct2019_taxonomy.txt"), row.names = FALSE,sep="\t",col.names = FALSE, quote = FALSE)


names(genbank_fasta) %>% as_tibble() -> genbank_fasta_accessions

#Which species are missing from taxonomy file
setdiff(genbank_fasta_accessions$value,genbank_taxonomy$V1 )
#Which species are missing from the fasta file
setdiff(genbank_taxonomy$V1,genbank_fasta_accessions$value )

#Are missing taxonomies in the GenBank DB?
setdiff(c19_accessions_without_taxonomy,genbank_taxonomy$V1 )
setdiff(fishcard_accessions_without_taxonomy,genbank_taxonomy$V1 )
#Yes they are, somehow you messed up and did not manage to get all of these taxonomies into the file...

genbank_taxonomy %>% 
  filter(., V1 %in% fishcard_accessions_without_taxonomy) %>% 
  separate(V2, into = c("D","P","C","O","F","G","S"), sep=";")-> missing_fishcard_accessions

genbank_taxonomy %>% 
  filter(., V1 %in% c19_accessions_without_taxonomy) %>% 
  separate(V2, into = c("D","P","C","O","F","G","S"), sep=";")-> missing_c19_accessions



#The issue is actually that you did not filter the fasta to remove these sequences that are not CA
setdiff(missing_fishcard_accessions$S, CA_fishes$Walker_Miller_Lea_Combo_20210216)

#Fixes
#The fishcard database needs to have the fasta sequences removed
fishcard_fasta[fishcard_taxonomy$V1] -> new_fishcard_fasta
writeXStringSet(new_fishcard_fasta, file = here("Data","local_database","Reference_db","trimmed","fishcard_12S_all_.fasta"), format = "fasta")


#Need to Add CCLME fishes with latest list
c19_fasta[CCLME_fishes_to_be_added_local_db] -> fishcard_missing_fasta


c(fishcard_fasta,fishcard_missing_fasta) -> combined_fishcard_fasta
names(combined_fishcard_fasta) -> combined_fishcard_fasta_accessions
c19_taxonomy %>% 
  filter(., V1 %in% CCLME_fishes_to_be_added_local_db) -> fishcard_missing_taxonomies

rbind(fishcard_taxonomy, fishcard_missing_taxonomies) -> new_fishcard_taxonomy

setdiff(combined_fishcard_fasta_accessions,new_fishcard_taxonomy$V1) 
setdiff(new_fishcard_taxonomy$V1,combined_fishcard_fasta_accessions)
writeXStringSet(combined_fishcard_fasta, file = here("Data","local_database","Reference_db","trimmed","fishcard_12S_all_.fasta"), format = "fasta")
write.table(new_fishcard_taxonomy, file = here("Data","local_database","Reference_db","trimmed","fishcard_12S_all_taxonomy.txt"), row.names = FALSE,sep="\t",col.names = FALSE, quote = FALSE)


#C19 taxonomy file needs to have all the taxonomy
#genbank_taxonomy %>% 
#  filter(., V1 %in% c19_accessions_without_taxonomy) -> c19_missing_taxonomies

#rbind(c19_taxonomy, c19_missing_taxonomies) -> new_c19_taxonomy
#setdiff(c19_fasta_accessions$value,new_c19_taxonomy$V1 ) 
#setdiff(new_c19_taxonomy$V1,c19_fasta_accessions$value ) 

c19_taxonomy %>% as_tibble() %>% 
  mutate(., V2 = str_replace_all(V2, ";NA;",";;")) %>% 
  distinct()  -> new_c19_taxonomy


write.table(new_c19_taxonomy, file = here("Data","global_database","Reference_db","trimmed","new_c19_fishcard_taxonomy.txt"), row.names = FALSE,sep="\t",col.names = FALSE, quote = FALSE)

#Remove sequences from Fasta File
c19_fasta[new_c19_taxonomy$V1] -> new_c19_fasta
setdiff(names(c19_fasta),names(new_c19_fasta))
writeXStringSet(new_c19_fasta, file = here("Data","global_database","Reference_db","trimmed","new_c19_fishcard_.fasta"), format = "fasta")


#SRA Accession
submission_fasta <- readDNAStringSet(file = here("Data","local_database","Reference_db","trimmed","SRA_sequence_submission.fasta"))
submission_accessions<- read.table(file = here("Data","local_database","Reference_db","trimmed","final_accesions.csv"), sep=",")
names(submission_fasta) %>% as_tibble() -> submission_fasta_accessions

submission_fasta_accessions %>%  filter(., value %in% submission_accessions$V1) -> to_keep
submission_fasta[to_keep$value] -> submission_fasta
writeXStringSet(submission_fasta, file = here("Data","local_database","Reference_db","trimmed","SRA_sequence_submission.fastq"), format = "fastq")
writeXStringSet(submission_fasta, file = here("Data","local_database","Reference_db","trimmed","SRA_sequence_submission.fasta"), format = "fasta")



submission_fasta <- readDNAStringSet(file = here("Data","local_database","Reference_db","trimmed","SRA_sequence_submission.fasta"))
submission_accessions<- read.table(file = here("Data","local_database","Reference_db","trimmed","final_accesions.csv"), sep=",")
names(submission_fasta) %>% as_tibble() -> submission_fasta_accessions

submission_fasta_accessions %>%  filter(., value %in% submission_accessions$V1) -> to_keep
submission_fasta[to_keep$value] -> submission_fasta
i=1
for (i in 1:length(to_keep$value)) {
  writeXStringSet(submission_fasta[to_keep$value[[i]]], file = here("Data","local_database","Reference_db","trimmed","SRA",paste0(to_keep$value[[i]],".fastq")), format = "fastq")
}
