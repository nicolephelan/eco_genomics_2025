# Population Genomics Notebook

## Fall 2025 Ecological Genomics

## Author: Nicole Phelan

This will keep my notes on population genomics coding sessions.

### 09/11/2025: Cleaning fastq reads of red spruce

-   I wrote a bash script called fastp.sh located within my GitHub repo:

`/~/projects/eco_genomics_2025/population_genomics/myscripts`

-   I used this script to trim out the adapters of the red spruce fastq sequence file.

-   The raw fastq files are located on the class share space:

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/fastq/red_spruce`

-   Using the program fastp, I processed the raw reads and output the cleaned reads to the following directory on the class shared space:

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/cleanreads`

-   Fastp produced reports for each sample, which I saved into the directory:

`/~/projects/eco_genomics_2025/population_genomics/myresults/fastp_reports`

-   The results showed high quality sequence with most Q-scores being \>\>20, and low amount of adapter contamination, which we trimmed out. We also trimmed out the leading 12 base pairs to get rid of the bar-code indices.

-   Cleaned reads are now ready to proceed to the next step in our pipeline: mapping to the reference genome.

### 09/16/2025: Mapping cleaned red spruce reads to the reference genome

-   I copied the bash scripts (bam_stats.sh, mapping.sh, and process_bam.sh) and text file (SBATCH_header.txt) from

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/scripts`

to

`/~/projects/eco_genomics_2025/population_genomics/myscripts`

-   I mapped my clean reads to the black spruce reference genome using bwa-mem2.

    -   I customized the `mapping.sh` file to use the `SBATCH_header.txt` and other details related to my specific population (2020) and directory pathways. I then ran this script using an sbatch command.

-   After mapping, I processed the sequence alignment (.sam) by converting them to binary alignment (.bam) using the `process_bam.sh` script.

    -   I made a wrapper file called `process_stats_wrapper` in `myscripts` folder to run both the `process_bam.sh` and `bam_stats.sh` at the same time using an sbatch command.

    -   The wrapper script was run using an sbatch command.

    -   The outputs for the bamstats are saved in `population_genomics/myresults/`

### 09/18/2025: Review bamstats and set up nucleotide diversity estimation using ANGSD

-   I wrote a short scripts called bamstats_review.R located in `myscripts` to evaluate the mapping success.

    -   I saw that roughly 66% of reads mapped in proper pairs.

    -   I obtained a depth of coverage between 2–3 X which suggests that I need to use a probabilistic framework for analyzing the genotype data.

-   I wrote two files called ANGSD.sh and ANGSD_doTheta.sh, and I combined them using a wrapper called diversity_wrapper.sh.

    -   The first script ANGSD.sh was written to estimate genotype likelihoods.

    -   The second script ANGSD_doTheta.sh was written to esimate nucleotide diversity (aka theta) using the sliding window approach. For this script, the window of 5000 was selected with no overlap.

    -   The wrapper script was run using sbatch, and the outputs are stored in `myresults/ANGSD/diversity`.

### 09/23/2025: Assessing nucleotide diversity

-   Trouble-shooting: I ran the cut command on the ANGSD_doTheta.sh file by editing the line to include the window and step commands.

-   I created an R Markdown file called Nucleotide_Diversity.Rmd for assessing the Pi and Watterson's theta values.

    -   Diversity is not concentrated in one distinct peak across the chromosome scaffold.

    -   Pi is larger than Theta W which means there are higher values of D and this might indicate a demographic effect.

-   I also added my results to the class spreadsheet.

### 09/25/2025: Estimating Fst with black spruce data set

-   R Markdown: I knitted the Nucleotide_Diversity.Rmd files to create the html file.

-   I created a new script called ANGSD_Fst.sh and I copied in the bash script with edits to tailor it to my population. It is saved to the `myscripts` folder.

    -   This script will calculate the Fst between my population (2020) of red spruce and the Wisconsin black spruce population.

    -   I also included the optional sliding window command in the script.

    -   I added my Fst value to the class spreadsheet, and I noticed that my population had a higher Fst value indicative of less introgression in my population.

    -   This Fst value makes sense for my population because it occurs further in the south.

-   I created a new script called PCAngsd_RSBS.sh that will make a PCA and admixture analysis using PCAngsd. This script is also saved to the `myscripts` folder.

    -   I created an R markdown file called PCA_Admixture.Rmd in `mydocs` to create a visual PCA and Admixture plot.

    -   As expected by the high Fst value, there was very little amounts of black spruce admixed into my population.

    -   I created a PCA with 95 red spruce samples and 18 black spruce samples (N=113 total).

    -   I used a beagle file in the class data share wit the genotype likelihoods already computed: ``` /gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ANGSD/``RSBS_poly.beagle.gz ```

    -   In the PCA, Population 2020 was also further separated from the northern admixed populations on PC2.

    -   Generally, admixture with black spruce seemed to increase with latitude (with the exception of Population 2021).

# 09/30/2025: Manipulating K Values

-   I modified the PCAngsd_RSBS.sh script to change the K value from 2 to 3. I also updated the PCA_Admixture.Rmd file and knitted a new html.

    -   There is slightly more variance explained by PC2 compared to when K=2.

-   I created a new script using the PCAngsd_RSBS.sh as the template and I saved it as PCAngsd_allRS_selection.sh in the /myscripts folder.

    -   In this file, I added in the scripts for selection, kept K=3 and removed the black spruce data set.

-   I created a new R markdown file in /mydocs called RedSpruce_Selection.Rmd to analyze the PCA of the new output that does not include the black spruce.

    -   After making the scree plot, I noticed that the variance explained in PC1 was much lower compared to the PCA with black spruce.

# 10/05/2025: Homework 1 Option B

-   I created a new bash script called Homework1_OptionB.sh where I copied the script from PCAngsd_RSBS.sh and modified it for this project. This script can be found following the path `~/projects/eco_genomics_2025/population_genomics/myscripts`
    -   In these edits, I created a new directory for saving my outputs found at the following path `~/projects/eco_genomics_2025/population_genomics/myresults/ANGSD/PCA_ADMIX/Homework1`
    -   I also modified the script to only include the red spruce data and not the black spruce data.
    - I added all of the K values as different comments in this script, and I commented each K value out except for the one I was running as I ran it.
    
