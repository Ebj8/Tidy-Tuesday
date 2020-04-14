library(tidyverse)
library(tidytuesdayR)

tuesdata <- tt_load(2020, week = 16)

polls <- tuesdata$polls

rankings <- tuesdata$rankings