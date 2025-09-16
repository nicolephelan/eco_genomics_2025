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

Copy the bash scripts (bam_stats.sh, mapping.sh, and process_bam.sh) and text file (SBATCH_header.txt) from

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/scripts`

to

`/~/projects/eco_genomics_2025/population_genomics/myscripts`
