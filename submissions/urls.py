from django.urls import path

from . import views

urlpatterns = [
    path('', views.submissions, name='submissions'),
    path('dispositions/', views.dispositions, name='dispositions'),
    path('publishers/', views.publishers, name='publishers'),
    path('search/', views.search, name='search'),
    
]