library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)
library(rworldmap)
library(scales)
library(sf)
library(mapdata)
library(maptools)
library(ggthemes)
library(ggspatial)

data(wrld_simpl)

antarctica <- wrld_simpl[wrld_simpl$NAME == "Antarctica", ]
pr <-
  "+proj=laea +lat_0=-90 +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0"
antarctica.laea <- spTransform(antarctica, CRS(pr))
antarctica.laea <- st_as_sf(antarctica.laea)

research_area <-
  data.frame(
    maxlat = -81.762,
    minlat = -82.586,
    maxlong = 57.725,
    minlong = 51.670
  )
study_side_point <-
  transform(
    research_area,
    laby = (maxlat + minlat) / 2,
    labx = (maxlong + minlong) / 2
  )

# gene world map
antarctica_plot <- ggplot() +
  geom_sf(data = antarctica.laea, color = '#37363B', lwd = 1) +
  geom_sf(data = antarctica.laea, fill = '#FEFEFE', lwd = 0) +
  geom_rect(
    aes(
      ymin = -82.586,
      ymax = -81.762,
      xmin = 51.670,
      xmax = 57.725
    ),
    color = "#ff6361",
    fill = 'transparent',
    label = 'Research area'
  ) +
  geom_point(
    aes(x = 0,
        y = -90),
    color = "#ff6361",
    shape = 16,
    size = 3,
    label = 'South pole'
  ) +
  geom_point(
    aes(x = 65.78333,
        y = -85.83333),
    color = "#ff6361",
    shape = 18,
    size = 3,
    label = 'Southern pole of inaccessibility'
  ) +
  labs(x = "Longitude", y = "Latitude") +
  annotation_scale(location = "bl", width_hint = 0.5) +
  annotation_north_arrow(
    location = "bl",
    which_north = "true",
    pad_x = unit(0.03, "in"),
    pad_y = unit(0.3, "in"),
    style = north_arrow_fancy_orienteering
  ) +
  coord_sf(default_crs = sf::st_crs(4326)) +
  ggtitle("Position of the research area at Antarctic") +
  theme_fivethirtyeight()

antarctica_plot + theme(
  plot.background = element_rect(fill = "transparent"),
  panel.background = element_rect(fill = "#62BDEC"),
  panel.grid.major=element_line(colour="#37363B", size=0.25)
)
