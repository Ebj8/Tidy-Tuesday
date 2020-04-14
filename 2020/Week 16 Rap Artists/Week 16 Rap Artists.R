library(tidyverse)
library(tidytuesdayR)
library(ggthemes)

setwd("F:/Documents/Tidy-Tuesday/2020/Week 16 Rap Artists")

tuesdata <- tt_load(2020, week = 16)

polls <- tuesdata$polls

rankings <- tuesdata$rankings

rankings_improved <- separate(rankings, col = artist, sep = " & ", into = c("artist1", "artist3","artist4")) %>%
  separate(., col = artist1, sep = " ft.", into = c("artist1", "artist2")) #separate all of the artists that contributed to each song

best_artists <- rankings_improved %>%
  select(artist1, artist2, artist3, artist4, n) %>% # selct the only coumns we care about (artists and number of votes they received)
  gather(value = "artist", key = "artist_number", -n) %>% # gather all of the artists into one column
  na.omit() %>% # remove NA's
  mutate(artist = str_trim(artist), # trim off blank space around artists
         artist = if_else(artist == "Snoop Doggy Dogg", true = "Snoop Dogg", false = artist)) %>% # renamed Snoop Doggy Dogg to Snoop Dogg
  group_by(artist) %>% # group each individual artist together
  summarise(count = sum(n)) %>% # sum up the number of votes each artist's songs got
  arrange(desc(count)) # arrange the artists in descending order


best_artists %>%
  filter(count > 2) %>% # ignore artists with only 2 or less votes
  ggplot() +
  geom_col(aes(x = reorder(artist, count), y = count), fill = "darkgrey") + # order bar chart by count of votes and color bars dark grey
  coord_flip() + # flip the x and y axes
  labs(title = "Most Popular Artists According to Rap Critics", # title the plot
       subtitle = "Represented by a count of how many times an artist's song was voted for by a critic", # subtitle the plot
       x = "", y ="Count") + # remove the x-axis label and re-label the y-axis
  theme_fivethirtyeight() + # add the fivethirtyeight theme from ggthemes
  theme(panel.background = element_rect(fill = "black"), # color the main plot panel background black
        plot.background = element_rect(fill = "black"), # color the rest of the background black
        plot.title = element_text(color = "white"), # color the title white
        plot.subtitle = element_text(color = "darkgrey"), # color the plot subtitle dark grey
        axis.title = element_text(color = "white"), # color the axis title white
        axis.text = element_text(color = "white")) # color the axis labels (artists and count numbers) white

ggsave("Most Popular Rap Artists.jpg", units = "in", width = 11, height = 8.5)
