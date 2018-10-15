from django.shortcuts import render, render_to_response
from .models import Disposition, Publisher, Submission
from django.http import HttpResponse
import ast
from .forms import NewSubmissionForm, NewPublisherForm, ListPublishersForm
from django.shortcuts import redirect
from django import forms
from django.views.generic.list import ListView
from django.urls import reverse_lazy
from django.views.generic.edit import CreateView, DeleteView, UpdateView, DeleteView

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

# def add_submission(request):
#   
#     if request.method == "POST":
#         
#         form = NewSubmissionForm(request.POST)
#         print(request.POST)
#         if form.is_valid():
#             submission = form.save(commit=False)            
#             submission.user = request.user
#             submission.save()   
#             return display_submissions({}, request) 
# 
#     else:
#         form = NewSubmissionForm()
#         
#     return render(request,'new_submission.html', {'form':form})

# def new_publisher(request):
#   
#     if request.method == "POST":        
#         form = NewPublisherForm(request.POST)
#         print(request.POST)
#         if form.is_valid():
#             publisher = form.save(commit=False)            
#             publisher.user = request.user
#             publisher.save()   
#             return display_submissions({}, request) 
# 
#     else:
#         form = NewPublisherForm()
#         
#     return render(request,'new_publisher.html', {'form':form})

# def dispositions(request):
#     current_user = request.user
#     print("current user: " + str(current_user))
#     
#     for d in Disposition.objects.all():
#         print (str(d.id) + ' ' + d.disposition)    
#         
#     for d in Disposition.objects.all():
#         print (d)
#         
#     dispositions_dict = Disposition.objects.all()
#     context = {'dispositions': dispositions_dict.values()}
#     return render(request, 'dispositions.html', context)
#     
# def publishers(request):
# 
#     for p in Publisher.objects.all():
#         print (str(p.id) + ' ' + p.publisher)    
# 
#     publishers_dict = Publisher.objects.all()
#     context = {'publishers': publishers_dict.values()}
#     return render(request, 'publishers.html', context)

def delete_submission(request, pk):    
    # form without action value will bounce back to self, in this case as POST    
    if request.method == "POST":  
        Submission.objects.filter(pk=pk).delete()
        return redirect('/submissions')

    sub = Submission.objects.filter(pk=pk).values()[0]
    data = {}
    for k, v in sub.items():
        kk = k.replace('_', ' ')
        kk = kk.title()
        data[kk] = v
    context = {}     
    context['data'] = data 
    context['pagetitle'] = 'Delete Submission'
    context['instruction'] = instruction_text('delete')
    context['buttonlabel'] = 'Delete'
    context['instruction_class'] = 'warning'
    context['cancelpath'] = '/submissions'
     
    return render(request, 'delete_view.html', context)

def delete_publisher(request, pk):    
    # form without action value will bounce back to self, in this case as POST    
    if request.method == "POST":  
        Publisher.objects.filter(pk=pk).delete()
        return redirect('/submissions/publishers')

    pub = Publisher.objects.filter(pk=pk).values()[0]
    data = {}
    for k, v in pub.items():
        kk = k.replace('_', ' ')
        kk = kk.title()
        data[kk] = v
    context = {}     
    context['data'] = data 
    context['pagetitle'] = 'Delete Publisher'
    context['instruction'] = instruction_text('delete')
    context['buttonlabel'] = 'Delete'
    context['instruction_class'] = 'warning'
    context['cancelpath'] = '/submissions'
     
    return render(request, 'delete_view.html', context)

def delete_disposition(request, pk):    
    # form without action value will bounce back to self, in this case as POST    
    if request.method == "POST":  
        Disposition.objects.filter(pk=pk).delete()
        return redirect('/submissions/dispositions')

    disp = Disposition.objects.filter(pk=pk).values()[0]
    data = {}
    for k, v in disp.items():
        kk = k.replace('_', ' ')
        kk = kk.title()
        data[kk] = v
    context = {}     
    context['data'] = data 
    context['pagetitle'] = 'Delete Disposition'
    context['instruction'] = instruction_text('delete')
    context['buttonlabel'] = 'Delete'
    context['instruction_class'] = 'warning'
    context['cancelpath'] = '/submissions'
     
    return render(request, 'delete_view.html', context)


