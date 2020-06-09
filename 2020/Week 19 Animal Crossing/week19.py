import pandas as pd
import os
import plotly.express as px
from plotly.offline import plot

os.chdir('F:\\Documents\\Tidy-Tuesday\\2020\\Week 19 Animal Crossing')

critic = pd.read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/critic.tsv", sep = '\t')
user_reviews = pd.read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/user_reviews.tsv", sep = '\t')
items = pd.read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/items.csv")
villagers = pd.read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/villagers.csv")

pd.set_option("display.max_columns", None)
print(critic)

fig = px.scatter(data_frame = critic, x = "date", y = "grade")
fig.show()
plot(fig)

fig = px.bar(items.nlargest(10, 'buy_value'), x = "name", y = "buy_value")
plot(fig)

items['sell_percent'] = items.sell_value/items.buy_value
print(items)

fig = px.bar(items.nlargest(50, 'sell_percent'), x = "name", y = "sell_percent")

plot(fig)

items.name == 'Nook Inc. Aloha Shirt'
items.loc[items.name == 'K.K. Ballad']

print(villagers)




critic_reviews = list(critic.text)


