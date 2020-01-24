"""
WSGI config for grock project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""

import os
from django.core.wsgi import get_wsgi_application
from django.conf import settings
from wsgi_basic_auth import BasicAuth

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')

DEBUG = getattr(settings, "DEBUG", None)

if DEBUG:
    application = get_wsgi_application()
else:
    application = BasicAuth(get_wsgi_application())