def submissions(request):

    print(request)
    publishers_dict = Publisher.objects.all().order_by('publisher')
    dispositions_dict = Disposition.objects.all().order_by('disposition')
    submissions_dict = Submission.objects.select_related('disposition').select_related('publisher').all().order_by('id')
    context = {'submissions': submissions_dict,
               'w': width_dict,
                'dispositions': dispositions_dict,
               'publishers': publishers_dict,
               }
    return render(request, 'submissions.html', context)

def router(request):
#   print(request.POST) #request.POSt is a list of strings, so need to convert my stuff to real dictionaries
    post_dict = ast.literal_eval(request.POST['hidden-data'])
    if dict['action'] == 'search':
        return search_submissions(request)
    elif dict['action'] == 'edit':
        print(dict['id'])
        return redirect('/submissions/update/' + post_dict['id'])
    elif dict['action'] == 'delete':
        delete_submission(dict['id'])
        
    return HttpResponse('too bad')

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
            
        print('sql_dict...')
        print(sql_dict)
            
    return display_submissions(sql_dict, request) 
    
def display_submissions(sql_dict, request):

    print(sql_dict)
    submissions_dict = Submission.objects.select_related('disposition').select_related('publisher').filter(**sql_dict).order_by('id')
    publishers_dict = Publisher.objects.all().order_by('publisher')
    dispositions_dict = Disposition.objects.all().order_by('disposition')
    context = {'submissions': submissions_dict,
               'w': width_dict,
                'dispositions': dispositions_dict,
               'publishers': publishers_dict,
               }
    return render(request, 'submissions.html', context)

def instruction_text(instruction_type = 'create'):
    
    if instruction_type == 'create':
        instruction = "Enter the required information and press the 'Add' button to add this submission. Press 'Cancel' to exit with out changes. "
        instruction += 'You may also use the menu at the top of the page.'
    elif instruction_type == 'update':
        instruction = "Make any changes and press the 'Update' button. Press 'Cancel' to exit with out changes. "
        instruction += 'You may also use the menu at the top of the page.'
    elif instruction_type == 'delete':
        instruction = "If you are sure you want to delete this record, press the 'Delete' button. Otherwise, "
        instruction += "press 'Cancel.' You also may use the menu at the top of the page."
    else:
        instruction = 'There is an error in your instruction selection.'
        
    return instruction
        

class SubmissionCreate(CreateView):
    model = Submission
    fields = ['story', 'word_count', 'file', 'publisher', 'date_submitted', 'disposition', 'disposition_date']
    template_name = 'detail_view.html'
    success_url = '/submissions/'
#     initial = {'bond': 'my_button'}
    
    def form_valid(self, form):
        form.instance.created_by = self.request.user
        return super().form_valid(form)
    
    def get_context_data(self, **kwargs):
        context = super(SubmissionCreate, self).get_context_data(**kwargs)
        
        context['pagetitle'] = 'Add New submission'
        instructions = "Enter the required information and press the 'Add' button to add this submission. Press 'Cancel' to exit with out changes. "
        instructions += 'You may also use the menu at the top of the page.'
        context['instruction'] = instruction_text('create')
        context['buttonlabel'] = 'Add'
        context['instruction_class'] = 'instruction'
        context['cancelpath'] = '/submissions/'
        return context
    
class SubmissionUpdate(UpdateView):
    model = Submission
    fields = ['story', 'word_count', 'file', 'publisher', 'date_submitted', 'disposition', 'disposition_date']
    template_name = 'detail_view.html'
    success_url = '/submissions/'
    
    def get_context_data(self, **kwargs):
        context = super(SubmissionUpdate, self).get_context_data(**kwargs)
        print(context)
        context['pagetitle'] = 'Update submission'
        context['instruction'] = instruction_text('update')
        context['buttonlabel'] = 'Update'
        context['instruction_class'] = 'instruction'
        context['cancelpath'] = '/submissions/'
        return context

# class SubmissionDelete(DeleteView):
#     model = Submission
#     fields = ['story', 'word_count', 'file', 'publisher', 'date_submitted', 'disposition', 'disposition_date']
#     template_name = 'detail_view.html'
#     success_url = reverse_lazy('/submissions/')
#     
#     def get_context_data(self, **kwargs):
#         context = super(SubmissionDelete, self).get_context_data(**kwargs)
#         print(context)
#         context['pagetitle'] = 'Delete submission'
#         context['instruction'] = instruction_text('delete')
#         context['buttonlabel'] = 'Delete'
#         context['instruction_class'] = 'warning'
#         context['cancelpath'] = '/submissions/'
#         return context

