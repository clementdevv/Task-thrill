from django.urls import path
from .views import CreateTaskView, ViewTasksView, UpdateTaskView, DeleteTaskView
from .views import SignUpView, LoginView

urlpatterns = [
    path('signup/', SignUpView.as_view(), name='signup'),
    path('login/', LoginView.as_view(), name='login'),
    
    
    path('tasks/create/', CreateTaskView.as_view(), name='create-task'),
    path('tasks/', ViewTasksView.as_view(), name='view-tasks'),
    path('tasks/<int:pk>/update/', UpdateTaskView.as_view(), name='update-task'),
    path('tasks/<int:pk>/delete/', DeleteTaskView.as_view(), name='delete-task'),
]
