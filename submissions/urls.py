from django.urls import path
from submissions.views import PublisherListView, PublisherCreate, PublisherUpdate, PublisherDelete
from . import views

urlpatterns = [
    path('', views.submissions, name='submissions'),
#     path('dispositions/', views.dispositions, name='dispositions'),
#     path('publishers/', views.publishers, name='publishers'),
    path('router/', views.router, name='router'),
    path('new_submission/', views.new_submission, name='new_submission'),
    path('new_publisher', views.new_publisher, name='new_publisher'),
    path('publishers/', PublisherListView.as_view(), name='publisher-list'),
    path('publisher/add/', PublisherCreate.as_view(), name='author-add'),
    path('publisher/<int:pk>/', PublisherUpdate.as_view(), name='publisher-update'),
    path('publisher/<int:pk>/delete/', PublisherDelete.as_view(), name='publisher-delete'),
    
]