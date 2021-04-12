<<<<<<< HEAD
#1 - Creating a dataframe to store the fna file ----

#opening input file and  establishing connection 
inputFile <- "ssu_all_r95.fna"
con  <- file(inputFile, open = "r")

#initializing empty vectors to store sequence header, taxonomic information, location, lengths and sequence 
sequence_header <- c()
sequence <- c()
sequence_name <- c()
location <- c()
taxonomy <- c()
domain <- c()
phylum <- c()
class <- c()
order <- c()
family <- c()
genus <- c()
species <- c()
ssu_length <- c()
contig_length <- c()

#looping through text file to store the sequence headers and sequences separately
while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) {
    if(startsWith(oneLine, ">")) {
      sequence_header <- c(sequence_header, oneLine)
    }
    else {
      sequence <- c(sequence, oneLine)
    }
} 

close(con)

#sequence header currently contains name,taxonomic info, location and lengths - needs to be further split up 

#loop through sequence header so that name, taxonomy, location, ssu length and contig length can be separated 
for (i in 1:length(sequence_header)){
  split_header <- unlist(strsplit(sequence_header[i]," "))
  sequence_name <- c(sequence_name, split_header[1])
  taxonomy <- c(taxonomy, paste(split_header[2], split_header[3]))

    #further split taxonomy into each level 
    split_tax <- unlist(strsplit(taxonomy[i], ";"))
    domain <- c(domain, sub('...','',split_tax[1]))     #sub removes the first 3 charaacters, which was 'd__'
    phylum <- c(phylum, sub('...','',split_tax[2]))     
    class <- c(class, sub('...', '',split_tax[3]))
    order <- c(order, sub('...', '', split_tax[4]))
    family <- c(family, sub('...', '', split_tax[5]))
    genus <- c(genus, sub('...', '',split_tax[6]))
    species <- c(species, sub('...','',split_tax[7]))
    
  location <- c(location, split_header[4])
  ssu_length <- c(ssu_length, split_header[5])
  contig_length <- c(contig_length, split_header[6])
  i=i+1 
}

#store all the information in a single data frame 
ssu_r95_df <- data.frame(sequence_name, domain, phylum, class, order, family, genus, 
                         species, location, ssu_length, contig_length, sequence)

#store dataframe in a csv file 
write.csv(ssu_r95_df, file="ssu_r95_df.csv")

#2 - Randomly extract 9 strains from 3 different genus within Bacteria to pass through the kmer vectorizer ----

#create a vector of unique genus names to randomly select from 
genus_unique <- unique(ssu_r95_df$genus)

#only keep genus that have at least 3 sequences 
genus_unique_counts <- c()

for(i in 1:length(genus_unique)) {
  if(sum(ssu_r95_df$genus == genus_unique[i]) > 2){
    genus_unique_counts <- c(genus_unique_counts, genus_unique[i])
  }
  i=i+1
}

#randomly selecting 3 genus 
set.seed(1)
random_genus_3 <- sample(genus_unique_counts, 3)

#select 3 sequences from each of the genus - 9 total strains and save in a dataframe 
for (i in 1:length(random_genus_3)) {
  random_seqs <- ssu_r95_df[ssu_r95_df$genus == random_genus_3[i],]
  random_seqs3 <- random_seqs[sample(nrow(random_seqs),3),]
  random_sequences <- rbind(random_sequences, random_seqs3)
  i=i+1
}

#write randomly selected sequences into a csv file
write.csv(random_sequences, file="random_test_seqs.csv")

#randomly selecting 10 genus and all the strains from that 

#randomly selecting 10 genus 
set.seed(123)
random_genus_10 <- sample(genus_unique_counts, 10)

#looping through genus and getting all the sequences for the 10 selected genus 
for (i in 1:length(random_genus_10)) {
  random_seqs <- ssu_r95_df[ssu_r95_df$genus == random_genus_10[i],]
  random_sequences10 <- rbind(random_sequences10, random_seqs)
  i=i+1
}

#write selected sequences for 10 randomly selected genus into a csv file
write.csv(random_sequences10, file="random_test_seqs10.csv")


=======
#1 - Creating a dataframe to store the fna file ----

#opening input file and  establishing connection 
inputFile <- "ssu_all_r95.fna"
con  <- file(inputFile, open = "r")

#initializing empty vectors to store sequence header, taxonomic information, location, lengths and sequence 
sequence_header <- c()
sequence <- c()
sequence_name <- c()
location <- c()
taxonomy <- c()
domain <- c()
phylum <- c()
class <- c()
order <- c()
family <- c()
genus <- c()
species <- c()
ssu_length <- c()
contig_length <- c()

#looping through text file to store the sequence headers and sequences separately
while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) {
    if(startsWith(oneLine, ">")) {
      sequence_header <- c(sequence_header, oneLine)
    }
    else {
      sequence <- c(sequence, oneLine)
    }
} 

close(con)

#sequence header currently contains name,taxonomic info, location and lengths - needs to be further split up 

#loop through sequence header so that name, taxonomy, location, ssu length and contig length can be separated 
for (i in 1:length(sequence_header)){
  split_header <- unlist(strsplit(sequence_header[i]," "))
  sequence_name <- c(sequence_name, split_header[1])
  taxonomy <- c(taxonomy, paste(split_header[2], split_header[3]))

    #further split taxonomy into each level 
    split_tax <- unlist(strsplit(taxonomy[i], ";"))
    domain <- c(domain, sub('...','',split_tax[1]))     #sub removes the first 3 charaacters, which was 'd__'
    phylum <- c(phylum, sub('...','',split_tax[2]))     
    class <- c(class, sub('...', '',split_tax[3]))
    order <- c(order, sub('...', '', split_tax[4]))
    family <- c(family, sub('...', '', split_tax[5]))
    genus <- c(genus, sub('...', '',split_tax[6]))
    species <- c(species, sub('...','',split_tax[7]))
    
  location <- c(location, split_header[4])
  ssu_length <- c(ssu_length, split_header[5])
  contig_length <- c(contig_length, split_header[6])
  i=i+1 
}

#store all the information in a single data frame 
ssu_r95_df <- data.frame(sequence_name, domain, phylum, class, order, family, genus, 
                         species, location, ssu_length, contig_length, sequence)

#store dataframe in a csv file 
write.csv(ssu_r95_df, file="ssu_r95_df.csv")

#2 - Randomly extract 9 strains from 3 different genus within Bacteria to pass through the kmer vectorizer ----

#create a vector of unique genus names to randomly select from 
genus_unique <- unique(ssu_r95_df$genus)

#only keep genus that have at least 3 sequences 
genus_unique_counts <- c()

for(i in 1:length(genus_unique)) {
  if(sum(ssu_r95_df$genus == genus_unique[i]) > 2){
    genus_unique_counts <- c(genus_unique_counts, genus_unique[i])
  }
  i=i+1
}

#randomly selecting 3 genus 
set.seed(1)
random_genus_3 <- sample(genus_unique_counts, 3)

#select 3 sequences from each of the genus - 9 total strains and save in a dataframe 
for (i in 1:length(random_genus_3)) {
  random_seqs <- ssu_r95_df[ssu_r95_df$genus == random_genus_3[i],]
  random_seqs3 <- random_seqs[sample(nrow(random_seqs),3),]
  random_sequences <- rbind(random_sequences, random_seqs3)
  i=i+1
}

#write randomly selected sequences into a csv file
write.csv(random_sequences, file="random_test_seqs.csv")


>>>>>>> c44df4bbf58a9b273a2225a8877b592c5e0808b7
