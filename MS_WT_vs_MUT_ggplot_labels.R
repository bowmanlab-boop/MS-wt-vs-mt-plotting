#script that plots two MS experiments against each other.
#Plotted on a log10 scale. Point below a given threshold are plotted along the 
#corresponding axis.
#Input is a list of wt values, mt values and correspondings protein IDs.
#In the example below, H3_norm is a csv file exported from Scaffold and modified in excel.

#Variables
a <- H3_norm$WT               # Wild type values
b <- H3_norm$HB               # Mutant values
ID <- H3_norm$Alternate.ID    # IDs for the labels
xl <-"mutant (log10)"         # x axis label
yl <- "wild type (log10)"     # y axis label
t<- 1e+06                     # lower value threshold for plotting

# Createing dataframe to simplify plotting. pmax used to define lower thresholds.
WT <- pmax(a, t)
MT<- pmax(b, t)
df<- data.frame(ID, WT, MT) 
#Load ggplot2
library(ggplot2)
#plotting
p <- ggplot(df, aes(x = log10(MT), y = log10(WT))) + 
  xlab(xl) + ylab(yl) +
  geom_point(shape = 20, color="gray20") +
  theme(panel.border = element_rect(colour = "black", fill=NA), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank())
#labelling points - densly clustered points are not labelled due to too much overlap.
#Works well with the MS data as only the extraneous (interesting) points become labelled
require("ggrepel")
set.seed(10)
p + geom_text_repel(data = df, aes(label = ID))



