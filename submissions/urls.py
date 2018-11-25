from django.urls import path
from submissions.views import PublisherListView, PublisherCreate, PublisherUpdate
from submissions.views import SubmissionCreate, SubmissionUpdate
from submissions.views import DispositionListView, DispositionCreate, DispositionUpdate
from submissions.views import UserListView, UserCreate, UserUpdate
from . import views

urlpatterns = [
    path('', views.display_submissions, name='submissions'),
    path('logout/', views.user_logout, name='logout'),
    path('search/', views.search_submissions, name='search'),
    path('add/', SubmissionCreate.as_view(), name='submission-add'),
    path('update/<int:pk>/', SubmissionUpdate.as_view(), name='submission-update'),
    path('delete/<int:pk>/', views.delete_submission, name='submission-delete'),
    path('publishers/', PublisherListView.as_view(), name='publishers'),
    path('publisher/add/', PublisherCreate.as_view(), name='publisher-add'),
    path('publisher/<int:pk>/', PublisherUpdate.as_view(), name='publisher-update'),
    path('publisher/delete/<int:pk>/', views.delete_publisher, name='publisher-delete'),
    path('dispositions/', DispositionListView.as_view(), name='dispositions'),
    path('disposition/add/', DispositionCreate.as_view(), name='disposition-add'),
    path('disposition/<int:pk>/', DispositionUpdate.as_view(), name='dispositionr-update'),
    path('disposition/delete/<int:pk>/', views.delete_disposition, name='dispositionr-delete'),
    path('users/', UserListView.as_view(), name='users'),
    path('user/add/', UserCreate.as_view(), name='user-add'),
    path('user/<int:pk>/', UserUpdate.as_view(), name='user-update'),
    path('user/delete/<int:pk>/', views.delete_user, name='user-delete'),
    
]