import datetime
from django.db import models
from django.utils import timezone
from django.contrib.auth.models import AbstractUser

class CustomUser(AbstractUser):
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=15, blank=True, null=True)


    def __str__(self):  
        return self.username

from django.utils import timezone

class Task(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
    ]
    
    PRIORITY_CHOICES = [
        ('low', 'Low'),
        ('medium', 'Medium'),
        ('high', 'High'),
    ]
    
    title = models.CharField(max_length=255)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey('CustomUser', on_delete=models.CASCADE)
    start_time = models.DateTimeField(default=timezone.now)
    end_time = models.DateTimeField(default=timezone.now)
    priority = models.CharField(
        max_length=10,
        choices=PRIORITY_CHOICES,
        default='medium'  # Default priority level
    )
    status = models.CharField(
        max_length=20, 
        choices=STATUS_CHOICES, 
        default='pending'
    )

    def update_status(self):
        """ Automatically update the task's status based on the current time """
        now = timezone.now()
        if now < self.start_time:
            self.status = 'pending'
        elif self.start_time <= now <= self.end_time:
            self.status = 'in_progress'
        elif now > self.end_time:
            self.status = 'completed'

    def save(self, *args, **kwargs):
        # Update the status only when the task is created or modified
        self.update_status()  # Update the status based on current time
        super().save(*args, **kwargs)  # Call the parent save method
