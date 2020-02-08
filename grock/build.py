from django.test import Client, RequestFactory
import os
import shutil

from grock.views import index, bands, band
from grock.models import Band

def clean():
    shutil.rmtree('docs/band/', ignore_errors=True)
    os.makedirs('docs/band/', exist_ok=True)

def gen():
    save_request(lambda req: index(req), 'index.html')
    save_request(lambda req: bands(req), 'bands.html')
    save_request(lambda req: covers(req), 'covers.html')

    for band_instance in Band.objects.all():
        save_request(lambda req: band(req, band_instance.key), f'band/{band_instance.key}.html')

def save_request(view_func, request_path, file_path=None):
        factory = RequestFactory()
        request = factory.get(request_path)
        response = view_func(request)

        if file_path is None:
            file_path = request_path
        with open(f'docs/{file_path}', mode='wb') as f:
            f.write( response.content )
    