from django.shortcuts import render

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.renderers import JSONRenderer, BrowsableAPIRenderer  
from rest_framework.permissions import IsAuthenticated, AllowAny
from .serializers import TaskSerializer, RegisterSerializer, UserSerializer, LoginSerializer
from .models import Task
from rest_framework.response import Response
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
from .models import CustomUser



class SignUpView(APIView):
    permission_classes = [AllowAny]

    renderer_classes = [JSONRenderer, BrowsableAPIRenderer]

    def post(self, request):
        serializer = RegisterSerializer(data=request.data)  # Use RegisterSerializer here
        if serializer.is_valid():
            user = serializer.save() 
            refresh = RefreshToken.for_user(user)  
            return Response({
                "user": UserSerializer(user).data,  # Use UserSerializer for response
                "access": str(refresh.access_token),
                "refresh": str(refresh)
            }, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get(self, request, *args, **kwargs):
        return Response({"detail": "GET method not allowed on this endpoint."}, status=status.HTTP_405_METHOD_NOT_ALLOWED)  

class LoginView(APIView):
    permission_classes = [AllowAny]
    renderer_classes = [JSONRenderer, BrowsableAPIRenderer]

    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid():
            email = serializer.validated_data["email"]
            password = serializer.validated_data["password"]
            
            try:
                user = CustomUser.objects.get(email=email)
                if user.check_password(password):  # This checks the hashed password
                    refresh = RefreshToken.for_user(user)
                    return Response({
                        "user": UserSerializer(user).data,
                        "access": str(refresh.access_token),
                        "refresh": str(refresh)
                    }, status=status.HTTP_200_OK)
                
            except CustomUser.DoesNotExist:
                pass
                
            return Response(
                {"error": "Invalid email or password."}, 
                status=status.HTTP_401_UNAUTHORIZED
            )
            
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



class CreateTaskView(APIView):
    permission_classes = [IsAuthenticated]
    
    def post(self, request):
        serializer = TaskSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class ViewTasksView(APIView):
    permission_classes = [IsAuthenticated]
    
    def get(self, request):
        tasks = Task.objects.filter(user=request.user)
        for task in tasks:
            task.update_status()
        serializer = TaskSerializer(tasks, many=True)
        return Response(serializer.data)
    
class UpdateTaskView(APIView):
    permission_classes = [IsAuthenticated]

    def put(self, request, pk):
        try:
            task = Task.objects.get(pk=pk, user=request.user)
        except Task.DoesNotExist:
            return Response({"error": "Task not found."}, status=status.HTTP_404_NOT_FOUND)

        # Make sure the task is pending before updating it.
        if task.status != "pending":
            return Response({"error": "Cannot update a task that is not pending."}, status=status.HTTP_400_BAD_REQUEST)

        # Update the task using the serializer
        serializer = TaskSerializer(task, data=request.data, partial=True)
        if serializer.is_valid():
            updated_task = serializer.save()

            # Automatically update the status based on the start_time and end_time
            updated_task.update_status()

            # Return the updated task data
            return Response(serializer.data)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
class DeleteTaskView(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, pk):
        try:
            task = Task.objects.get(pk=pk, user=request.user)
        except Task.DoesNotExist:
            return Response({"error": "Task not found."}, status=status.HTTP_404_NOT_FOUND)

        task.delete()
        return Response({"message": "Task deleted successfully."}, status=status.HTTP_204_NO_CONTENT)

#Complete