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

# Reading in the genomic data


# Cleaning the lat/long data
points %>% dplyr::select(Source, Latitude, Longitude,	Elevation) -> points
points <- unique(points)

# Converting the lat/long data to points
pointsFiltered <- st_as_sf(points,coords = c(3,2), 
                          crs= '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0')

# Fetching the worldclim variables for the various coordinates
climate_values <- terra::extract(worldclim_global(var = "bio", res = 2.5), pointsFiltered)

# Removing the ID numbers added by terra
climate_values <- climate_values[, -1]

# Combining the climate data with the geographical data points/elevation
pointsFiltered <- cbind(pointsFiltered,climate_values)