class PublisherListView(ListView):
    model = Publisher
#     paginate_by = 5
    template_name = 'publishers.html'

#     def get_context_data(self, **kwargs):
#         context = super().get_context_data(**kwargs)
#         return context

class PublisherCreate(CreateView):
    model = Publisher
    fields = ['publisher', 'web_address', 'min_words', 'max_words', 'remarks']
    template_name = 'detail_view.html'
    success_url = '/submissions/publishers/'
#     initial = {'bond': 'my_button'}
    
    def form_valid(self, form):
        form.instance.created_by = self.request.user
        return super().form_valid(form)
    
    def get_context_data(self, **kwargs):
        context = super(PublisherCreate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Add New Publisher'
        instructions = "Enter the required information and and press the 'Add' button. Press 'Cancel' to exit with out changes. "
        instructions += 'You may also use the menu at the top of the page.'
        context['instructions'] = instructions
        context['buttonlabel'] = 'Add'
        context['cancelpath'] = '/submissions/publishers'
        return context

class PublisherUpdate(UpdateView):
    model = Publisher
    fields = ['publisher', 'web_address', 'min_words', 'max_words', 'remarks']
    template_name = 'detail_view.html'
    success_url = '/submissions/publishers/'
    
    def get_context_data(self, **kwargs):
        context = super(PublisherUpdate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Update Publisher Information'
        instructions = "Make any changes and press the 'Update' button. Press 'Cancel' to exit with out changes. "
        instructions += 'You may also use the menu at the top of the page.'
        context['instructions'] = instructions
        context['buttonlabel'] = 'Update'
        context['cancelpath'] = '/submissions/publishers'
        return context

    
class PublisherDelete(DeleteView):
    model = Publisher
    fields = ['publisher']
#     template_name = 'detail_view.html'
    template_name = 'message.html'
    success_url = reverse_lazy('publisher-list')
#     
#     def get_context_data(self, **kwargs):
#         context = super(PublisherDelete, self).get_context_data(**kwargs)
#         print( context)
#         return context
# 
#     def get_queryset(self):
#         qs = super(PublisherDelete, self).get_queryset()
#         print(qs)        
#         return qs

class DispositionListView(ListView):
    model = Disposition
#     paginate_by = 5
    template_name = 'dispositions.html'

#     def get_context_data(self, **kwargs):
#         context = super().get_context_data(**kwargs)
#         return context

class DispositionCreate(CreateView):
    model = Disposition
    fields = ['disposition']
    template_name = 'detail_view.html'
    success_url = '/submissions/dispositions/'
#     initial = {'bond': 'my_button'}
    
    def form_valid(self, form):
        form.instance.created_by = self.request.user
        return super().form_valid(form)
    
    def get_context_data(self, **kwargs):
        context = super(DispositionCreate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Add New Disposition'
        instructions = "Enter the required information and and press the 'Add' button. Press 'Cancel' to exit with out changes. "
        instructions += 'You may also use the menu at the top of the page.'
        context['instructions'] = instruction_text('create')
        context['buttonlabel'] = 'Add'
        context['cancelpath'] = '/submissions/dispositions/'
        return context

class DispositionUpdate(UpdateView):
    model = Disposition
    fields = ['disposition']
    template_name = 'detail_view.html'
    success_url = '/submissions/dispositions/'
    
    def get_context_data(self, **kwargs):
        context = super(DispositionUpdate, self).get_context_data(**kwargs)
        context['pagetitle'] = 'Update Disposition Information'
        context['instructions'] = instruction_text('update')
        context['buttonlabel'] = 'Update'
        context['cancelpath'] = '/submissions/dispositions'
        return context

    
class DispositionDelete(DeleteView):
    model = Publisher
    fields = ['disposition']
#     template_name = 'detail_view.html'
    template_name = 'message.html'
    success_url = reverse_lazy('disposition-list')
#     
#     def get_context_data(self, **kwargs):
#         context = super(PublisherDelete, self).get_context_data(**kwargs)
#         print( context)
#         return context
# 
#     def get_queryset(self):
#         qs = super(PublisherDelete, self).get_queryset()
#         print(qs)        
#         return qs
