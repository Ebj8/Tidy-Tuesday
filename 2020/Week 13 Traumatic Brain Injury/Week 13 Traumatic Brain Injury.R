library(tidyverse)
library(tidytuesdayR)
library(ggthemes)

setwd("F:/Documents/Tidy-Tuesday/2020/Week 13 Traumatic Brain Injury")

tuesdata <- tt_load(2020, week = 13)

tbi_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_age.csv')
tbi_year <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_year.csv')
tbi_military <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_military.csv')

tbi_age <- tbi_age %>%
  filter(!(age_group %in% c("0-17", "Total")))

tbi_year2 <- tbi_year %>%
  filter(injury_mechanism != "Total") %>%
  group_by(injury_mechanism, year) %>%
  summarise(rate_est = sum(rate_est)) %>%
  rename("Injury Type" = injury_mechanism)

ggplot() +
  geom_area(data = tbi_year2, aes(x = year, y = rate_est, fill = `Injury Type`)) +
  labs(x = "", y = "Rate per 100,000", title = "The Rate of Brain Injuries Sustained in the US Since 2006 is Increasing Due to Unintentional Falls",
       subtitle = "The rate of cases is measured in estimated people impacted per 100,000.\nData come from the CDC.",
       fill = "Injury Type") +
  theme_clean() +
  theme_economist() +
  theme(title = element_text(size = 14),
        axis.text = element_text(size = 12),
        legend.title = element_text("Injury Type"))

ggsave("Brain Injuries are increasing.jpg", units = "in", height = 9, width = 15)
