# Import the module to work with Genius.com
import lyricsgenius

# Input the access token from the API access
genius = lyricsgenius.Genius("C8rowDdaxmn2pjO3gi2BQ6nSqQpmuINnCpMzvgYITI_ZOzvNmMnJYq3AAnk990pT")

# Album List
album_list1 = ['Drake Demo Disk', 'Room for Improvement', 'Comeback Season']

album_list2 = ['So Far Gone', 'So Far Gone (EP)', 'Thank Me Later', 'Young Sweet Jones']

album_list3 = ['Take Care', 'Nothing Was the Same', "If You're Reading This It's Too Late"]

album_list4 = ['Views', 'More Life', 'Scary Hours']

album_list5 = ['Scorpion']

album_list6 = ['The Best in the World Pack', 'Care Package'] 

album_list7 = ['Dark Lane Demo Tapes']

album_list8 = ['Scary Hours 2', 'Certified Lover Boy']

album_list9 = ['Honestly, Nevermind', 'For All The Dogs']

album_list9 = ['For All The Dogs Scary Hours Edition', '100 GIGS 3', '100 GIGS', '100 GIGS (Re-Release)']

# Lyrics to album list x
for album in album_list8:
    drake = genius.search_album(album, "Drake")
    song_list = drake.save_lyrics()

