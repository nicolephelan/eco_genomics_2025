# Transcriptomics Module Notes

## Fall 2025 Ecological Genomics

## Author: Nicole Phelan

This is a place for me to keep my notes on my electronic/server activities during the transcriptomics module.

### 10/7/2025 Getting started with the module

-   On the first day of transcriptomics, I learned about the motivation and process of asking questions and analyzing RNA sequence data.

-   I started to run fastp to clean and visualize the data quality in my fastq files, but I ran into file recognition issues.

    -   To be continued on Thursday...

### 10/9/2025 Running fastp

-   I copied the fastp_tonsa.sh script from the `gpfs1/cl/ecogen/pbio6800/Transcriptomics/scripts` folder to `~/projects/eco_genomics_2025/transcriptomics/myscripts`.

    -   I edited the file to set my population to C2 and set my directory to my repository.

-   I copied the salmon_quant.sh script to `myscripts` similarly and I ran it in sbatch.

### 10/14/2025 Starting the DESeq2 Analysis

-   I reviewed the mapping rates and saw they were generally between 35% and 45%.
    -   I saved this to a txt file called mapping_rate.txt in `myresults` folder.
    -   It's possible low counts were the result of algal/microbe contamination or different clades of copepods.
-   I copied the txt files for the count_matrix.txt and metadata.txt into `mydata`
-   I prepped the quant.sf files to be imported into DESeq2
-   I analyzed the DESeq2 results in an Rmd file called DESeq2_notes.Rmd in `mydocs`

### 10/16/2025 PCA Analysis and Other Visualization

-   Continuing in the DESeq2 analysis, I generated two PCAs of the control vs. treatment data.
-   I then played around with plotting individual genes to see if the significant DEGs matched the contrast in the PCA.

### 10/21/2025 Continuation of DESeq2 Analysis Markdown

-   After struggling to open the DESeq2_notes.Rmd file, I learned that I need to wait ~2–5 minutes after opening it to use it in R Studio.
-   Once I had gotten my R Markdown file open, I started by creating an MA plot which showed the relationship between log fold change (LFC) and the magnitude of expression.
-   I made a Volcano plot of the LFC against the adjusted p-value for to identify which genes in the first generation where differentially expressed significantly.
    -   The significant genes were colored in red and blue.
-   I made a heat map of the 20 most significant genes and sorted them according to their p-values.
-   I then made a heat map showing just the significant genes from generation 1 and how they changed across generations.
    -   I saw from my results that there seemed to be an oscillation in up regulation and down regulation of the significant DEGs from generation 1 across each successive generation.
- Finally, I made a Euler plot for the first three generations.
    -   Generation 2 had the most unique DEGs between the control and treatment groups.
    -   It is possible this occurred because there were only 2 replicates for the control in generation 2.
    
### 10/23/2025 Running the GO Analysis

- I created a new R Markdown File in `mydocs` called DESeq2ToTopGO.Rmd for analyzing the GO data.
    -   I created plots of the adjusted p-value and Wald statistic using ggplot2.
- Using TopGo, I generated a plot of the significantly enriched genes in the transcriptome of generation 2.