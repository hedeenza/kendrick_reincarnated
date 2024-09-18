# Packages
library(tidyverse)
library(rvest)

# Lyrics (https://genius.com/Kendrick-lamar-not-like-us-video-version-lyrics)
#[Part I: Reincarnated / Mr. Get Off / Broccoli]
#
#[Verse]
#Ha-ha-ha-ha-ha-ha-ha-ha
#I am reincarnated (Ha-ha-ha-ha-ha-ha-ha-ha)
#I was stargazing (Ha-ha-ha-ha)
#Life goes on, I need all my babies (Gyah, gyah)
#Woke up, lookin' for the broccoli
#Hot key, keep a horn on me, that Kamasi
#IP ownership, the blueprint is by me
#Mr. Get Off, I get off at my feet'

# Proposed songs
songs <- 
  tribble(
    ~Song, ~Album, ~Artist, 
    'Reincarnated', 'Yes', 'Jdot Breezy',
    'Ima', '', 'Comrade',
    'STARGAZING', 'Yes', 'Travis Scott',
    'Life Goes On', '', '2Pac',
    'I Need', '', 'Croosh',
    'All My Babies', '', 'Tez the Don',
    'Woke Up', 'Yes', 'prodbysky',
    'Lookin', '', 'Playboi Carti, Lil Uzi Vert',
    'FOR THE', '', 'Kay Vibes',
    'Broccoli', '', 'DRAM, Lil Yachty',
    'Hot (feat. Gunna)', '', 'Young Thug, Gunna',
    'Key', '', 'DJ Lykewize, Gucci Mane',
    'Keep', 'yes', 'Rum Jungle',
    'A Horn', '', 'Stan Kenton',
    'On Me', 'yes', 'Lil Baby',
    'That', '', 'OJ Da Juiceman, DJ Drama',
    'Kamasi', '', '8R, Brudi Allen',
    'IPP', '', 'LSC',
    'Ownership', '', 'King Dif, Milky Fella',
    'The Blueprint', '', 'JAY-Z',
    'Is By', '', 'Solo Piano',
    'Me', '', 'Chief Keef, DJ Scream, Tadoe',
    'Mister', 'yes', 'Rich Homie Quan',
    'Get Off', 'yes', 'ian',
    'I Get Off', '', 'Boosie Badazz, Whop Bezzy',
    'At', '', 'Anuahyahu',
    'My Feet', '', 'C Watt'
  )

songs

drake_features <-
  tribble(
    ~Song, ~Artist,
    'Stay Schemin', 'Rick Ross feat Drake and French Montana',
    'Loving You No More', 'Diddy - Dirty Money feat Drake',
    '100', 'The Game feat Drake',
    'Made', 'Big Sean feat Drake',
    'The Zone', 'The Weeknd feat Drake',
    'Killer', 'Nipsey Hussle feat Drake',
    'Recognize', 'PARTYNEXTDOOR feat Drake',
    'Going Bad', 'Meek Mill feat Drake',
    'Right Above It', 'Lil Wayne feat Drake',
    'Versace (Remix)', 'Migos feat Drake',
    'No Lie', '2 Chainz feat Drake',
    'Moment 4 Life', 'Nicki Minaj feat Drake',
    'DnF', 'Preme feat Drake and Future',
    'Yes Indeed', 'Lil Baby feat Drake',
    'Mae Men', 'Rick Ross feat Drake',
    "What's My Name", 'Rihanna feat Drake',
    "Un-thinkable (I'm Ready)", 'Alicia Keys feat Drake',
    "Believe Me", 'Lil Wayne feat Drake',
    "I'm on One", 'DJ Khaled feat Drake, Rick Ross, Lil Wayne',
    "Fall for Your Type", 'Jamie Foxx feat Drake',
    "Big Amount", '2 Chainz feat Drake',
    "Over Here", 'PARTYNEXTDOOR feat Drake',
    "Blessings", 'Big Sean feat Drake and Kanye West',
    "Poetic Justice", 'Kendrick Lamar feat Drake',
    "Sicko Mode", 'Travis Scott feat Drake'
  )

