# Generated by Django 2.0.5 on 2018-10-21 13:52

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('submissions', '0012_remove_submission_temp_disposition'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='disposition',
            options={'ordering': ['disposition']},
        ),
        migrations.AlterModelOptions(
            name='publisher',
            options={'ordering': ['publisher']},
        ),
    ]
