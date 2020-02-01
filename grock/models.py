from django.db import models

class Band(models.Model):
    key          = models.CharField(max_length=200, primary_key=True)
    name         = models.CharField(max_length=200, unique=True)
    active       = models.CharField(max_length=10, blank=True, null=True)
    country_code = models.CharField(max_length=2, blank=True, null=True)
    origin       = models.CharField(max_length=100, blank=True, null=True)
    image        = models.URLField(blank=True, null=True)
    wiki         = models.URLField(blank=True, null=True)
    website      = models.URLField(blank=True, null=True)
    twitter      = models.URLField(blank=True, null=True)
    youtube      = models.URLField(blank=True, null=True)
    facebook     = models.URLField(blank=True, null=True)
    apple        = models.URLField(blank=True, null=True)
    google       = models.URLField(blank=True, null=True)
    amazon       = models.URLField(blank=True, null=True)
    spotify      = models.URLField(blank=True, null=True)
    soundcloud   = models.URLField(blank=True, null=True)
    bandcamp     = models.URLField(blank=True, null=True)
    note         = models.TextField(blank=True, null=True)