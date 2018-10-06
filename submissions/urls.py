from django.urls import path

from . import views

urlpatterns = [
    path('', views.submissions, name='submissions'),
    path('dispositions/', views.dispositions, name='dispositions'),
    path('publishers/', views.publishers, name='publishers'),
    path('router/', views.router, name='router'),
    path('new_submission', views.new_submission, name='new_submission'),
    
]