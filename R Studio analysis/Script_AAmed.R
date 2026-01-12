
###STARTING HERE###

#Clear global environment
rm(list=ls())

#Load the libraries
library(msa)
library(Biostrings)
library(seqinr)
library(ape)

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
  
  
#CONSENSUS SEQUENCE    
#Extract and save the consensus sequence
PROT_Consensus <- msaConsensusSequence(myAlignment)
write.csv(PROT_Consensus, file="~/Desktop/XXXX_MAINConsensus.csv") #DIR#


------------
  
  
#IDENTITY MATRIX  
#Save the matrix of identity 
#Need to change n value according to the number of sequences analyzed 
  
PROTcons <- AAStringSet(myAlignment)

# Fill the matrix with percentage identity values
n <- length(PROTcons)
pid_matrix <- matrix(PROTcons, nrow = 5, ncol = 5)   #VAR# #Value dependent on the number of sequences analyzed


# Fill the matrix with percentage identity values
for (i in seq_len(5)) {
  for (j in seq_len(5)) {
    if (i <= j) {
      # Perform pairwise alignment between sequences i and j
      palign <- pairwiseAlignment(pattern = myAAseqs[i], subject = myAAseqs[j], 
                                  type = "global", substitutionMatrix = "BLOSUM62", 
                                  gapOpening = 3, gapExtension = 1)
      # Calculate the percentage identity
      pid_value <- pid(palign, type = "PID1")
      
      # Store theinst value in the matrix (both [i, j] and [j, i])
      pid_matrix[i, j] <- pid_value
      pid_matrix[j, i] <- pid_value
    }
  }
}

# Set the row and column names
rownames(pid_matrix) <- names(myAAseqs)
colnames(pid_matrix) <- names(myAAseqs)

write.csv(pid_matrix, file="~/Desktop/XXXX_IDENTmatrice.csv") #DIR#


------------


#CONSERVATION PERCENTAGE PER RESIDUE
#Score conservation per position (from msa alignment data)
alignment_biostrings <- as(myAlignment, "AAStringSet")
writeXStringSet(alignment_biostrings, filepath = "~/Desktop/XXXX_output_sequences.fasta") #DIR#
ConsScore1 <- readAAStringSet("~/Desktop/XXXX_output_sequences.fasta")  #DIR#

alignment_matrix <- as.matrix(ConsScore1)
num_sequences <- nrow(alignment_matrix)
alignment_length <- ncol(alignment_matrix)
conservation <- numeric(alignment_length)
for (i in 1:alignment_length) {
  residues <- alignment_matrix[, i]
  residues <- residues[residues != "-"]
  most_common_residue <- names(sort(table(residues), decreasing = TRUE))[1]
  conservation[i] <- sum(residues == most_common_residue) / length(residues) * 100
}

write.csv(conservation, "~/Desktop/XXXX_AAConservPercent.csv", row.names = FALSE)   #DIR#


-----------


  
#AA PHYLOGENETIC TREE (DISTANCE) 
#To see the distance between sequences
#Convert the alignment format to seqinr using msaConvert
alignment <- msaConvert(myAlignment, "seqinr::alignment")

#Compute the distance between the alignments
distMatrix <- dist.alignment(alignment, "similarity")

---
  
#SUPPLEMENTAL INFO: T oconvert to dataframe and save the matrix of distance
Mtrx <- as.data.frame(as.matrix(distMatrix))
write.csv(Mtrx, file="~/Desktop/XXXX_DIST-Matrix.csv")     #DIR#


-----------
  
  
#To classify and organize the clusters with colors
#Cluster the distance matrix using hclust (UPGMA), ape::nj (NJ) for phylotree
clustering <- nj(distMatrix)

#Transform into phylo object
phylotree = as.phylo(clustering)

#Plot as an phylogenetic tree
plot(phylotree,
     type = "phylogram",        #VAR# # Unrooted tree type
     cex = 0.3,                 #VAR# # Size of the tip labels
     edge.width = 1,            #VAR# # Thickness of the branches
     edge.color = "black",      #VAR# # Color of the branches
     tip.color = "black",       #VAR# # Color of the tip labels
     label.offset = 0.01,       #VAR# # Distance between labels and branches
     no.margin = TRUE,          #VAR# # Remove margins
     x.lim = c(-0.05, 0.4),    #VAR# # Limits for the x-axis
     y.lim = c(-0.15, 20.5),    #VAR# # Limits for the y-axis
)
add.scale.bar(length = 0.1, x = 0, y = -0.5)
nodelabels(cex = 0.15, bg = "black", frame = "cir")
tiplabels(cex = 0.1, bg = "red", frame = "cir", col = "red")


