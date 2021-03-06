# Generated by Django 2.0.5 on 2018-09-30 17:54

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('submissions', '0007_auto_20180930_1748'),
    ]

    operations = [
        migrations.AddField(
            model_name='submission',
            name='disposition',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.PROTECT, to='submissions.Disposition'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='submission',
            name='publisher',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.PROTECT, to='submissions.Publisher'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='submission',
            name='user',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]
