# Step 1. load the geocoded dataset ####
load("/Users/fdzul/Dropbox/hotspots_2023/8.RData/denmex.RData")

# Step 2. Load the locality ####
x <- popmex::extract_pop(year = 2022, 
                         cve_edo = "14",
                         locality = c("Guadalajara", "Zapopan",
                                      "Tlaquepaque", "Tonalá"))

# Step 3. Count the cases by hexágons ####
library(magrittr)
z <- denhotspots::point_to_polygons(x = xy,
                                    y = x, ##
                                    ids = c("h3","population"), ###
                                    time = ANO,
                                    coords = c("long", "lat"),
                                    crs = 4326,
                                    dis = "DENV")
sf::st_geometry(z) <- "geometry"

# Step 4. Calculate the hotspots ####
hotspots <- denhotspots::gihi(x = z,
                              id = c("h3","population"), 
                              time = "year",
                              dis = "DENV",
                              gi_hi = "gi",
                              alpha = 0.95)

# Step 5. Vizualization of hotspots ####
hotspots |>
    denhotspots::staticmap_intensity(pal = rcartocolor::carto_pal,
                                     pal_name = TRUE,
                                     name = "OrYel",
                                     breaks = 1,
                                     dir_pal = -1,
                                     x_leg = 0.7,
                                     y_leg = 0.05,
                                     ageb = TRUE)  +
    ggplot2::theme(plot.margin = ggplot2::unit(c(0, 0, 0, 0), "cm")) +
    ggspatial::annotation_scale(style = "ticks")
