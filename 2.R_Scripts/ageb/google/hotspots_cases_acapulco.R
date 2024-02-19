
# Step 1. load the dataset ####
load("/Users/fdzul/Dropbox/hotspots_2023/8.RData/denmex.RData")

# Step 2. extract the locality ####
x <- rgeomex::extract_ageb(locality = "Acapulco de Juarez", 
                           cve_edo = "12")


# Step 3. cases by AGEB ####
z <- denhotspots::point_to_polygons(x = xy,
                                    y = x$ageb,
                                    ids = names(x$ageb)[-10],
                                    time = ANO,
                                    coords = c("long", "lat"),
                                    crs = 4326,
                                    dis = "DENV") 

# Step 4. hotspots ####
hotspots <- denhotspots::gihi(x = z,
                              id = names(z)[c(1:9)], 
                              time = "year",
                              dis = "DENV",
                              gi_hi = "gi",
                              alpha = 0.95)

# Step 5. Static Map ####
denhotspots::staticmap_intensity(x = hotspots,
                                 pal = rcartocolor::carto_pal,
                                 pal_name = TRUE,
                                 name = "OrYel",
                                 breaks = 1,
                                 dir_pal = -1,
                                 x_leg = 0.5,
                                 y_leg = 0.1,
                                 ageb = TRUE)

# Step 6. Interactive Map ####
mapview::mapview(hotspots,
                 zcol = "intensity_gi",
                 layer.name = "Intensidad",
                 label = FALSE,
                 color = "white",
                 lwd = 0.5, 
                 col.regions =  rcartocolor::carto_pal(n = max(hotspots$intensity_gi), 
                                                       name = "OrYel"))