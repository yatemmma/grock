from django.core.management.base import BaseCommand
from grock.build import clean, gen
from django.conf import settings

class Command(BaseCommand):
    help = 'generate static html files'

    def handle(self, *args, **options):
        settings.IS_ADMIN = False
        clean()
        gen()