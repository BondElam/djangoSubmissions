from django.shortcuts import render
from .models import Disposition, Publisher, Submission
from django.http import HttpResponse
import ast
from .forms import NewSubmissionForm
from django.shortcuts import redirect
from django import forms

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

def new_submission(request):
  
    if request.method == "POST":
        form = NewSubmissionForm(request.POST)
        print(request.POST)
        if form.is_valid():
            submission = form.save(commit=False)
            submission.user = request.user
            submission.save()   
            return display_submissions({}, request) 
        else:
            print("error.....................................................")

    else:
        form = NewSubmissionForm()
        
    return render(request,'new_submission.html', {'form':form})

def dispositions(request):
    current_user = request.user
    print("current user: " + str(current_user))
    
    for d in Disposition.objects.all():
        print (str(d.id) + ' ' + d.disposition)    
        
    for d in Disposition.objects.all():
        print (d)
        
    dispositions_dict = Disposition.objects.all()
    context = {'dispositions': dispositions_dict.values()}
    return render(request, 'dispositions.html', context)
    
def publishers(request):

    for p in Publisher.objects.all():
        print (str(p.id) + ' ' + p.publisher)    

    publishers_dict = Publisher.objects.all()
    context = {'publishers': publishers_dict.values()}
    return render(request, 'publishers.html', context)

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
    
    print(request.POST) #request.POSt is a list of strings, so need to convert my stuff to real dictionaries
    dict = ast.literal_eval(request.POST['hidden-data'])
    if dict['action'] == 'search':
        return search_submissions(request)
    elif dict['action'] == 'add':
        return add_submission()
    elif dict['action'] == 'edit':
        print(dict['id'])
    return HttpResponse('too bad')

def add_submission():
    pass

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

