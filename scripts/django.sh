#!/usr/bin/env bash
####Setting up django webframe
cd /home/vagrant
django-admin startproject mysite
cd mysite
python3 manage.py startapp webcounter

cat >  /home/vagrant/mysite/webcounter/views.py << EOF
from django.http import HttpResponse
import datetime
import redis
def index(request):

    
    
     r = redis.Redis()
     chislo = r.get("number").decode("utf-8")
     chislo=int(chislo)
     chislo=chislo + 1
     html = "<html><body>You are visitor number %s.</body></html>" % chislo
     r.mset({"number": chislo})
     chislo = r.get("number").decode("utf-8")
     return HttpResponse(html)

EOF


cat >  /home/vagrant/mysite/webcounter/urls.py  << EOF
from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
]

EOF




cat >  /home/vagrant/mysite/mysite/urls.py << EOF
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('webcounter/', include('webcounter.urls')),
    path('admin/', admin.site.urls),
]

EOF


#### Starting django web service
python3 /home/vagrant/mysite/manage.py runserver 0:8000 &