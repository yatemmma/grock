from django.shortcuts import render
from grock.models import Band, Disc
from django.db.models import Q

def index(request):
    discs = Disc.objects.filter(~Q(disc_type='playlist')).order_by('-release_date')[:8]
    print(discs)
    context = {
        'title': 'G-ROCK',
        'discs': discs,
        'videos': Disc.get_playlist('top')
    }
    return render(request, 'index.html', context)

def bands(request):
    bands = Band.objects.filter(Q(discs__isnull=False) | Q(discs__isnull=True, coverd_discs__isnull=True)).distinct('key').order_by('key')
    context = {
        'title': 'G-ROCK | bands',
        'bands': bands,
        'videos': Disc.get_playlist('bands')
    }
    return render(request, 'bands.html', context)

def covers(request):
    bands = Band.objects.filter(discs__isnull=True, coverd_discs__isnull=False).distinct('key').order_by('key')
    context = {
        'title': 'G-ROCK | covers',
        'bands': bands,
        'videos': Disc.get_playlist('covers')
    }
    return render(request, 'bands.html', context)
    
def band(request, key):
    band = Band.objects.get(key=key)
    context = {
        'title': f'G-ROCK | {band.name}',
        'band': band,
        'videos': band.get_playlist()
    }
    return render(request, 'band.html', context)
