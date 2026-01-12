# MeNr introduction

The document describes the procedure to run the different analyses established in the manuscript "Non-human primate MHC-E variants play a critical role in natural killer cell activity in response to SIV-derived peptide repertoire". The organization of the document follows three distinctive chapters: (1) the softwares required to execute these analyses, (2) R Studio script analyses, and (3) PyMOL script analyses.


## Softwares required
**To generate sequence analyses** (amino acid sequence conservation, amino acid sequence alignment, matrice conservation, phylogenetic tree, normalized entropy, amino acid probability per position), the R Studio software must be installed. You will find the download access of R Studio software on: [R Studio website](https://posit.co/download/rstudio-desktop/). Download the software according to your system (Mac, Windows, Linux).

**To generate structure analysis** (RMSD calculation), the PyMOL by Schrödinger software must be installed. You will find the download access of PyMOL by Schrödinger software on: [PyMOL website](https://www.pymol.org/). Download the software according to your system (Mac, Windows, Linux).



## R Studio analyses

**To load a script in R Studio**, each scripts must be downloaded from the repository homepage. The script file (script_XXX.R) can be opened following the instructions: Open the script (double clic or right clic -> Open); or in R Studio software: File -> Open File... -> Select "script_XXX.R" -> Open .
All the scripts display mentions (#) symbol to indicate the function of the section, each sections are splitted by the symbol (------) and the symbol (#VAR#) represents when a value must be adapted to the raw data amino acid sequence analyzed. 

**For example:** 
`Raw data amino acid sequence is "MERLIN".
The script mentions that the length of peptide is 10 with "num_peptides <- 10 #VAR#", but the symbol indicated a just after the value means that this value must be adapted to the raw data amino acid sequence analyzed. 
In our example the length of peptide is 6 residues. Thus, the script must be adapted to the raw data amino acid sequence analyzed with "num_peptides <- 6 #VAR#".`

**Before to run the script**, all "Raw data amino acid sequence" files must be loaded in R Studio with the extention .csv and follow the template organization. The template organization can be found and downloaded from the repository homepage. Each template corresponds to a unique script indicated by the file name. Additionally, the directory pathway must be adapted to load the "Raw data amino acid sequence" in the R Studio global environment, as reminder, the symbol (#DIR#) is indicated to change the pathway.

**Specificity**: the section "Alignment" must be ran in



## PyMOL analyses
**Before to run the script**, all the structure files must be loaded in PyMOL with the extention .cif or .json. A folder containing different files (predicted struture from AlphaFold 3 and a script associated) are present in the repository homepage to be downloaded and run as an example. Additionally, the directory pathway must be adapted in the script to export the raw data value from the structures in the folder wished, as reminder, the symbol (#DIR#) is indicated to change the pathway. Also, the script displays other mentions such as (#) symbol that indicates the function of the paragraph and the symbol (#ID#) represents when a structure name must be adapted to the structure name analyzed in PyMOL. All the structure names are indicated in PyMOL or can be modified with the command "set_name old_name, new_name" in PyMOL. 

**For example:** `The structure named "Merlin1" wants to be changed into "Merlin2": "set_name Merlin1, Merlin2".`

**To run the PyMOL script in PyMOL**, the script must be downloaded from the repository homepage. The script file (script_XXX.py) can be opened following the instructions, in PyMOL software (following the structure was already loaded in PyMOL): File -> Run Script... -> Select "script_XXX.py" -> Open .



### Citations 
- R studio version 4.2.2. Posit team (2025). RStudio: Integrated Development Environment for R. Posit Software, PBC, Boston, MA.
- The PyMOL Molecular Graphics System, Version 3.1.3 by Schrödinger, LLC
-  Abramson, J et al. Accurate structure prediction of biomolecular interactions with AlphaFold 3. Nature (2024)


### Fundings
NIH, CFAR

