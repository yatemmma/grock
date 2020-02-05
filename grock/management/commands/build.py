from django.core.management.base import BaseCommand
from grock.build import clean, gen

class Command(BaseCommand):
    help = 'generate static html files'

    def handle(self, *args, **options):
        clean()
        gen()