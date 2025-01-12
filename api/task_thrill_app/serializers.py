from rest_framework import serializers
from .models import Task
from .models import CustomUser

    
class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['username', 'email', 'password', 'first_name', 'last_name']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = CustomUser.objects.create_user(**validated_data)
        return user


class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['id', 'username', 'email', 'first_name', 'last_name']
                
class TaskSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(read_only=True)  # Ensure the user is read-only

    class Meta:
        model = Task
        fields = ['id', 'title', 'description', 'start_time', 'end_time', 'status', 'created_at', 'priority', 'user'] 
        read_only_fields = ['created_at'] 
    
    def validate_priority(self, value):   
      value_lower = value.lower()   
      valid_priorities = [choice[0] for choice in Task.PRIORITY_CHOICES]   
      if value_lower not in valid_priorities:
        raise serializers.ValidationError(f"Invalid priority level. Choose from {valid_priorities}.")    
      return value_lower