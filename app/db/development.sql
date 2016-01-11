-- posts
-- id, url, title, date, bands, type, media, body
insert into posts values (
  1111,
  "used_self_title",
  "The Used - The Used",
  "2010/01/01",
  "used",
  "album",
  "youtube:CE2CAvJZiiM",
  "テスト投稿です

* markdown
* なるかな
* なるかな

http://scream.your.name/xxxx

[fueee](http://scream.your.name/xxxx)

[The Used](:used:)と[DGD](:dance_gavin_dance:)と[The Used](:used:)

youtube:l7Fi8-7HRhc

|xx|aa|cc|
|:--|:--|:--|
|xx|aa|cc|
|xx|aa|cc|
");
insert into posts values (
  2222,
  "30stm_the_kill_music_video",
  "Thirty Seconds To Mars - The Kill (Bury Me) (Music Video)",
  "",
  "30_seconds_to_mars",
  "music_video",
  "youtube:8yvGCAvOAfM",
  "youtube:8yvGCAvOAfM"
);
insert into posts values (
  3333,
  "30stm_the_kill_music_video2",
  "!!!Thirty Seconds To Mars - The Kill (Bury Me) (Music Video)",
  "",
  "used",
  "music_video",
  "youtube:8yvGCAvOAfM",
  "youtube:8yvGCAvOAfM"
);

-- bands
-- id, name, nick, site, wiki, facebook, twitter, youtube, soundcloud, myspace, purevolume, lastfm, instagram, tumblr
insert into bands values (
  "used",
  "The Used",
  "The Used",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name"
);

-- discs
-- id, title, bands, date, label, image, amazon, itunes, stream, teaser, free
insert into discs values (
  "used_self_title",
  "The Used",
  "used",
  "2010/10/10",
  "rise",
  "http://a2.mzstatic.com/jp/r30/Music5/v4/72/ac/d4/72acd458-22d1-603b-288a-260e4c43c6dd/cover170x170.jpeg",
  "B00U7XRJWW",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name",
  "http://scream.your.name"
);

-- videos
-- id, url, type, band, title, date

-- labels
-- id, name, nick, site, youtube
insert into labels values (
  "rise",
  "Rise Records",
  "Rise",
  "http://scream.your.name",
  "http://scream.your.name"
);
