# Generated by Django 5.1.3 on 2025-01-11 22:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('task_thrill_app', '0003_task_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='due_date',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='task',
            name='priority',
            field=models.CharField(choices=[('low', 'Low'), ('medium', 'Medium'), ('high', 'High')], default='medium', max_length=10),
        ),
    ]