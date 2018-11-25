from django.shortcuts import render, render_to_response
from .models import Disposition, Publisher, Submission
from django.http import HttpResponse
import ast
# from submissions.forms import NewSubmissionForm, NewPublisherForm, ListPublishersForm
from django.shortcuts import redirect
from django import forms
from django.views.generic.list import ListView
from django.urls import reverse_lazy
from django.views.generic.edit import CreateView, DeleteView, UpdateView, DeleteView
from django.contrib.auth.models import User
from django.contrib.auth import logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib import messages
from django.contrib.auth import authenticate, login

# This should be the only place you need to make changes.
width_dict = {"id_width": '40px',
    "story_width": '250px',
    "words_width":'60px',
    "file_width": '177px',
    "publisher_width": '141px',
    "date_submitted_width": '95px',
    "disposition_width": '100px',
    "disposition_date_width": '95px',
    "scrollbar_width": '15px',
}

def user_login(request):
    return redirect('/accounts/login/')

def user_logout(request):
    print('in logout ................................................')
    logout(request)
    return redirect('/accounts/login/')
    
@login_required
def delete_submission(request, pk):    
    # form without action value will bounce back to self, in this case as POST    
    if request.method == "POST":  
        Submission.objects.filter(pk=pk).delete()
        return redirect('/submissions/')

    submissions_dict = Submission.objects.select_related('disposition').select_related('publisher').filter(pk=pk).values()[0]

    data = {}
    for k, v in submissions_dict.items():
        kk = k.replace('_', ' ')
        kk = kk.title()
        data[kk] = v
        
    publishers_dict = Publisher.objects.filter(pk=data['Publisher Id'])
    data['Publihser']=publishers_dict.values()[0]['publisher']
    
    dispositions_dict = Disposition.objects.filter(pk=data['Disposition Id'])
    data['Disposition']=dispositions_dict.values()[0]['disposition']
    data['User'] = User.objects.get(pk=data['User Id'])

    context = {}    
    context['data'] = data 
    context['pagetitle'] = 'Delete Submission'
    context['instruction'] = instruction_text('delete')
    context['buttonlabel'] = 'Delete'
    context['instruction_class'] = 'warning'
    context['cancelpath'] = '/submissions'
     
    return render(request, 'delete_view.html', context)

@login_required
def delete_publisher(request, pk):    
    # form without action value will bounce back to self, in this case as POST    
    wp_file = request.GET['wp_file']
    context = {}  
    if request.method == "POST":  
        try:
            Publisher.objects.filter(pk=pk).delete()            
            return redirect('/submissions/publishers?wp_file=' + wp_file)
        except Exception as e:
            print(e)
            context['errormessage'] = 'You cannot delete a publisher associated with a current submission.'            

    pub = Publisher.objects.filter(pk=pk).values()[0]
    data = {}
    for k, v in pub.items():
        kk = k.replace('_', ' ')
        kk = kk.title()
        data[kk] = v
   
    context['data'] = data 
    context['pagetitle'] = 'Delete Publisher'
    context['instruction'] = instruction_text('delete')
    context['buttonlabel'] = 'Delete'
    context['instruction_class'] = 'warning'
    context['cancelpath'] = '/submissions/publishers?wp_file=' + wp_file
     
    return render(request, 'delete_view.html', context)

@login_required
def delete_disposition(request, pk):    
    # form without action value will bounce back to self, in this case as POST    
    context = {}
    if request.method == "POST":  
        try:
            Disposition.objects.filter(pk=pk).delete()
            return redirect('/submissions/dispositions')
        except Exception as e:
            print(e)
            context['errormessage'] = 'You cannot delete a disposition associated with a current submission.'         

    disp = Disposition.objects.filter(pk=pk).values()[0]
    data = {}
    for k, v in disp.items():
        kk = k.replace('_', ' ')
        kk = kk.title()
        data[kk] = v
    
    context['data'] = data 
    context['pagetitle'] = 'Delete Disposition'
    context['instruction'] = instruction_text('delete')
    context['buttonlabel'] = 'Delete'
    context['instruction_class'] = 'warning'
    context['cancelpath'] = '/submissions/dispositions'
     
    return render(request, 'delete_view.html', context)

