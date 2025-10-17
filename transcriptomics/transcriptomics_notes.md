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

### 10/14/2025 

-   I reviewed the mapping rates and saw they were generally between 35% and 45%.
    -   I saved this to a txt file called mapping_rate.txt in `myresults` folder.
    -   It's possible low counts were the result of algal/microbe contamination or different clades of copepods.
-   I copied the txt files for the count_matrix.txt and metadata.txt into `mydata`
-   I prepped the quant.sf files to be imported into DESeq2
-   I analyzed the DESeq2 results in an Rmd file called DESeq2_notes.Rmd in `mydocs`