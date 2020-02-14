from django.db import models

class Genre(models.Model):
    key  = models.CharField(max_length=100, primary_key=True)
    name = models.CharField(max_length=100)

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
    genre        = models.ForeignKey(Genre, on_delete=models.DO_NOTHING, null=True, blank=True, default='pop_punk')
    genres       = models.ManyToManyField(Genre, related_name='bands', blank=True)

    def get_playlist(self):
        playlist = Disc.objects.filter(key=f'band-{self.key}')
        if playlist.count() > 0:
            return playlist.first().videos()
        else:
            return ''
    
    def get_discs(self):
        return self.discs.all().order_by('-release_date')

    def get_covers(self):
        return self.coverd_discs.all().order_by('-release_date')

    def active_term(self):
        if self.active is None:
            return ''
        elif self.active.endswith('present'):
            return f'{self.active.split("-")[0]}-'
        else:
            years = self.active.split("-")
            if len(years) == 1:
                return years
            else:
                return f'{years[0]}-{years[-1]}'  

    def genres_with_comma(self):
        return ",".join(list(map(lambda x: x.name, self.genres.all())))

    def genres_with_newline(self):
        return "<br>".join(list(map(lambda x: x.name, self.genres.all())))

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
    release_band = models.CharField(max_length=200, blank=True, null=True)
    bands        = models.ManyToManyField(Band, related_name='discs', blank=True)
    coverd_bands = models.ManyToManyField(Band, related_name='coverd_discs', blank=True)
    genres       = models.ManyToManyField(Genre, related_name='discs', blank=True)

    def videos(self):
        return ','.join(self.youtube_ids.split('\r\n'))

    def bands_key_and_name(self):
        if self.release_band is None:
            return list(map(lambda x: (x.key, x.name), self.bands.all()))
        else:
            return [(self.bands.all().first().key, self.release_band)]
    
    def display_release_date(self):
        if self.release_date is None:
            return ''
        else:
            year, month, day = self.release_date.split('/')
            date = [year]
            if not (month == '99'):
                date.append(month)
            if not (day == '99'):
                date.append(day)
        return '/'.join(date)


            

    @classmethod
    def get_playlist(cls, key):
        return cls.objects.get(key=key).videos()