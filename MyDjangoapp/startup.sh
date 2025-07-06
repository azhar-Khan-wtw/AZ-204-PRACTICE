#!/bin/bash

pip install -r requirements.txt
gunicorn MyDjangoapp.wsgi:application --bind=0.0.0.0:8000
