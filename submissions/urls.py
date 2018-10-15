from django.urls import path
from submissions.views import PublisherListView, PublisherCreate, PublisherUpdate, PublisherDelete
from submissions.views import SubmissionCreate, SubmissionUpdate
from . import views

urlpatterns = [
    path('', views.submissions, name='submissions'),
#     path('dispositions/', views.dispositions, name='dispositions'),
#     path('publishers/', views.publishers, name='publishers'),
    path('router/', views.router, name='router'),
    path('add', SubmissionCreate.as_view(), name='submission-add'),
    path('update/<int:pk>/', SubmissionUpdate.as_view(), name='submission-update'),
#     path('delete/<int:pk>/', SubmissionDelete.as_view(), name='submission-delete'),
    path('delete/<int:pk>/', views.delete_submission, name='submission-delete'),
    path('delete/', views.delete_submission, name = 'test-delete'),
    path('publishers/', PublisherListView.as_view(), name='publishers'),
    path('publisher/add/', PublisherCreate.as_view(), name='publisher-add'),
    path('publisher/<int:pk>/', PublisherUpdate.as_view(), name='publisher-update'),
    path('publisher/delete/<int:pk>/', views.delete_publisher, name='publisher-delete'),
    
]