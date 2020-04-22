library(tidyverse, pos = 3)
library(rvest, pos = 4)
library(RSelenium, pos = 5)
library(XML, pos = 6)

url <- "https://www.smogon.com/dex/ss/pokemon/"

rd <- rsDriver(browser = "firefox", port = 4561L)
remDr <- rd[["client"]]

remDr$navigate("https://www.smogon.com/dex/ss/pokemon/")

webElem <- remDr$findElement(using = 'css selector',
                             "#container > div > main > div > div > div:nth-child(1) > div.PokemonAltRow-name > a")

body <- remDr$findElement("css", "body")
body$sendKeysToElement(list(key = "home"))
body$sendKeysToElement(list(key = "space"))
body$screenshot(display = TRUE)
webElem <- remDr$findElement(using = 'css selector',
                             "#container > div > main > div > div > div:nth-child(1) > div.PokemonAltRow-name > a")
webElem$getElementAttribute("href")

doc <- htmlParse(remDr$getPageSource()[[1]])

info <- xpathApply(doc, "//script")[[4]]

elementos <- str_split(xmlValue(info), pattern = "\\,\\{")

bulb <- elementos[[1]][[10]]

# Ultimo elementos[[1]][1182]

pok <- str_split(bulb, pattern = "\\{")[[1]][2]
str_split(pok, pattern = "\\,")
