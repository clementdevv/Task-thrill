
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('task_thrill_server.urls')),  
    path('auth/', include('task_thrill_server.urls')), 

]