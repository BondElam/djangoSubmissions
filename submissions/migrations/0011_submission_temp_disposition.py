# Generated by Django 2.0.5 on 2018-09-30 18:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('submissions', '0010_auto_20180930_1814'),
    ]

    operations = [
        migrations.AddField(
            model_name='submission',
            name='temp_disposition',
            field=models.IntegerField(null=True),
        ),
    ]
