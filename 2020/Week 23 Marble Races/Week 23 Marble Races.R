library(tidyverse)
library(lubridate)
library(tidytuesdayR)

tuesdata <- tt_load(2020, week = 23)

marbles <- tuesdata$marbles %>%
  mutate(date = str_replace_all(date, "-", " ")) %>%
  mutate(date = paste0(date, "20")) %>%
  mutate(date = as_date(dmy_h(date))) %>%
  group_by(race) %>%
  mutate(place = min_rank(time_s))

ggplot(marbles, aes(x = date, y = place, group = marble_name, color = marble_name)) +
  geom_line()

marble_poles <- marbles %>%
  filter(!is.na(pole))

ggplot(marble_poles, aes(x = date, y = place, group = pole, color = pole)) +
  geom_line() +
  labs(x = "Date of Race", y = "Finishing Position",
       title = "Does Starting Position affect Finishing Position?",
       subtitle = "Yes, the answer is obviously yes.") +
  theme_classic()
