from django.urls import path
from .views import *
urlpatterns = [
    path('tasks/', get_tasks, name='get_tasks'),  # View all tasks
    path('tasks/create/', create_task, name='create_task'),  # Create a task
    path('register/', register_user, name='register_user'),
    path('login/', login_user, name='login_user'),
]
