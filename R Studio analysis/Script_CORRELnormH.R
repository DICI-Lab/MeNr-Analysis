
###STARTING HERE###

#Clear global environment
rm(list=ls())

#Load the libraries
library(ggplot2)
library(ggpubr)

#Load data in Global Environment 
data <- read.csv("~/Desktop/XXXX.csv") #DIR#

-----------

#Replace Variable1, Variable2, and Group with your actual column names
data_clean <- data[complete.cases(data[c("Normalized_Total_H_value", "Total_Percentage_Conservation", "Genes")]), ]

#Correlation representation with two numeric columns
ggplot(data_clean, aes(x = Normalized_Total_H_value, y = Total_Percentage_Conservation, color = Genes)) +
  geom_point(size = 3) + 
  geom_smooth(method = "lm", se = FALSE, color = "black", size = 1.2) +
  
  stat_cor(aes(x = Normalized_Total_H_value, y = Total_Percentage_Conservation), # Global Spearman correlation (note: inherit.aes = FALSE ensures it's not grouped)
           method = "spearman",     #VAR# #Spearman: anormal distribution or non-parametric // Pearson: normal distribution or parametric 
           inherit.aes = FALSE,  
size = 4,                           #VAR# #font size of the Stat (R and pvalue)
fontface = "bold",                  #VAR# #font typography
label.x = 0.25,                     #VAR# #graph axis
label.y = 80,                       #VAR# #Graph axis
hjust = 1,                          #VAR# #left-align the text of the Stat (R and pvalue)
vjust = 0.1,                        #VAR# #align text to top of the Stat (R and pvalue)
color = "black") +                  #VAR# #color of the Stat (R and pvalue)
  
  
  # Custom colors for groups 
  scale_color_manual(values = c("ENV" = "steelblue",         #VAR#
                                "GAG" = "darkorange",        #VAR#
                                "POL" = "forestgreen",       #VAR#
                                "NEF" = "firebrick",         #VAR#
                                "VPR" = "mediumturquoise",   #VAR#
                                "VIF" = "orchid2",           #VAR#
                                "VPX" = "lightgoldenrod1",   #VAR#
                                "REV" = "maroon3")) +        #VAR#
  
  #Background & grid styling
  theme_minimal(base_size = 14) +                                              #VAR# 
  theme(
    plot.background = element_rect(fill = "white", color = NA),                #VAR#
    panel.background = element_rect(fill = "white", color = NA),               #VAR#
    panel.grid.major = element_line(color = "black", size = 0.3),              #VAR#
    panel.grid.minor = element_blank(),                                        #VAR#
    axis.text.x = element_text(size = 14, face = "bold", color = "black"),     #VAR#
    axis.text.y = element_text(size = 14, face = "bold", color = "black"),     #VAR#
    axis.title.x = element_text(size = 16, face = "bold", color = "black"),    #VAR#
    axis.title.y = element_text(size = 16, face = "bold", color = "black"),    #VAR#
    legend.position = "right"                                                  #VAR#
  ) 


