
require(ggplot2)
library(malariaAtlas)



### How to download empty map/districts ###
# how to download single country
KEN_shp <- getShp(ISO = "KEN", admin_level = c("admin0", "admin1"))

# how to download multiple countries (ex/ Lake victoria = Kenya, Tanzania, Uganda)
LV_shp <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = c("admin0", "admin1"))
LV_shp <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin0")

KEN_shp <- as.MAPshp(KEN_shp)
LV_shp <- as.MAPshp(LV_shp)

# view shapes
autoplot(KEN_shp)
autoplot(LV_shp)

# ISO is a string containing ISO3 code for desired country, e.g. c("XXX","YYY", ...) OR = "ALL". (Use one of country OR ISO OR continent, not combined)

#### available data layers (ex/ Pf, Pv, or Pk incidence rates or allele frequency in pop) and their sources ####
available_rasters <- listRaster()

available_shapes <- listData(datatype = "shape")


### How to plot with layers - Parasite rate ages 2 to 10 ##

#KEN_shp_1 <- getShp(ISO = "KEN", admin_level = "admin0")
LV_shp_1 <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin1")

#KEN_PfPR2_10 <- getRaster(surface = "Plasmodium falciparum PR2-10", shp = KEN_shp_1, year = 2015)
LV_PfPR2_10 <- getRaster(surface = "Plasmodium falciparum PR2-10", shp = LV_shp_1, year = 2015)

#KEN_PfPR2_10_df <- as.MAPraster(KEN_PfPR2_10)
LV_PfPR2_10_df <- as.MAPraster(LV_PfPR2_10)

#KEN_shp_df <- as.MAPshp(KEN_shp_1)
LV_shp_df <- as.MAPshp(LV_shp_1)

#p <- autoplot(KEN_PfPR2_10_df, shp_df = KEN_shp_df)
p <- autoplot(LV_PfPR2_10_df, shp_df = LV_shp_df)

# Add titles and scale bar description
p[[1]] +
  scale_size_continuous(name = "Survey Size")+
  scale_fill_distiller(name = "P. falciparum PR", palette = "RdYlBu")+
  ggtitle("Modelled P. falciparum Parasite Rate 
  in ages 2-10 in Lake Victoria 2015")


### Plasmodium falciparum Mortality Rate

LV_shp_1 <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin1")
LV_PfPR2_10 <- getRaster(surface = "Plasmodium falciparum Mortality Rate", shp = LV_shp, year = 2015)
LV_PfPR2_10_df <- as.MAPraster(LV_PfPR2_10)
p <- autoplot(LV_PfPR2_10_df, shp_df = LV_shp_df)

p[[1]] +
  scale_size_continuous(name = "Survey Size")+
  scale_fill_distiller(name = "Pf Mortality Rate", palette = "RdYlBu")+
  ggtitle("P. falciparum Mortality Rate in Lake Victoria 2015")


# Plasmodium falciparum Incidence
LV_shp_1 <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin1")
LV_PfPR2_10 <- getRaster(surface = "Plasmodium falciparum Incidence", shp = LV_shp_1, year = 2015)
LV_PfPR2_10_df <- as.MAPraster(LV_PfPR2_10)
p <- autoplot(LV_PfPR2_10_df, shp_df = LV_shp_df)

p[[1]] +
  scale_size_continuous(name = "Survey Size")+
  scale_fill_distiller(name = "P. falciparum Incidence Rate", palette = "RdYlBu")+
  ggtitle("P. falciparum Incidence Rate in Lake Victoria 2015")




#### Duffy Negativity Phenotype Frequency
LV_shp_1 <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin1")
LV_PfPR2_10 <- getRaster(surface = "Duffy Negativity Phenotype Frequency", shp = LV_shp_1)
LV_PfPR2_10_df <- as.MAPraster(LV_PfPR2_10)
p <- autoplot(LV_PfPR2_10_df, shp_df = LV_shp_df)

p[[1]] +
  scale_size_continuous(name = "Survey Size")+
  scale_fill_distiller(name = "Phenotype Frequency", palette = "RdYlBu")+
  ggtitle("Duffy Negativity Phenotype Frequency in Lake Victoria")




#### G6PD Deficiency Allele Frequency
LV_shp_1 <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin1")
LV_PfPR2_10 <- getRaster(surface = "G6PD Deficiency Allele Frequency", shp = LV_shp_1)
LV_PfPR2_10_df <- as.MAPraster(LV_PfPR2_10)
p <- autoplot(LV_PfPR2_10_df, shp_df = LV_shp_df)

p[[1]] +
  scale_size_continuous(name = "Survey Size")+
  scale_fill_distiller(name = "Allele Frequency", palette = "RdYlBu")+
  ggtitle("G6PD Deficiency Allele Frequency in Lake Victoria")



# HbS (Sickle Haemoglobin) Allele Frequency
LV_shp_1 <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin1")
LV_PfPR2_10 <- getRaster(surface = "HbS (Sickle Haemoglobin) Allele Frequency", shp = LV_shp_1)
LV_PfPR2_10_df <- as.MAPraster(LV_PfPR2_10)
p <- autoplot(LV_PfPR2_10_df, shp_df = LV_shp_df)

p[[1]] +
  scale_size_continuous(name = "Survey Size")+
  scale_fill_distiller(name = "Allele Frequency", palette = "RdYlBu")+
  ggtitle("HbS (Sickle Haemoglobin) Allele Frequency in Lake Victoria")



##### I DON'T THINK THE DATA FOR THESE DATASETS IS UP TO DATE OR COVERS MANY REGIONS #####

#### Walking-only travel time to healthcare map without access to motorized transport
LV_shp_1 <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin1")
LV_PfPR2_10 <- getRaster(surface = "Walking-only travel time to healthcare map without access to motorized transport", shp = LV_shp_1)
LV_PfPR2_10_df <- as.MAPraster(LV_PfPR2_10)
p <- autoplot(LV_PfPR2_10_df, shp_df = LV_shp_df)

p[[1]] +
  scale_size_continuous(name = "Survey Size")+
  scale_fill_distiller(name = "Travel time", palette = "RdYlBu")+
  ggtitle("Walking-only travel time to healthcare map without access to motorized transport in Lake Victoria")



#### Global travel time to healthcare map with access to motorized transport

LV_shp_1 <- getShp(ISO = c("KEN", "TZA", "UGA"), admin_level = "admin1")
LV_PfPR2_10 <- getRaster(surface = "Global travel time to healthcare map with access to motorized transport", shp = LV_shp_1)
LV_PfPR2_10_df <- as.MAPraster(LV_PfPR2_10)
p <- autoplot(LV_PfPR2_10_df, shp_df = LV_shp_df)

p[[1]] +
  scale_size_continuous(name = "Survey Size")+
  scale_fill_distiller(name = "Travel time", palette = "RdYlBu")+
  ggtitle("Travel time to healthcare map with access to motorized transport in Lake Victoria")









