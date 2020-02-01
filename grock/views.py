from django.shortcuts import render

def index(request):
    context = {
        'title': 'G-ROCK'
    }
    return render(request, 'index.html', context)

def bands(request):
    context = {
        'title': 'G-ROCK | bands',
        'bands': []
    }
    return render(request, 'bands.html', context)
    
def band(request, key):
    context = {
        'title': 'G-ROCK',
        'band': {}
    }
    return render(request, 'band.html', context)
