from django.shortcuts import render
from grock.models import Band, Disc
from django.db.models import Q

def index(request):
    discs = Disc.objects.filter(~Q(disc_type='playlist')).order_by('-release_date')[:20]
    context = {
        'title': 'G-ROCK',
        'description': 'ongaku is music.',
        'discs': discs,
        'videos': Disc.get_playlist('top'),
        'path': '',
        'og_image': 'https://scream.your.name/static/images/grock.jpg'
    }
    return render(request, 'index.html', context)

def bands(request):
    bands = Band.objects.filter(Q(discs__isnull=False) | Q(discs__isnull=True, coverd_discs__isnull=True)).distinct('key').order_by('key')
    context = {
        'title': 'G-ROCK | bands',
        'description': 'バンド一覧',
        'bands': bands,
        'videos': Disc.get_playlist('bands'),
        'path': 'bands.html',
        'og_image': 'https://scream.your.name/static/images/grock.jpg'
    }
    return render(request, 'bands.html', context)

def covers(request):
    bands = Band.objects.filter(coverd_discs__isnull=False).distinct('key').order_by('key')
    context = {
        'title': 'G-ROCK | covers',
        'description': 'みんな大好きエモカバー',
        'bands': bands,
        'videos': Disc.get_playlist('covers'),
        'path': 'covers.html',
        'og_image': 'https://scream.your.name/static/images/grock.jpg'
    }
    return render(request, 'bands.html', context)
    
def band(request, key):
    band = Band.objects.get(key=key)
    context = {
        'title': f'G-ROCK | {band.name}',
        'description': f'{band.active_term} {band.origin}',
        'band': band,
        'videos': band.get_playlist(),
        'path': f'band/{band.key}.html',
        'og_image': band.image
    }
    return render(request, 'band.html', context)
