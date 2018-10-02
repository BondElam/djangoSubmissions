from django.shortcuts import render
from .models import Disposition, Publisher, Submission
# from django.http import HttpResponse

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

    submissions_dict = Submission.objects.select_related('disposition').select_related('publisher').all().order_by('id')
    context = {'submissions': submissions_dict,
               'w': width_dict,}
    return render(request, 'submissions.html', context)

