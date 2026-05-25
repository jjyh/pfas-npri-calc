#run in RStudio Console source("render.R")
library(quarto)
library(tidyverse)

dt_facilities <- read_excel(
  "data/PFAS-calculator.xlsx",
  sheet = "npri-facilities",
  trim_ws = TRUE,
  .name_repair = "minimal"
) %>% clean_names()

facilities <-
  dt_facilities |>
  distinct(facility) |>
  pull(facility) |>
  as.character()

reports <-
  tibble(
    input = "pfas-npri-long.qmd",
    output_file = str_glue("{facilities}.html"),
    execute_params = map(facilities, ~ list(facility = .))
  )

pwalk(reports, quarto_render)