---
title: "DESeq2_tonsa_multigen"
author: "Nicole Phelan"
date: "2025-10-14"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(root.dir = "/users/n/m/nmphelan/projects/eco_genomics_2025/transcriptomics/mydata")
```

```{r}
## Import the libraries that we're likely to need in this session

library(DESeq2)
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(ggpubr)
library(vsn)  
library("pheatmap")
library("vsn")

####################################################

### Import our data

####################################################

 
# Import the counts matrix
countsTable <- read.table("counts_matrix.txt", header=TRUE, row.names=1)
head(countsTable)
dim(countsTable)

countsTableRound <- round(countsTable) # bc DESeq2 doesn't like decimals (and Salmon outputs data with decimals)
head(countsTableRound)

#import the sample description table
conds <- read.delim("metadata.txt", header=TRUE, stringsAsFactors = TRUE, row.names=1)
head(conds)
```

