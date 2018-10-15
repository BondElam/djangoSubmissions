from django.db import models
from django.contrib.auth.models import User
from datetime import date
from django.urls import reverse

class Disposition(models.Model):
    disposition = models.CharField(max_length=30, unique=True)
    
    def __str__(self):
        return self.disposition
    
class Publisher(models.Model):
    publisher = models.CharField(max_length=50, unique=True)
    web_address = models.CharField(max_length=256, blank=True, null=True)
    min_words = models.IntegerField(blank=True, null=True) 
    max_words = models.IntegerField(blank=True, null=True)
    remarks = models.TextField(blank=True, null=True)
    
    def __str__(self):
        return self.publisher    
    
    def get_absolute_url(self):
        return reverse('publisher-update', kwargs={'pk': self.pk})
    
    class Meta:
        ordering = ['publisher']
    
class Submission(models.Model):
    story = models.CharField(max_length=50)  
    word_count = models.IntegerField(null=True)  
    file = models.CharField(max_length=50)
    date_submitted = models.DateField(default=date.today)
    disposition_date = models.DateField(blank=True, null=True)  
    publisher = models.ForeignKey('Publisher', on_delete=models.PROTECT) 
    disposition = models.ForeignKey('Disposition', on_delete=models.PROTECT) 
    user = models.ForeignKey(User, on_delete=models.PROTECT)
    
#     def __str__(self):
#         return self.story

