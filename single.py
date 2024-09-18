# Import the module to work with Genius.com
import lyricsgenius

# Input the access token from the API access
genius = lyricsgenius.Genius("C8rowDdaxmn2pjO3gi2BQ6nSqQpmuINnCpMzvgYITI_ZOzvNmMnJYq3AAnk990pT")

# Song List
song_list = [
    ['Reincarnated', 'Jdot Breezy'],
    ['Ima', 'Comrade'],
    ['STARGAZING', 'Travis Scott'],
    ['Life Goes On', '2Pac'],
    ['I Need', 'Croosh'],
    ['All My Babies', 'Tez the Don'],
    ['Woke Up', 'prodbysky'],
    ['Lookin', 'Playboi Carti, Lil Uzi Vert'],
    ['FOR THE', 'Kay Vibes'],
    ['Broccoli', 'DRAM, Lil Yachty'],
    ['Hot (feat. Gunna)', 'Young Thug, Gunna'],
    ['Key', 'DJ Lykewize'],
    ['Keep', 'Rum Jungle'],
    ['A Horn', 'Stan Kenton'],
    ['On Me', 'Lil Baby'],
    ['That', 'OJ Da Juiceman'],
    ['Kamasi', '8R'],
    ['IPP', 'LSC'],
    ['Ownership', 'King Dif'],
    ['The Blueprint', 'JAY-Z'],
    ['Is By', 'Solo Piano'],
    ['Me', 'Chief Keef'],
    ['Mister', 'Rich Homie Quan'],
    ['Get Off', 'ian'],
    ['I Get Off', 'Boosie Badazz'],
    ['At', 'Anuahyahu'],
    ['My Feet', 'C Watt']
]


# Lyrics to album list x
for line in song_list:
    alleged = genius.search_song(line)
    lyrics = alleged.save_lyrics()
    #print(line)

