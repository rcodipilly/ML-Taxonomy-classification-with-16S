
#establishing input file and connection 
inputFile <- "ssu_all_r95.fna"
con  <- file(inputFile, open = "r")

#initializing empty vectors to store sequence header, taxonomic information, and sequence 
sequence_header <- c()
sequence <- c()
sequence_name <- c()
location <- c()
taxonomy <- c()
domain <- c()
phylum <- c()
class <- c()
family <- c()
genus <- c()
species <- c()
ssu_length <- c()
contig_length <- c()

blah <- c(1,2,3,4)


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

#sequence header currently contains name and taxonomic info - needs to be further split up 

#loop through sequence header so name, taxonomy, location, ssu length and contig length can be separated 
for (i in 1:length(blah)){
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








