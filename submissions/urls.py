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
#     path('new_publisher', views.add_publisher, name='new_publisher'),
    path('publishers/', PublisherListView.as_view(), name='publishers'),
    path('publisher/add/', PublisherCreate.as_view(), name='publisher-add'),
    path('publisher/<int:pk>/', PublisherUpdate.as_view(), name='publisher-update'),
    path('publisher/<int:pk>/delete/', PublisherDelete.as_view(), name='publisher-delete'),
    
]