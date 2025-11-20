# Nicole Phelan
# Spruce-a-Go-Go

# RDA Analysis

# Loading potential packages that I might need
library(vegan) # for plotting the RDA
library(geodata) # for accessing the worldclim data
library(raster) #for processing some spatial data
library(rnaturalearth) #for downloading shapefiles
library(sf) #for processing shapefiles
library(dplyr) #to keep things tidy
library(magrittr) #to keep things very tidy
library(ggspatial) #for scale bars and arrows
library(ggplot2) #for tidy plotting
library(ggpubr) #for easy selection of symbols

# Reading in the lat/long data
points <- read.csv("~/projects/eco_genomics_2025/group_project/mydata/colebrookSampleMetaData.csv")

# Cleaning the lat/long data
points %>% dplyr::select(Source, Latitude, Longitude,	Elevation) -> points

# Converting the lat/long data to points
pointsFiltered <- st_as_sf(points,coords = c(3,2), 
                          crs= '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0')

# Fetching the Worldclim variables for the various coordinates
climate_values <- terra::extract(worldclim_global(var = "bio", res = 2.5), pointsFiltered)

# Removing the ID numbers added by terra
climate_values <- climate_values[, -1]

# Combining the climate data with the geographical data points/elevation
pointsFiltered <- cbind(pointsFiltered,climate_values)

# Changing the Worldclim column names
names(pointsFiltered) <- gsub(".*bio_([0-9]+).*", "BIO\\1", names(pointsFiltered))

# Creating a regular dataframe without the geometry points
RemoveGeo <- st_drop_geometry(pointsFiltered)

# Creating a Correlation Plot of the Worldclim variables
library(corrplot)
RemoveGeo_scaled <- cbind(RemoveGeo[,1],scale(RemoveGeo[,2:21]))

# Remove duplicate rows
RemoveGeo_scaled <- unique(RemoveGeo_scaled)
# Renumbers each row by 1
rownames(RemoveGeo_scaled) <- NULL

corrplot(cor(RemoveGeo_scaled[,2:21]))

# Generating a PCA of the Worldclim variables and elevation
library(factoextra)
pca<-prcomp(RemoveGeo_scaled[,2:21], center = TRUE, scale. = TRUE)
group <- c("Elevation",rep("Temperature", 11), rep("Precipitation", 8))
var_explained <- pca$sdev^2 / sum(pca$sdev^2)
fviz_pca_var(pca, col.var = group, 
             palette = c("goldenrod","steelblue", "maroon"), 
             repel = TRUE,
             circle = F) + 
  labs(x = paste0("PC1 (", round(var_explained[1] * 100, 1), "%)"),
       y = paste0("PC2 (", round(var_explained[2] * 100, 1), "%)"),
       title = NULL,
       color = NULL)

# Reading in the hard genotypes
Genotypes<-read.table("~/projects/eco_genomics_2025/group_project/mydata/ANGSD/ANGSD_for_RDA_Poly.geno", na.strings ="-1")
Genotypes <- t(Genotypes[,-c(1:2)])
# Remove genotypes with more than 50% missing data
na_pop <- apply(Genotypes, 2, function(x) sum(is.na(x)))
Genotypes <- Genotypes[,(which(na_pop<47)+1)]

# imputing the median for remaining NAs
for (i in 1:ncol(Genotypes)){
  Genotypes[which(is.na(Genotypes[,i])),i] <- median(Genotypes[-(which(is.na(Genotypes[,i]))),i], na.rm=TRUE)
}

q=read.table("group_project/mydata/popcounts.txt")

# Making sure the Worldclim data frame has a row for each sample
RemoveGeo_95 <- left_join(q,as.data.frame(RemoveGeo_scaled))

# Running the RDA without the first few PC axes
Genos <- Genotypes
RDA = rda(Genos ~ BIO1 + BIO2 + BIO3 + BIO4 + BIO5 +
            BIO6 + BIO7 + BIO8 + BIO9 + BIO10 + BIO11 +
            BIO12 + BIO13 + BIO14 + BIO15 + BIO16 +
            BIO17 + BIO18 + BIO19 + Elevation, RemoveGeo_95[,2:21])
summary(RDA)
