from django.test import TestCase, Client
from submissions.models import Disposition
from django.contrib.auth.models import User
from django.test import SimpleTestCase as stc

class DispositionTestCase(TestCase):
    fixtures = ['dispositions', 'users']
    
    def setUp(self):
        self.client = Client()
        self.client.login(username='bond', password='foobar')
        
    def test_fixtures(self):
        print(Disposition.objects.get(pk=1).disposition)
        print(User.objects.get(pk=1).last_name)
        
    def test_login_error(self):
        response = self.client.post('/accounts/login/',{'username':'bond','password':'xxx'}, follow=True)
        stc.assertContains(self, response=response, text='Login')
        
    def test_login_success(self):
        response = self.client.post('/accounts/login/',{'username':'bond','password':'foobar'}, follow=True)
        stc.assertContains(self,response=response, text='Logout')
