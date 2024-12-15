
from rest_framework.decorators import api_view, permission_classes
from django.contrib.auth.models import User
from rest_framework.permissions import IsAuthenticated

from rest_framework.response import Response
from rest_framework import status
from .models import Task
from .serializers import TaskSerializer
from rest_framework.authtoken.models import Token
from rest_framework.permissions import AllowAny
from django.contrib.auth import authenticate


# Registration View
@api_view(['POST'])
@permission_classes([AllowAny])
def register_user(request):
     if request.method == 'POST':
        data = request.data
        
        username = data.get('username')
        password = data.get('password')
        email = data.get('email')

        # Check if required fields are provided
        if not username or not password or not email:
            return Response({"error": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

        # Check if username already exists
        if User.objects.filter(username=username).exists():
            return Response({"error": "Username already exists"}, status=status.HTTP_400_BAD_REQUEST)

        # Create the user
        user = User.objects.create_user(username=username, password=password, email=email)

        # Create a token for the user
        token = Token.objects.create(user=user)

        # Return the user data and token
        return Response({
            "message": "User registered successfully",
            "token": token.key  # Returning the token key
        }, status=status.HTTP_201_CREATED)

# Login View
@api_view(['POST'])
@permission_classes([AllowAny])
def login_user(request):
    """
    Login user and return a token.
    """
    if request.method == 'POST':
        username = request.data.get('username')
        password = request.data.get('password')

        user = authenticate(username=username, password=password)
        if user is not None:
            token, created = Token.objects.get_or_create(user=user)
            return Response({"token": token.key}, status=status.HTTP_200_OK)
        else:
            return Response({"error": "Invalid credentials."}, status=status.HTTP_400_BAD_REQUEST)


# Create a task
@api_view(['POST'])
@permission_classes([AllowAny])
def create_task(request):   
    if request.method == 'POST':
        serializer = TaskSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# Fetch all tasks
@api_view(['GET'])
@permission_classes([AllowAny])
def get_tasks(request):   
    if request.method == 'GET':
        tasks = Task.objects.all()
        serializer = TaskSerializer(tasks, many=True)
        return Response(serializer.data)