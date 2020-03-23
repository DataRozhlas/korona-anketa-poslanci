library(jsonlite)
library(readr)
library(magick)
library(dplyr)

data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT_OQKh28DDI-tlfcYLzyQzTEmTiiEzcKn3F-a3zMKCAqY9NhxUrxANy5EXZ24Qw1EcJXYR0Y1pdrkU/pub?gid=0&single=true&output=csv")

# ořízni fotky

for(i in data$f) {
  obr <- image_read(i)
  obr <- image_strip(obr)
  obr <- image_crop(obr, "201x201")
  obr <- image_resize(obr, "120")
  image_write(obr, paste0("../foto/", basename(i)), "jpg")
}

# udělej JSON

data <- data %>% select(1:8)
data$f <- basename(data$f)

write_json(data, path="../data/data.json", na="null")
