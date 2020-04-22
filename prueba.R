library(tidyverse, pos = 3)
library(rvest, pos = 4)
library(RSelenium, pos = 5)

rd <- rsDriver(browser = "firefox", port = 4561L)
remDr <- rd[["client"]]

url <- "https://www.smogon.com/dex/ss/formats/ou/"

remDr$navigate(url)

webElem <- remDr$findElements(using = "class", value = "PokemonAltRow")

ou_char <- webElem %>%
  lapply(function(x) x$getElementText()) %>%
  unlist()

ou_list <- ou_char %>%
  str_split(pattern = "\n") %>%
  lapply(function(x) c(x[1], x[str_detect(x, "OU|UU|RU|NU|PU")]))


# UU ------------------------------------------------------------

url <- "https://www.smogon.com/dex/ss/formats/uu/"

remDr$navigate(url)

webElem <- remDr$findElements(using = "class", value = "PokemonAltRow")

uu_char <- webElem %>%
  lapply(function(x) x$getElementText()) %>%
  unlist()

uu_list <- uu_char %>%
  str_split(pattern = "\n") %>%
  lapply(function(x) c(x[1], x[str_detect(x, "OU|UU|RU|NU|PU")]))


# RU ------------------------------------------------------------

url <- "https://www.smogon.com/dex/ss/formats/ru/"

remDr$navigate(url)

webElem <- remDr$findElements(using = "class", value = "PokemonAltRow")

ru_char <- webElem %>%
  lapply(function(x) x$getElementText()) %>%
  unlist()

ru_list <- ru_char %>%
  str_split(pattern = "\n") %>%
  lapply(function(x) c(x[1], x[str_detect(x, "OU|UU|RU|NU|PU")]))


# nu ------------------------------------------------------------

url <- "https://www.smogon.com/dex/ss/formats/nu/"

remDr$navigate(url)

webElem <- remDr$findElements(using = "class", value = "PokemonAltRow")

nu_char <- webElem %>%
  lapply(function(x) x$getElementText()) %>%
  unlist()

nu_list <- nu_char %>%
  str_split(pattern = "\n") %>%
  lapply(function(x) c(x[1], x[str_detect(x, "OU|UU|RU|NU|PU")]))


# pu ------------------------------------------------------------

url <- "https://www.smogon.com/dex/ss/formats/pu/"

remDr$navigate(url)

webElem <- remDr$findElements(using = "class", value = "PokemonAltRow")

pu_char <- webElem %>%
  lapply(function(x) x$getElementText()) %>%
  unlist()

pu_list <- pu_char %>%
  str_split(pattern = "\n") %>%
  lapply(function(x) c(x[1], x[str_detect(x, "OU|UU|RU|NU|PU")]))


# Tibble --------------------------------------------------------

nombres <- sapply(c(ou_list,
                    uu_list,
                    ru_list,
                    nu_list,
                    pu_list),
                  function(x) x[1])

tiers <- sapply(c(ou_list,
                    uu_list,
                    ru_list,
                    nu_list,
                    pu_list),
                  function(x) x[2])

dt_tiers <- tibble(name = nombres,
                   tier = tiers) %>%
  distinct()

