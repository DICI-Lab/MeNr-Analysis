
###STARTING HERE###

#Clear global environment
rm(list=ls())

#Load the libraries
library(msa)
library(seqinr)

#Load data in Global Environment 
Protein <- read.csv("~/Desktop/XXXX.csv") #DIR#

-----------

#ALIGNMENT SEQUENCES
#Create a table with protein name associated to AA sequence
PROTseq <- Protein$Sequence
names(PROTseq) <- Protein$Name

#Create a vector with sequences and convert to AAStringSet
myAAseqs <- AAStringSet(PROTseq)

#Create an alignment using ClustaOmega
myAlignment <- msa(myAAseqs, "ClustalOmega")

------------

#H values per residue in PROTEIN    
#For Biostrings objects
aligned_strings <- as.character(unmasked(myAlignment))  
alignment_matrix <- do.call(rbind, strsplit(aligned_strings, ""))

#Transpose to get columns as positions
alignment_matrix <- t(alignment_matrix)

#Calculate entropy per position
calculate_entropy <- function(column) {
  freqs <- table(column) / length(column)
  -sum(freqs * log2(freqs), na.rm = TRUE)
}

#Entropy applied by row=1; applied by columns=2
H_values <- apply(alignment_matrix, 1, calculate_entropy) 

#Save as a csv file
write.csv(H_values, file="~/Desktop/XXXX_Hvalues.csv")

-----------

#Total H values normalized for each peptides  
#Convert reference sequence to character vector
ref_seq_split <- unlist(strsplit(aligned_strings, split = ""))

#Number of peptides (nonamers)
#"number of AA length sequence" - 9 (because nonamer)
num_peptides <- 350 #VAR#
#Nonamer
peptide_length <- 9 #VAR#

#Storage
positions <- 1:num_peptides
peptides <- character(num_peptides)
H_totals <- numeric(num_peptides)
H_totals_normalized <- numeric(num_peptides)
log20 <- log2(20)

#Loop through each peptide window
for (i in 1:num_peptides) {
  start_pos <- i
  end_pos <- i + peptide_length - 1
  peptide <- paste(ref_seq_split[start_pos:end_pos], collapse = "") #Get peptide
  peptides[i] <- peptide
  H_totals[i] <- sum(H_values[start_pos:end_pos]) #Get total H for the positions in the peptide
  H_totals_normalized[i] <- H_totals[i] / (peptide_length * log20) #Normalized H = average per residue
}

#Create table (3 for decimal)
peptide_table <- data.frame(
  Position = positions,
  Peptide = peptides,
  H_Tot_normalized = round(H_totals_normalized, 3) 
)


#Save as a csv file
write.csv(peptide_table, file="~/Desktop/XXXX_TotalHvalue.csv")

---------
  
#H values normalized per residue in protein (3 for decimal)  
log20 <- log2(20)
H_normalized_per_residue <- H_values / log20

position_index <- 1:length(H_normalized_per_residue)
entropy_df <- data.frame(
  Position = position_index,
  Normalized_Entropy = round(H_normalized_per_residue, 3)
)
  
# Plot entropy profile
  plot(H_normalized_per_residue, type = "l", xlab = "Position", ylab = "Normalized Shannon Entropy (H)", 
       lwd = 1.5,                     #VAR# #Line thickness
       col = "royalblue3",            #VAR# # Line color (can be a name or hex code)
       cex.lab = 1.5,                 #VAR# # Axis label size
       cex.axis = 1.2,                #VAR# # Axis tick label size
       font.lab = 2,                  #VAR# # Axis label font: 2 = bold
       font.axis = 2                  #VAR# # Axis tick font: 2 = bold
       )

  
#Save as a csv file
  write.csv(entropy_df, file = "~/Desktop/XXXX_normalized_entropy_per_position.csv", row.names = FALSE)

  