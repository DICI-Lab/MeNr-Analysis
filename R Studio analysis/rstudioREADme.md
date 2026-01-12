**SCRIPTS & SEQUENCES INFORMATION**

The R Studio script was executed on R studio version 4.2.2. Posit team (2025). RStudio: Integrated Development Environment for R. Posit Software, PBC, Boston, MA.

**Scripts description**
The scritps are associated to different amino acid sequence analyses: 
- `Script_AAalign`: to generate sequence alignment with weblogo.
- `Script_AAmed`: to generate phylogenetic tree/conservation amino acid sequence/ percentage of conservation sequence per residue. Script_AAmed was applied to compare the protein from different species or strains (threshold more permissive than AAstrg).
- `Script_AApositionProba`: to elucidate the foldchange (enrichment or depletion) of an amino acid in peptide specific position compared to the predicted list.
- `Script_AAstrg`: to generate phylogenetic tree/conservation amino acid sequence/ percentage of conservation sequence per residue. Script_AAmed was applied to compare the protein from the same specie or strain (threshold more strict than AAmed).
- `Script_CORRELnormH`: to correlate the normalized entropy with percentage of conservation.
- `Script_normH`: to calculate the normalized entropy in protein or peptide.



**Sequences description**
The sequences can be found into "CSV_AAcountPosition" and "CSV_Sequences" folders. These csv files can be used as template for other amino acid sequence analyses. As mentioned, each amino acid sequence is associated to script(s):

- `Script_AAalign` was used to analyze all the sequences files present into "CSV_Sequences" folder.
- `Script_AAmed` was used to analyze all "HSIVSeqsXXX.csv" files, "MHC-Eseqs.csv" file, "CD94seqs.csv" file, "DAP12seqs.csv" file, "NKG2Aseqs.csv" file and "NKG2Cseqs.csv" file (present into "CSV_Sequences" folder).
- `Script_AApositionProba` was used to analyze all the sequences files present into "CSV_AAcountPosition" folder.
- `Script_AAstrg` was used to analyze all "SIVmacSeqsXXX.csv" files, "HLA-Eseqs_1" file, "Mafa-Eseqs.csv" file, "Mamu-Eseqs_1.csv" file and "Mamu-Eseqs_2.csv" file (present into "CSV_Sequences" folder).
- `Script_CORRELnormH` was used to analyze all "HSIVSeqsXXX.csv" files, all "SIVmacSeqsXXX.csv" files and "Mamu-Eseqs_2" file (present into "CSV_Sequences" folder).
- `Script_normH` was used to analyze all "HSIVSeqsXXX.csv" files and all "SIVmacSeqsXXX.csv" files (present into "CSV_Sequences" folder).



To use the scripts, please read the READme file instruction found in the homepage of this repository.



