# Group Project Notes

## Team Spruce-a-Go-Go

### Fall 2025 Ecological Genomics

### Author: Nicole Phelan

### 11/11/2025 Extracting the Climate Data for the Exome Capture Samples

-   In order to execute the function install.packages("geodata") and work with raster data, the Rstudio session needed to be run using Rgeospatial/4.5.1.
-   The geographic coordinates for each of the red spruce exome-capture samples were stored in a file called colebrookSampleMetaData.csv.
    -   This file was copied from the class repository to `~projects/eco_genomics_2025/group_project/mydata`.
-   An R script was created called RDA_Analysis.R in `~projects/eco_genomics_2025/group_project/myscripts`.
-   Using the 'geodata' package in R, a dataframe was generated for each of the exome-capture red spruce population coordinates, elevations, and WorldClim data

### 11/13/2025 Creating the PCA of the WorldClim Data

- In the RDA_Analysis.R file, I created a correlation plot and PCA of the WorldClim and elevation data for all coordinates of the samples in the exome-capture data set.