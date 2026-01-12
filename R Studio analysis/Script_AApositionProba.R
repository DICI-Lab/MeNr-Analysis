
###STARTING HERE###

#Clear global environment
rm(list=ls())

#Load data in Global Environment 
pos1 <- read.csv("~/Desktop/XXXX.csv") #DIR#


-----------

#This dataframe (df) represents the amino acids found in position 1 of 76 different peptides. 
#Subsets of this list of peptides are listed in the remaining columns, and the frequency of specific residues at position 1 for these peptides are shown. 
#These subsets of the reference list of peptides are referred to as ID's (ID's: HLA.E, Mamu.E0211,...).
#We want to determine the following: For each amino acid in each ID column, if the ID values were random subsets of the REF column, 
#what are the odds that you would see that many amino acids present in that ID column?


#First, we need a function that takes in the frequency of a given AA in the REF column, the frequency of that amino acid in an ID column, 
#the total number of peptides in the REF column, and the total number of peptides in the ID column, and outputs the probability that 
#this exact number of that amino acid would be found in the ID column if the ID column was a random subset.
#The function is as follows: 
#choose((REF AA#),(ID AA#) * choose((REF Total - REF AA#),(ID Total - ID AA#)) / choose((REF Total), (ID Total))

f1 <- function(REFaa,IDaa,REFtotal,IDtotal) {
  choose((REFaa),(IDaa)) * choose((REFtotal - REFaa),(IDtotal - IDaa)) / choose((REFtotal),(IDtotal))
}

#Example: Testing this function (AA# = Q, f1(HLA-E vs REF) and f2(Mafa-E vs REF)):
#f1(4,3,76,38) 
#f2(8,7,76,75)


#We want to return a df with "odds of getting exactly this many of this AA"
#To create "empty" dfs that can be used for output, I have just been copying the pos1 df and deleting the REF column. 
#This will be populated with the integers from pos1 for now, but probabilities will override these values soon.
exact_pos1 <- pos1[,c(1,3:7)]

#let's say we just wanted to apply the function to every entry in the first ID column, HLA.E (column 2 of the dataframe)
#The following code has been commented out, but it helps explain some later code. 

# for(i in 2:21){
#   exact_pos1[i,2] <- f1(pos1$REF[i],pos1[i,2+1],pos1$REF[1],pos1[1,2+1])
# }
#This for loop  iterates from 2 to 21, which are the row numbers that give values for each amino acid. exact_pos[i,2] means the i'throw and second column. 
#For each row from 2:21, the f1 function is applied to the values in the HLA.E column. 
#pos1$REF[i] is the REFaa, 
#pos1[i,2+1] is the IDaa (to select the HLA.E column, we need to select column three, since the pos1 object has an additional REF column that exact_pos doesn't have. hence the 2+1), 
#pos1$REF[1] is the REFtotal (just 76), and pos1[1,2+1] is the IDtotal (again, this is still the HLA.E column. 
#now we are looking at its first row because that is where we get the total peptides)

#Now let's do this with a nested for loop, going across the columns from HLA.E to Common (columns 2-6 of exact_pos1)

for(x in 2:6){
  
for(i in 2:21){
  exact_pos1[i,x] <- f1(pos1$REF[i],pos1[i,x+1],pos1$REF[1],pos1[1,x+1])
  }
}
#This is the exact same as the commented-out for loop, but with every 2 replaced by x, which iterates across the ID columns.
#The resulting object shows the probability of that exact number of each amino acid appearing in the ID column.


#Now we need to add the probabilities of more extreme values. 

#For each possibility IDaa = 0, IDaa = 1, ... IDaa = REFaa, add up each where the probability is less than or equal to the actual P(IDaa). 
#After all, we want to know the odds of it being EQUALLY extreme OR MORE extreme than P(IDaa).

p_val_function <- function(REFaa,IDaa,REFtotal,IDtotal) {
  z <- 0
  for(i in 0:REFaa){
    if(f1(REFaa,i,REFtotal,IDtotal) <= f1(REFaa,IDaa,REFtotal,IDtotal)){ #For each possible value i that IDaa could theoretically take, we check if it's equally or less likely than the actual IDaa
    z <- z + f1(REFaa,i,REFtotal,IDtotal) #if so, add it to the running total
    }
  }
  z
}

#building an "empty" df
output_pos1 <- pos1[,c(1,3:7)]

#applying the p_val_function using a for loop. 
for(x in 2:6){
  for(i in 2:21){
    output_pos1[i,x] <- p_val_function(pos1$REF[i],pos1[i,x+1],pos1$REF[1],pos1[1,x+1])
  }
}

#write.csv(output_pos1, file="/Users/awh28/Desktop/output_pos1.csv")

#p values <= .05 are significant.

#NOTE:
#Take a look at the new output_pos1 dataframe. There's a lot of 1.000's. This actually makes sense. 
#If we zoom in and look at N for HLA.E, we see that 2 Ns were observed and 3 Ns are in the REF column. 
#This outcome has a 38% chance, which is the same chance as finding 1 N out of the 3. 1 N and 2 N are the center of the distribution curve, 
#and the tails are 0 N and 3 N at 12% chance each. This means every option is EQUALLY OR MORE extreme than finding 2 N. 
#Thus, the probability of a result equally or more extreme is 100%.

# f1(3,0,76,38)
# f1(3,1,76,38)
# f1(3,2,76,38)
# f1(3,3,76,38)


#All code

rm(list=ls())
pos1 <- read.csv("/Users/pmr16/Desktop/DataMHC-E/pMHC-E_PeptidePosition/ProbabilityScore/CSV/pMHC-E_Position1.csv")
f1 <- function(REFaa,IDaa,REFtotal,IDtotal) {
  choose((REFaa),(IDaa)) * choose((REFtotal - REFaa),(IDtotal - IDaa)) / choose((REFtotal),(IDtotal))
}
exact_pos1 <- pos1[,c(1,3:7)]


for(x in 2:6){
  
  for(i in 2:21){
    exact_pos1[i,x] <- f1(pos1$REF[i],pos1[i,x+1],pos1$REF[1],pos1[1,x+1])
  }
}

p_val_function <- function(REFaa,IDaa,REFtotal,IDtotal) {
  z <- 0
  for(i in 0:REFaa){
    if(f1(REFaa,i,REFtotal,IDtotal) <= f1(REFaa,IDaa,REFtotal,IDtotal)){ 
      z <- z + f1(REFaa,i,REFtotal,IDtotal) 
    }
  }
  z
}

output_pos1 <- pos1[,c(1,3:7)]

for(x in 2:6){
  for(i in 2:21){
    output_pos1[i,x] <- p_val_function(pos1$REF[i],pos1[i,x+1],pos1$REF[1],pos1[1,x+1])
  }
}

write.csv(output_pos1, file="~/Desktop/XXXX.csv") #DIR#


