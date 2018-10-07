from django import forms
from .models import Submission, Publisher, Disposition

class NewSubmissionForm(forms.ModelForm):
    
    publisher = forms.ModelChoiceField(queryset=Publisher.objects.all().order_by('publisher'), 
                                        empty_label=" ",
#                                         to_field_name='publisher',
                                        )
    disposition = forms.ModelChoiceField(queryset=Disposition.objects.all().order_by('disposition'),
                                        empty_label= ' ',
                                        to_field_name='disposition',
                                        )

    class Meta:
        model = Submission
        fields = ('story', 'word_count','file', 'publisher',
                  'date_submitted', 'disposition', 'disposition_date',)