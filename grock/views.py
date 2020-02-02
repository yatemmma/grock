from django.shortcuts import render
from grock.models import Band, Disc

def index(request):
    context = {
        'title': 'G-ROCK',
        'videos': Disc.objects.get(key='top').videos()
    }
    return render(request, 'index.html', context)

def bands(request):
    bands = Band.objects.all()
    context = {
        'title': 'G-ROCK | bands',
        'bands': bands,
        'videos': Disc.objects.get(key='bands').videos()
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