drake_features


# Scraping List of Drake Singles from Wikipedia 
# https://en.wikipedia.org/wiki/Drake_singles_discography
page <- "https://en.wikipedia.org/wiki/Drake_singles_discography"
html <- read_html(page)
table <- html |> html_nodes("tbody") |> html_table()

# 2000s singles
table_a <- table[2] |> as.data.frame() |> select(Title, Album, Year)
# 2010s singles
table_b <- table[3] |> as.data.frame() |> select(Title, Album, Year)
# 2020s singles
table_c <- table[4] |> as.data.frame() |> select(Title, Album, Year)
# As featured artist
table_d <- table[5] |> as.data.frame() |> select(Title, Album, Year)
# Promotional Singles
table_e <- table[6] |> as.data.frame() |> select(Title, Album, Year)
# Other Charted and Certified Songs
table_f <- table[7] |> as.data.frame() |> select(Title, Album, Year)
# Guest Appearances
table_g <- table[8] |> as.data.frame() |> select(Title, Album, Year)

# Songwriting Discography
table_h <- table[9] |> as.data.frame() |> select(Title, Album, Year, Artist)

# Footer Table Header
table_i <- table[10] |> as.data.frame()
# Footer table content
table_j <- table[11] |> as.data.frame() |> select(vte.Drake.songs, vte.Drake.songs.1)
# Footer Table Songs Content
table_k <- table[12] |> as.data.frame()


# Cleaning the j and k tables
small_j <-
  table_j |> 
  select(1:2)

other_songs <- small_j[20, ]
featured_artist <- small_j[21, ]

names(other_songs) <- c("Album", "Title")

# Lengthening the Other Songs List
other_long <-
  other_songs |>
  separate_longer_delim(
    cols = Title,
    delim = "\n") |>
  mutate(Year = NA) |> # Adding a Year column so we can bind rows
  select(Title, Album, Year) # Reordering the columns so we can bind

names(featured_artist) <- c("Album", "Title")

clean_features <-
  featured_artist$Title |>
  str_remove_all("20\\d+") |> # Remove the years
  str_replace_all('""', '" "') |> # Create a space between songs names
  as.data.frame()

features <-
  cbind(featured_artist, clean_features) |> select(-Title)

names(features)[2] <- "Title"

feat_long <- 
  features |>
  separate_longer_delim(
    cols = Title,
    delim = '" "') |>
  mutate(Year = NA) |> # Adding a Year column so we can bind rows
  select(Title, Album, Year) # Reordering the columns so we can bind
  

# Binding all of the tables
full_table <-
  rbind(
    table_a,
    table_b,
    table_c,
    table_d,
    table_e,
    table_f,
    table_g,
    other_long,
    feat_long
  )

# Removing the individual table legends and headers
clean_table <-
  full_table[-c(7,60,86,193,201,427,  1, 8, 61, 87, 194, 202), ]

# Cleaning the Titles column
final_remove <-
  clean_table$Title |>
  str_replace_all('"', ' ') |> # remove the errant "s
  str_remove_all('\\[\\d+\\]') |> # removed the footnote marks like [77]
  str_squish() # remove any spaces left on either end from the removals

# Merging the clean table and the final cleaning of the columns
remerge <-
  cbind(
    clean_table,
    final_remove) |>
  select(-Title)

# Renaming the cleaned names column
names(remerge)[3] <- c('Title')

# Reordering the columns
remerge <-
  remerge |>
    select(Title, Album, Year)

# Checking the number of table rows > 619
nrow(remerge)

# It looks like the 'As Featured Artists' are duplicates, so I can filter those out
filtered_out <-
  remerge |>
  filter(
    Album != 'As featured artist') |>
  unique()

# Now only 508 Rows
nrow(filtered_out)

# Checking for any other duplicates
examination <-
  filtered_out |>
  filter(
    Album == 'Non-album single' | Album == 'Other songs' 
  )



