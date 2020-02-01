from django.urls import path
from . import views

urlpatterns = [
    path('', views.index),
    path('index.html', views.index),
    path('bands.html', views.bands),
    path('band/<key>.html', views.band),
]