@login_required
def delete_user(request, pk):
    
    context = {}
    if request.method == "POST":  
        try:
            User.objects.filter(pk=pk).delete()
            return redirect('/submissions/users')
        except Exception as e:
            print(e)
            context['errormessage'] = e         

    user = User.objects.filter(pk=pk).values()[0]
    data = {}
    for k, v in user.items():
        kk = k.replace('_', ' ')
        kk = kk.title()
        data[kk] = v
    
    context['data'] = data 
    context['pagetitle'] = 'Delete User'
    context['instruction'] = instruction_text('delete')
    context['buttonlabel'] = 'Delete'
    context['instruction_class'] = 'warning'
    context['cancelpath'] = '/submissions/users'
     
    return render(request, 'delete_view.html', context)
    

@login_required
def display_submissions(request, sql_dict={'id__gte':0}):

    sql_dict['user_id__exact'] = request.user.id
#     print(sql_dict)
    submissions_dict = Submission.objects.select_related('disposition').select_related('publisher').filter(**sql_dict).order_by('id')
    publishers_dict = Publisher.objects.all().order_by('publisher')
    dispositions_dict = Disposition.objects.all().order_by('disposition')
    context = {'submissions': submissions_dict,
               'w': width_dict,
                'dispositions': dispositions_dict,
               'publishers': publishers_dict,
               }
    return render(request, 'submissions.html', context)

@login_required
def search_submissions(request):
    sql_dict = {}
    for k in request.POST.keys():
        v = request.POST[k]
        if len(v) == 0 or v == '0':
            continue
        elif k == 'story':
            sql_dict['story__icontains'] = request.POST[k]
        elif k == 'word_count':
            sql_dict['word_count__lte'] = request.POST[k]
        elif k == 'file':
            f = request.POST[k]
            pos = f.find('.')
            if pos >=0:
                sql_dict['file__icontains'] = f[0:pos]
        elif k == 'publisher_id':
            sql_dict['publisher_id__exact'] = request.POST[k]
        elif k == 'date_submitted':
            sql_dict['date_submitted__gte'] = request.POST[k]
        elif k == 'disposition_id':
            sql_dict['disposition_id__exact'] = request.POST[k]
        elif k == 'disposition_date':
            sql_dict['disposition_date__gte'] = request.POST[k]
            
    return display_submissions(request, sql_dict) 


# cannot use @login_required because no 'request' with user to check on
def instruction_text(instruction_type = 'create'):
    
    if instruction_type == 'create':
        instruction = "Enter the required information and press the 'Add' button to "
        instruction += "add this record. Press 'Cancel' to exit with out changes. "
        instruction += 'You may also use the menu at the top of the page.'
    elif instruction_type == 'update':
        instruction = "Make any changes and press the 'Update' button. Press 'Cancel' to exit with out changes. "
        instruction += 'You may also use the menu at the top of the page.'
    elif instruction_type == 'delete':
        instruction = "Are you sure you want to delete this record? If yes, press the 'Delete' button. Otherwise, "
        instruction += "press 'Cancel.' You also may use the menu at the top of the page."
    else:
        instruction = 'There is an error in your instruction selection.'
        
    return instruction        

class SubmissionCreate(LoginRequiredMixin, CreateView):
    model = Submission
    fields = ['story', 'word_count', 'file', 'publisher', 'date_submitted', 'disposition', 'disposition_date']
    template_name = 'detail_view.html'
    success_url = '/submissions/'
    
    def form_valid(self, form):
        form.instance.user_id = self.request.user.pk
        return super(SubmissionCreate, self).form_valid(form)
    
    def get_context_data(self, **kwargs):
        context = super(SubmissionCreate, self).get_context_data(**kwargs)
        
        context['pagetitle'] = 'Add New submission'
        context['instructions'] = instruction_text('create')
        context['buttonlabel'] = 'Add'
        context['instructionsclass'] = 'instructions'
        context['cancelpath'] = '/submissions/'
        return context
    
class SubmissionUpdate(LoginRequiredMixin, UpdateView):
    model = Submission
    fields = ['story', 'word_count', 'file', 'publisher', 'date_submitted', 'disposition', 'disposition_date']
    template_name = 'detail_view.html'
    success_url = '/submissions/'
    
    def get_context_data(self, **kwargs):
        context = super(SubmissionUpdate, self).get_context_data(**kwargs)
        print(context)
        context['pagetitle'] = 'Update submission'
        context['instructions'] = instruction_text('update')
        context['buttonlabel'] = 'Update'
        context['instructionsclass'] = 'instructions'
        context['cancelpath'] = '/submissions/'
        return context

