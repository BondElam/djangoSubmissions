from django.test import Client, TestCase as TC
from submissions.models import Disposition, Submission, Publisher
from django.contrib.auth.models import User
from django.contrib.auth import logout
# from django.test import SimpleTestCase as stc

class LoginTestCase(TC):
    fixtures = ['users']
    
    def setUp(self):
        self.client = Client()
       
    def test_login_error(self):
        response = self.client.post('/accounts/login/',{'username':'bond','password':'xxx'}, follow=True)
        TC.assertContains(self, response=response, text='Login')
        
    def test_login_success(self):
        response = self.client.post('/accounts/login/',{'username':'bond','password':'foobar'}, follow=True)
        TC.assertContains(self,response=response, text='Logout')
        
class SubmissionsTestCase(TC):
    fixtures = ['users', 'publishers', 'dispositions', 'submissions']
    
    def setUp(self):
        self.client = Client()
        
    def test_create_submission(self):
        # Must be logged in. 'get' brings up entry page. 'post', submits data and brings up submissions page
        self.client.post('/accounts/login/',{'username':'mark','password':'foobar'}, follow=True)
        response = self.client.get('/submissions/add/', follow=True)      
        TC.assertContains(self, response=response, text='Add New submission')
        response = self.client.post('/submissions/add/',{
          "pk": 4,
          "story": "Story-Four",
          "word_count": 4000,
          "file": "story-four.01.docx",
          "date_submitted": "1999-06-29",
          "disposition_date": "1999-06-29",
          "publisher": 3,
          "disposition": 3,
          "user": 2
        }, follow=True)
#         print(response.content)
        TC.assertContains(self, response=response, text='Story-Four')
        TC.assertNotContains(self, response=response, text='Story-One')
#         response = self.client.post('/submissions/delete/4/', follow=True)
#         TC.assertNotContains(self, response=response, text='Story-Four')
        
    def test_search(self):
        response = self.client.post('/accounts/login/',{'username':'bond','password':'foobar'}, follow=True)
        TC.assertContains(self, response=response, text='Story-One')
        response = self.client.post('/submissions/search/',{'publisher_id':2, 'disposition_id': 2}, follow = True)
        TC.assertContains(self, response=response, text='Story-Two')         
        TC.assertNotContains(self, response=response, text = 'Story-One')
        
    def test_delete(self):
        self.client.post('/accounts/login/',{'username':'mark','password':'foobar'}, follow=True)
        response = self.client.get('/submissions/', follow=True)
#         print(response.content)
        TC.assertContains(self, response=response, text='Story-Three')
        response = self.client.post('/submissions/delete/3/', follow=True)
        TC.assertNotContains(self, response=response, text='Story-Three')
        
class PublishersTestCase(TC):
    fixtures = ['users', 'publishers', 'submissions', 'dispositions']
    
    def setUp(self):
        self.client = Client()
        self.client.post('/accounts/login/',{'username':'bond','password':'foobar'}, follow=True)
        
    def test_create_duplicate_publisher(self):
        response = self.client.post('/submissions/publisher/add/?wp_file=__all', {
          "publisher": "Azimov's",
          "web_address": "http://www.asimovs.com/contact-us/writers-guidelines/",
          "min_words": 1000,
          "max_words": 20000,
          "remarks": "Azimov's wants stories with some literary merit."
        }, follow=True)
#         print(response.content)
        TC.assertContains(self, response=response, text='Publisher already exists')
#         messages = response.content
#         print(messages)
        
    def test_create_unique_publisher(self):         
        response = self.client.post('/submissions/publisher/add/?wp_file=__all', {
          "publisher": "XXXXX",
          "web_address": "http://www.asimovs.com/contact-us/writers-guidelines/",
          "min_words": 1000,
          "max_words": 20000,
          "remarks": "Azimov's wants stories with some literary merit."
        }, follow=True)
#         print(response.content)
        TC.assertContains(self, response=response, text = 'XXXXX')
        
    def test_available_publishers(self):
        
        # Test initial view
        response = self.client.get('/submissions/publishers/?wp_file=story-one.01.docx', follow=True)
        TC.assertNotContains(self, response=response, text='Analog')
        
        # Test with update from initial view
#         response = self.client.get('/submissions/publisher/2/?wp_file=story-one.01.docx', follow = True)
        response = self.client.post('/submissions/publisher/2/?wp_file=story-one.01.docx', {
          "publisher": "F&SF",
          "web_address": "https://www.sfsite.com/fsf/glines.htm",
          "min_words": 1000,
          "max_words": 25000,
          "remarks": "F&SF has no formula for fiction. The speculative element may be slight, but it should be present."
        }, follow=True)
        TC.assertNotContains(self, response=response, text='Analog')
        
                             
class UsersTestCase(TC):
    fixtures = ['users', 'publishers', 'submissions', 'dispositions']
    
    def setUp(self):
        self.client = Client()
    
    def test_catch_unauth_edit(self):
        self.client.post('/accounts/login/',{'username':'bond','password':'foobar'}, follow=True)
        response = self.client.get('/submissions/user/2', follow=True)
        TC.assertContains(self, response=response, text='Update User Information')
        self.client.logout()
        self.client.post('/accounts/login/',{'username':'mark','password':'foobar'}, follow=True)
        response = self.client.get('/submissions/user/1', follow=True)
        TC.assertNotContains(self, response=response, text="Update User Information")
        TC.assertContains(self, response=response, text='Only a superuser can update')

    def test_catch_unauth_add(self):
        self.client.post('/accounts/login/',{'username':'bond','password':'foobar'}, follow=True)
        response = self.client.get('/submissions/user/add/', follow=True)
        TC.assertContains(self, response=response, text='Add New User')
        self.client.logout()
        self.client.post('/accounts/login/',{'username':'mark','password':'foobar'}, follow=True)
        response = self.client.get('/submissions/user/add/', follow=True)
        TC.assertNotContains(self, response=response, text="Add New User")
        TC.assertContains(self, response=response, text='Only a superuser can add')
       
        
        
        
        
        
