from django import forms
from .models import Submission, Publisher, Disposition

class NewSubmissionForm(forms.ModelForm):
    
    publisher = forms.ModelChoiceField(queryset=Publisher.objects.order_by('publisher').values_list('publisher', flat='true'), 
                                        empty_label=" ",)
    disposition = forms.ModelChoiceField(queryset=Disposition.objects.order_by('disposition').values_list('disposition', flat='true'),
                                         empty_label= ' ',)

    class Meta:
        model = Submission
        fields = ('story', 'word_count','file', 'publisher',
                  'date_submitted', 'disposition', 'disposition_date',)