class PublisherListView(LoginRequiredMixin, ListView):
    model = Publisher
    template_name = 'publishers.html'

    def get_queryset(self):
        self.wp_file = self.request.GET['wp_file']
#         print(self.request)
#         print(self.args)
#         print(self.kwargs)
#         print(self.wp_file)
        if self.wp_file == '__all':
            queryset = Publisher.objects.all().order_by('publisher')
        else:
            pos = self.wp_file.find('.')
            if pos >=0:
                self.wp_file = self.wp_file[0:pos]
            used_ids = Submission.objects.filter(file__icontains = self.wp_file).values('publisher_id').distinct()
#             print(used_ids)                
            queryset = Publisher.objects.exclude(id__in = used_ids)   
#         print(queryset)         
        return queryset
    
    def get_context_data(self, **kwargs):
        context = super(PublisherListView, self).get_context_data(**kwargs)
        if self.wp_file == '__all':
            context['pagetitle'] = "All Publishers"
            context['wp_file'] = '__all'
        else:
            context['pagetitle'] = "Available Publishers for '" + self.wp_file + "'"
            context['wp_file'] = self.wp_file
        return context

class PublisherCreate(LoginRequiredMixin, CreateView):
    model = Publisher
    fields = ['publisher', 'web_address', 'min_words', 'max_words', 'remarks']
    template_name = 'detail_view.html'
    
    def form_valid(self, form):
        form.instance.created_by = self.request.user
        return super().form_valid(form)
    
    def get_context_data(self, **kwargs):
        self.wp_file = self.request.GET['wp_file']
        context = super(PublisherCreate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Add New Publisher'
        context['instructions'] = instruction_text('create')
        context['instructionsclass'] ='instructions'
        context['buttonlabel'] = 'Add'
        context['cancelpath'] = '/submissions/publishers?wp_file=' + self.wp_file
        return context
    
    def get_success_url(self):
        self.wp_file = self.request.GET['wp_file']
#         print('......................... wp file:' + self.wp_file)
        return '/submissions/publishers?wp_file='+ self.wp_file
        

class PublisherUpdate(LoginRequiredMixin, UpdateView):
    model = Publisher
    fields = ['publisher', 'web_address', 'min_words', 'max_words', 'remarks']
    template_name = 'detail_view.html'
#     success_url = '/submissions/publishers?wp_file=__all'
    
    def get_context_data(self, **kwargs):
        self.wp_file = self.request.GET['wp_file']
        context = super(PublisherUpdate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Update Publisher Information'
        context['instructions'] = instruction_text('update')
        context['buttonlabel'] = 'Update'
        context['instructionsclass'] = 'instructions'
        context['cancelpath'] = '/submissions/publishers?wp_file=' + self.wp_file
#         print(context)
        return context
    
    def get_success_url(self):
        self.wp_file = self.request.GET['wp_file']
#         print('..................wp_file: ' + self.wp_file)
        return '/submissions/publishers?wp_file='+ self.wp_file

class DispositionListView(LoginRequiredMixin, ListView):
    model = Disposition
    template_name = 'dispositions.html'

class DispositionCreate(LoginRequiredMixin, CreateView):
    model = Disposition
    fields = ['disposition']
    template_name = 'detail_view.html'
    success_url = '/submissions/dispositions/'
    success_message = 'Your disposition has been added.'
    
    def form_valid(self, form):        
        if form.is_valid():
            print('valid form.....................')
        else:
            print('not valid form....................')   
        
        form.instance.created_by = self.request.user
        return super().form_valid(form)
    
    def get_context_data(self, **kwargs):
        context = super(DispositionCreate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Add New Disposition'
        context['instructions'] = instruction_text('create')
        context['instructionsclass'] = 'instructions'
        context['buttonlabel'] = 'Add'
        context['cancelpath'] = '/submissions/dispositions/'
        return context

class DispositionUpdate(LoginRequiredMixin, UpdateView):
    model = Disposition
    fields = ['disposition']
    template_name = 'detail_view.html'
    success_url = '/submissions/dispositions/'
    
    def get_context_data(self, **kwargs):
        context = super(DispositionUpdate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Update Disposition Information'
        context['instructions'] = instruction_text('update')
        context['buttonlabel'] = 'Update'
        context['instructionsclass'] = 'instructions'
        context['cancelpath'] = '/submissions/dispositions'
        return context
    
class UserListView(LoginRequiredMixin, ListView):
    model = User
    template_name = 'users.html'
    ordering = ['username']
    
    def get_context_data(self, **kwargs):
        context = super(UserListView, self).get_context_data(**kwargs)
        if self.request.user.is_superuser:
            context['superuser'] = True
        return context
    
    def get_queryset(self):
        if self.request.user.is_superuser:
            return User.objects.all().order_by('username')
        else:
            return User.objects.filter(pk=self.request.user.id)        
    
class UserCreate(LoginRequiredMixin, CreateView):
    model = User
    fields = ['username' , 'first_name', 'last_name', 'email']
    template_name = 'detail_view.html'
    success_url = '/submissions/users/'
    
    def form_valid(self, form):
        self.object = form.save(commit=False)                         
        if form['password'].value() == form['confirm_password'].value():
            self.object.set_password(form['password'].value())   
            if form['is_superuser'].value():
                self.object.is_superuser = form['is_superuser'].value() 
            else:
                self.object.is_superuser = False
            self.object.save()
            return super(UserCreate, self).form_valid(form)
        else:
            form.add_error('password', 'Password and Confirm Password must match.')
            return super(UserCreate, self).form_invalid(form)
    
    def get_context_data(self, **kwargs):
        context = super(UserCreate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Add New User'
        context['instructions'] = instruction_text('create')
        context['instructionsclass'] ='instructions'
        context['buttonlabel'] = 'Add'
        context['cancelpath'] = '/submissions/users'
        return context
    
    def get_form(self, **kwargs):
        form = super(UserCreate, self).get_form(**kwargs)
        if self.request.user.is_superuser:
            form.fields['is_superuser'] = forms.BooleanField(required=False)
        form.fields['password'] = forms.CharField()
        form.fields['confirm_password'] = forms.CharField()
        return form
    
class UserUpdate(LoginRequiredMixin, UpdateView):
    model = User
    fields = ['id', 'username' , 'first_name', 'last_name', 'email']
    template_name = 'detail_view.html'
    success_url = '/submissions/users/'
    
    def get_context_data(self, **kwargs):
        print(self.request.user.username)
        context = super(UserUpdate, self).get_context_data(**kwargs)
        print(context)
        context['pagetitle'] = 'Update User Information'
        instructions = instruction_text('update')
        instructions += ' If you do not want to update the password, leave the fields blank.'
        context['instructions'] = instructions
        context['buttonlabel'] = 'Update'
        context['instructionsclass'] = 'instructions'
        context['cancelpath'] = '/submissions/users'
        return context
    
    def get_form(self, **kwargs):
        form = super(UserUpdate, self).get_form(**kwargs)
        if self.request.user.is_superuser:
            form.fields['is_superuser'] = forms.BooleanField(required=False)
            form.fields['is_superuser'].initial = self.object.is_superuser
            
        form.fields['new_password'] = forms.CharField(required=False)
        form.fields['confirm_password'] = forms.CharField(required=False)
        return form
    
    def form_valid(self, form):
        self.object = form.save(commit=False)  
        changed_password_id = self.object.id
        current_user_id = self.request.user.id                       
        if form['new_password'].value() == form['confirm_password'].value():
            if form['new_password'].value(): # truthy works here
                self.object.set_password(form['new_password'].value())   
            if self.request.user.is_superuser:
                if form['is_superuser'].value():
                    self.object.is_superuser = form['is_superuser'].value()
                else:
                    self.object.is_superuser = False
            self.object.save()
            if changed_password_id == current_user_id:
                user = authenticate(username=self.object.username, password=form['new_password'].value())
                login(self.request, user)

 
            return super(UserUpdate, self).form_valid(form)
        else:
            form.add_error('new_password', "'New Password' and 'Confirm Password' must match.")
            return super(UserUpdate, self).form_invalid(form)

    


