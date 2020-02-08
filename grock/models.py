from django.db import models

class Band(models.Model):
    key          = models.CharField(max_length=200, primary_key=True)
    name         = models.CharField(max_length=200, unique=True)
    active       = models.CharField(max_length=100, blank=True, null=True)
    country_code = models.CharField(max_length=4  , blank=True, null=True)
    origin       = models.CharField(max_length=100, blank=True, null=True)
    image        = models.URLField(blank=True, null=True)
    wiki         = models.URLField(blank=True, null=True)
    website      = models.URLField(blank=True, null=True)
    twitter      = models.URLField(blank=True, null=True)
    youtube      = models.URLField(blank=True, null=True)
    facebook     = models.URLField(blank=True, null=True)
    instagram    = models.URLField(blank=True, null=True)
    apple        = models.URLField(blank=True, null=True)
    google       = models.URLField(blank=True, null=True)
    amazon       = models.URLField(blank=True, null=True)
    spotify      = models.URLField(blank=True, null=True)
    soundcloud   = models.URLField(blank=True, null=True)
    bandcamp     = models.URLField(blank=True, null=True)
    note         = models.TextField(blank=True, null=True)

    def get_playlist(self):
        playlist = Disc.objects.get(key=f'band-{self.key}')
        if playlist:
            return playlist.videos()
        else:
            return ''

class Disc (models.Model):
    key          = models.CharField(max_length=400, primary_key=True)
    title        = models.CharField(max_length=400)
    disc_type    = models.CharField(max_length=20)
    release_date = models.CharField(max_length=20 , blank=True, null=True)
    image        = models.URLField(blank=True, null=True)
    youtube_ids  = models.TextField(blank=True, null=True)
    wiki         = models.URLField(blank=True, null=True)
    youtube      = models.URLField(blank=True, null=True)
    apple        = models.URLField(blank=True, null=True)
    google       = models.URLField(blank=True, null=True)
    amazon       = models.URLField(blank=True, null=True)
    spotify      = models.URLField(blank=True, null=True)
    soundcloud   = models.URLField(blank=True, null=True)
    bandcamp     = models.URLField(blank=True, null=True)
    note         = models.TextField(blank=True, null=True)
    bands        = models.ManyToManyField(Band)

    def videos(self):
        return ','.join(self.youtube_ids.split('\r\n'))

