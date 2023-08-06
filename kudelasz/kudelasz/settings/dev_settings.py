APP_NAME = 'kudelasz'

# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': APP_NAME / 'db.sqlite3',
    }
}