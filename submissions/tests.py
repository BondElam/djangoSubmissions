from django.test import TestCase, Client
from submissions.models import Disposition, Submission, Publisher
from django.contrib.auth.models import User
from django.test import SimpleTestCase as stc

class SubmissionsTestCase(TestCase):
    fixtures = ['users', 'publishers', 'dispositions', 'submissions']
    
    def setUp(self):
        self.client = Client()
        print('................running setUp()............')

        
    def test_fixtures_loaded(self):
        print(User.objects.get(pk=1).last_name) # So remember info on User model in contrib.
        print(Disposition.objects.get(pk=1).disposition)
        print(Publisher.objects.get(pk=1).publisher)
        print(Submission.objects.get(pk=1).story)
        
    def test_login_error(self):
        response = self.client.post('/accounts/login/',{'username':'bond','password':'xxx'}, follow=True)
        stc.assertContains(self, response=response, text='Login')
        
    def test_login_success(self):
        response = self.client.post('/accounts/login/',{'username':'bond','password':'foobar'}, follow=True)
        stc.assertContains(self,response=response, text='Logout')
        
    def test_create_submission(self):
        # Must be logged in. 'get' brings up entry page. 'post', submits data and brings up submissions page
        self.client.post('/accounts/login/',{'username':'bond','password':'foobar'}, follow=True)
        response = self.client.post('/submissions/add/',{
          "story": "Story-Four",
          "word_count": 4000,
          "file": "story-four.01.docx",
          "date_submitted": "1999-06-29",
          "disposition_date": "1999-06-29",
          "publisher": 3,
          "disposition": 3,
          "user": 3
        }, follow=True)
#         print(response.content)
        stc.assertContains(self, response=response, text='Story-Four')
