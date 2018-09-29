from django.shortcuts import render
from .models import Disposition, Publisher, Submission
# from django.http import HttpResponse

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
    for s in Submission.objects.filter(id__lte=25):
        print (str(s.id) + ' ' + s.story )    

    submissions_dict = Submission.objects.filter(id__lte=25)
    context = {'submissions': submissions_dict.values()}
    return render(request, 'submissions.html', context)

