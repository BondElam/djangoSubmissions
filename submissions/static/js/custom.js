var tbl = {
	submissionId: -1,
	rowIndex: -1,
	lastTop: -1,
	lastGreen: false,
	sqlDict: {},
	resetHighlight: false,
	srchDisp: '',
	edinDisp: '',
	lastPubIndex: -1,
	srchPub: '',
	edinPub: '',
};
	

$(document).ready(function(){

	/*------------------------- dragging ------------------------*/
	
	var $dragging = null;
	var deltaLeft = null;;
	var deltaTop = null;
	
    $(document.body).on("mousemove", function(e) {
        if ($dragging) {
            $dragging.offset({
                top: e.pageY - deltaTop,
                left: e.pageX - deltaLeft
            });
       }
    });

	$(document.body).on("mousedown", ".draggable", function(e) {
        $dragging = $(this);       
        deltaLeft = e.pageX - $(this).offset().left;
        deltaTop = e.pageY - $(this).offset().top;
		$dragging.css("cursor", "move");
    });
    
	$(document.body).on("mousedown", ".dontDrag", function(e) {
		if($dragging !== null){
			$dragging.css("cursor", "default");
			$dragging = null;
		}
		e.stopPropagation();
    });

    $(document.body).on("mouseup", function (e) {
    	if($dragging !== null){
	 		$dragging.css("cursor", "default"); 
	        $dragging = null;
       }
    });

	/*-------------------------end dragging ------------------------*/
	$(function(){

		tbl.lastTop = -1;
		setTableHeight();
		repositionTable();
		
	});

	$("#btn-edit").click(function() {		
		if(tbl.rowIndex < 0){
			alert("You must select a row to edit.");
			return false;
		}
		$("#table-submissions tr").each(function(){
			if($(this).index() === tbl.rowIndex){	
				var id = $(':nth-child(1)', this).text();		
				$("#hidden-data").val("{'action':'edit', 'id':'" + id + "'}");
			}
		})
	});
	
	$("#btn-delete").click(function(){		
		if(tbl.rowIndex < 0 ){
			alert("You must select a row to delete.");
			return false;
		}
		var sub = '';
		$("#table-submissions tr").each(function(){
			if($(this).index() === tbl.rowIndex){	
				sub = $(':nth-child(1)', this).text();	
//				alert(sub);
			}
		});
//		alert($(location).attr('href') )
		var addr = $(location).attr('href') + "delete/" + sub;
//		alert(addr);		
		$('#btn-delete').attr('href',addr);		
		return;
	});
	
	
//		$("#hidden-data").val("{'action':'edit', 'id':'201'}");
		

//		return
//
//		var buttonId = $(this).attr('id');
//		if(tbl.rowIndex < 0 && buttonId === 'btn-edit'){
//			popInfo("You must select a row to edit.");
//			return;
//		}
//		if(tbl.rowIndex < 0 && buttonId === 'btn-delete'){
//			popInfo("You must select a row to delete.");
//			return;
//		}
//
//		if(tbl.rowIndex < 0 && buttonId === 'btn-clone'){
//			popInfo("You must select a row to clone.");
//			return;
//		}
//
//		
//		var editPop = $('#edit-div').clone();
//		editPop.find('input, button, td').each(function(){
//			this.id = 'ed' + this.id;
//		})
//		editPop.attr('id', 'edin-edit-div');
//		$('#pop-span').append(editPop);
//		editPop.css('display','inline-block');
//		editPop.css("visibility", "visible");
//		centerMe(editPop);
//
//		if(buttonId === 'btn-add'){
//			$('#edit-label').text("Add new submission...")
//			$('#edin-btn-save').text('Add');
//		}
//		if(buttonId === 'btn-edit'){
//			$('#edit-label').text("Edit existing submission...")
//			$('#edin-btn-save').text('Edit');
//		}			
//		if(buttonId === 'btn-clone'){
//			$('#edit-label').text("Clone existing submission...")
//			$('#edin-btn-save').text('Add');
//		}		
//		if(buttonId === 'btn-delete'){
//			$('#edit-label').text("Delete existing submission...")
//			$('#edin-btn-save').text('Delete');
//		}
//		if(buttonId !== 'btn-add'){
//			$("#table-submissions tr").each(function(){
//				if($(this).index() === tbl.rowIndex){	
//					if(buttonId !== 'btn-clone'){
//						$("#edin-id").val($(':nth-child(1)', this).text());
//					}
//					$("#edin-story").val($(':nth-child(2)', this).text());
//					$("#edin-words").val($(':nth-child(3)', this).text());
//					$("#edin-file").val($(':nth-child(4)', this).text());
//					
//		  			var pub = $(':nth-child(5)', this).text();
//		  			$("#edin-publisher option").each(function() {
//					  	if($(this).text() === pub) {
//					    	$(this).prop('selected', true);
//					    	return true;
//					  	}        
//					});		
//					$("#edin-submission-date").val($(':nth-child(6)', this).text());					
//		  			var disp = $(':nth-child(7)', this).text();					
//		  			$("#edin-disposition option").each(function() {
//					  	if($(this).text() === disp) {
//					    	$(this).prop('selected', true);
//					    	return true;
//					  	}        
//					});						
//					$("#edin-disposition-date").val($(':nth-child(8)', this).text());					
//					return true;
//				}
//			});				
//		};		
//	});


  	$("#table-submissions").on("click", "tbody tr", function(){

  		$("#table-submissions tr").css('background-color', '#e0e0e0');
  		$("#table-submissions tr").css('color', 'black');
  		$(this).css("background-color", "#449d44");
  		$(this).css("color", "white");

  		tbl.rowIndex = $(this).index();
  		tbl.lastTop = $(this).position().top;
  	})

	$("#table-submissions").on("dblclick","tbody tr td", function(){
//		 alert("in dblclick: " + $(this).text())

	  	switch ($(this).index()){

	  		case 1:
	  			$("#search-story").val($(this).text());
	  			break;
	  		case 2:
	  			$("#search-words").val($(this).text());
	  			break;
	  		case 3:
	  			$("#search-file").val($(this).text());
	  			break;	
	  		case 4:
	  			var pub = $(this).text();
	  			$("#search-publisher option").each(function() {
				  	if($(this).text() === pub) {
				    	$(this).prop('selected', true);
				    	return false;
				  	}        
				});				
	  			break;	
  			case 5:
  				$("#search-date-submitted").val($(this).text());
  				break;
  			case 6:
 	  			var disp = $(this).text();
	  			$("#search-disposition option").each(function() {
				  	if($(this).text() === disp) {
				    	$(this).prop('selected', true);
				    	return false;
				  	}        
				});				
	  			break;	 
  			case 7:
  				$("#search-disposition-date").val($(this).text());
  				break;
	  		default:
	  			//alert($(this).index());
	  			break;	  			
	  	}
	})

	

	$('#btn-clear').click(function(){

  		$("#search-story").val("");
  		$("#search-words").val("");
  		$("#search-file").val("");
  		$("#search-publisher option").each(function() {
		  	if($(this).text() === " ") {
		    	$(this).prop('selected', true);		
		  	}        
		});		  	
		$("#search-date-submitted").val("");
		$("#search-disposition option").each(function() {
		  	if($(this).text() === " ") {
		    	$(this).prop('selected', true);
		  	}        
		});
		$("#search-disposition-date").val("");
		return false;
	})

	$('#btn-search').click(function(){	
		tbl.lastTop = -1;
		$("#hidden-data").val("{'action':'search'}");
//		performSearch();
	})

	$(document).on('focusout', '.check-date', function(){
		// alert("In check date");
		date = ($(this).val());
		if( date !== ''){
			if( ! validateDate(date)){
				popWarning(this, "Date must be in the form 'YYYY-MM-DD'.");				
			}
		}
	})

	$(document).on('click', '#table-dispositions tbody tr', function(){

		tbl.lastDispIndex = $(this).index();

  		$("#table-dispositions tr").css('background-color', '#e0e0e0');
  		$("#table-dispositions tr").css('color', 'black');
  		$(this).css("background-color", "#449d44");
  		$(this).css("color", "white");
	})

	$(document).on('click', '#table-publishers tbody tr', function(){

		tbl.lastPubIndex = $(this).index();

  		$("#table-publishers tr").css('background-color', '#e0e0e0');
  		$("#table-publishers tr").css('color', 'black');
  		$(this).css("background-color", "#449d44");
  		$(this).css("color", "white");
	})
	
	$("#btn-add").click(function(){
//	$(document).on("click", '#btn-add', function(){
		
//		alert("in btn add click");

		$("#hidden-data").val("{'action':'add'}");
		// click the invisible submit_tag to submit form to controller
		// $("#hidden-edit-submission").trigger('click');
	})


})

//function performSearch(){
//
//	var sqlDict = {};
//	var s = $('#srch-story').val(); 
//	if(s !== ''){
//		// s =  s.replace("'", "''");
//		sqlDict['story__contains'] = s;
//	}
//	s = $('#srch-words').val();
//	if(s !== ''){
//		if(s !== 'None'){
//			sqlDict['word_count__lte'] = s;
//		}
//	}
//	s = $('#srch-file').val();
//	if(s !== ''){		
//		pos = s.indexOf(".");
//		s = s.substr(0, pos);
//		sqlDict['file__contains'] = s;			
//	}	
//	s = $('#srch-publisher option:selected').text();
//	if(s !== ''){
//		// s = s.replace("'", "''");
//		sqlDict["publisher"] = s;
//	}
//	s = $('#srch-submission-date').val();
//	if(s !== ''){
//		sqlDict["date_submitted__gte"] = s;
//	}
//	s = $('#srch-disposition option:selected').text();
//	if(s !== ''){
//		sqlDict["disposition"] = s;
//	};
//
//	var csrftoken=getCookie('csrftoken');
//	$.ajaxSetup({
//	    beforeSend: function(xhr, settings) {
//	        xhr.setRequestHeader("X-CSRFToken", csrftoken);
//	    }
//	});
//
//	$.ajax({url: "../new_search/", 
//		type: "POST",
//		data: $.param(sqlDict),
//		success: function(result){
//			$("#tbody-replaceable").replaceWith(result);	
//			setTableHeight();
//			repositionTable();
//    	},
//    	error: function(result){
//    		alert("here is result: " + result["responseText"]);
//    		console.log(result);
//		} 
//	});
//}

function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

function validateDate(date){

    var regex = /^\d{4}-\d{2}-\d{2}$/;
    return  regex.test(date);
}

function setTableHeight(){
		var windowHeight = $(window).height();
		var headHeight = (.6 * windowHeight).toString() + 'px';
		$("#tbody-replaceable").css('height', headHeight);

}

function editSubmission(){

	clearDict(tbl.sqlDict);
	tbl.sqlDict['action'] =  $("#edin-btn-save").text();
	
	var id = $("#edin-id").val();
	if( tbl.sqlDict['action'] ==='Delete'){
		tbl.sqlDict['submission_id'] = id;
		var s = "Click 'OK' to confirm that you want to delete submission #" + id  + ".";
		myPop('deleteSub', 'Confirm Deletion', s,'color:red;', "approveSqlDict()", 2);
		return;
	}
	if( $("#edin-btn-save").text() !== 'Add'){
		tbl.sqlDict['submission_id'] = id;  // if update vs insert,  rest ok for both
	}
	var story = $("#edin-story").val();    //.replace("'", "''");
	tbl.sqlDict["story"] = story;
	var words = $("#edin-words").val();
	if( words !== "" && words !== "None"){ 
		tbl.sqlDict["word_count"] =  words;
	}
	var file = $("#edin-file").val();
	if(file.length <= 0){
		popInfo("You must include a File.");
		return;
	}
	tbl.sqlDict["file"] = $("#edin-file").val()
	tbl.sqlDict["publisher_id"] = $('#edin-publisher option:selected').val();
	var date_submitted = $("#edin-submission-date").val();
	if( date_submitted !== "" && date_submitted !== 'None'){
		tbl.sqlDict["date_submitted"] = $("#edin-submission-date").val();
	}
	tbl.sqlDict["disposition_id"] = $("#edin-disposition option:selected").val();
	var dispositionDate = $("#edin-disposition-date").val();
	if( dispositionDate !== '' && dispositionDate !== "None"){
		tbl.sqlDict["disposition_date"] = dispositionDate;
	}
	approveSqlDict();	
}

function approveSqlDict(){	

	jString = displayDict(tbl.sqlDict);
	myPop('updateSubmission', 'Is this sqlDict Ok?', jString,'color:gray;', 'sendEdit();', 2);
}

function displayDict(dict){
	var str = '';
	$.each( dict, function( key, value ) {
  		str += key + ": " + value + "<br />";
	});
	return str;
}

function clearDict(dict){
	$.each(dict, function(key, falue){
		delete(dict[key]);
	})
}

function sendEdit(){

	tbl.lastTop = $("#table-submissions tbody").scrollTop();
	var csrftoken=getCookie('csrftoken');
	$.ajaxSetup({
	    beforeSend: function(xhr, settings) {
	        xhr.setRequestHeader("X-CSRFToken", csrftoken);
	    }
	});
	
	$.ajax({url: "../update_submissions/", 
		type: "POST",
		data: $.param(tbl.sqlDict),
		success: function(result){
			if(tbl.sqlDict['action'] === "Delete"){
				popInfo( result[0] + " submission deleted.");				
			}else if(tbl.sqlDict['action'] == "Add"){
				popInfo("Your submission was added.")
				tbl.lastTop = -1;  // causes to go to end of table
				tbl.resetHighlight = true;
				tbl.rowIndex = $('#table-submissions tr').length - 1; // highlight new row
				$("#btn-clear").trigger("click");
			}else{
				popInfo("Your submission has been updated")
				tbl.resetHighlight = true;
			}
			$("#edin-edit-div").remove();	
			performSearch();			
    	},
    	error: function(result) {
    		popInfo(result.responseText);
    	}  

	}); 
	
}

function repositionTable(){	
	if(tbl.lastTop < 0){
		$("#table-submissions tbody").scrollTop( $("#table-submissions tr:last").position().top);
		tbl.lastTop = $("#table-submissions tbody").scrollTop();
	}else{
		$("#table-submissions tbody").scrollTop(tbl.lastTop);
	}	
	if (tbl.resetHighlight){
		if(tbl.rowIndex >= 0){
			var row = tbl.rowIndex + 1;  //index is 0-based, rowIndex = 1-based??????
			$("#table-submissions tr:nth-child(" + row + ")").css("background-color", "#449d44");
			$("#table-submissions tr:nth-child(" + row + ")").css("color", "white");		
		}
		tbl.resetHighlight = false;
	}	
}

function editDisposition(){

	beforeSend();
	$.ajax({url: "../dispositions_table/", 
		type: "POST",
		// data: $.param(sqlDict),
		success: function(result){
			myPop('dispositions_table', "Select Disposition", result, '','', 0);
			tbl.lastDispIndex = -1;
    	},
    	error: function(result){
    		alert("here is result: " + result["responseText"]);
    		console.log(result);
		} 
	});

}

function editPublisher(){

	beforeSend();
	$.ajax({url: "../publishers_table/", 
		type: "POST",
		// data: $.param(sqlDict),
		success: function(result){
			myPop('publishers_table', "Select Publisher", result, '','', 0);
			tbl.lastPubIndex = -1;
    	},
    	error: function(result){
    		alert("here is result: " + result["responseText"]);
    		console.log(result);
		} 
	});

}

function availablePublishers(){
	
	var dict = {};
	if(tbl.rowIndex < 0 ){
		popInfo("You must select a story for which you want available publishers.");
		return;
	}
	var fileStub = '';
	$("#table-submissions tr").each(function(){
		if($(this).index() === tbl.rowIndex){	
			fileStub = $(':nth-child(4)', this).text();
			return false;
		}
	})
	var pos = fileStub.indexOf(".");
	fileStub = fileStub.substr(0, pos);
	dict['file__contains'] = fileStub;	
	
	beforeSend();
	$.ajax({url: "../available_publishers/", 
		type: "POST",
		data: $.param(dict),
		success: function(result){
			myPop('publishers_table', "Available Publisher", result, '','', 0);
			tbl.lastPubIndex = -1;
    	},
    	error: function(result){
    		alert("here is result: " + result["responseText"]);
    		console.log(result);
		} 
	});
//	alert('In available Publishes');
}

function updateDisp(action){

	if(tbl.lastDispIndex === -1 && action !== "Add"){
		popInfo("You must select a disposition to " + action + ".");
		return;
	}

	var message = '';
	if(action ==='Add'){
		messsage = "Enter new disposition...";
	}else if(action === 'Edit'){
		message = "Edit existing disposition...";
	}else{
		message = "Delete existing disposition...";
	}

	var s = '';
	s += "<p><input id='disp-id' type='text' style='width:25px;' disabled/><input id='disp-disposition' "
	s += "type='text' style='width:130px;' class='dontDrag'/></p>";
	s += "<button style='margin-right:10px;' onclick='sendDisposition(&apos;" + action + "&apos;)'>" + action + "</button>";
	s += "<button style='margin-left:10px;' onclick='sendDisposition(&apos;Cancel&apos;)'>Cancel</button>";
 	myPop('updateDisp', action + ' Disposition', s, '','',0);	

	if(action !== 'Add'){
		$("#table-dispositions tr").each(function(){
			if($(this).index() === tbl.lastDispIndex){
				$("#disp-id").val($(':nth-child(1)', this).text());
				$("#disp-disposition").val($(':nth-child(2)', this).text());
			}
		});
	}
}

function updatePub(action){

	if( document.getElementById("divEditPublisher") !== null){
		alert("Already used id: " + "divEditPublisher");
		return;
	};	

	if(tbl.lastPubIndex === -1 && action !== "Add"){
		popInfo("You must select a disposition to " + action + ".");
		return;
	}

	var message = 'Message error';
	if(action ==='Add'){
		message = "Add new publisher...";
	}else if(action === 'Edit'){
		message = "Edit existing publisher...";
	}else{
		message = "Delete existing publisher...";
	}

	var dict={};
	dict['action'] = action;
	if(action !== 'Add'){
		$("#table-publishers tr").each(function(){
			if($(this).index() === tbl.lastPubIndex){
				dict['publisher_id'] = $(':nth-child(1)', this).text();
			}
		});
	}

	beforeSend();
	$.ajax({url: "../publisher_edit/", 
		type: "POST",
		data: $.param(dict),
		success: function(result){
			$('#pop-span').append(result);	
			$("#edit-pub-label").text(message);
			$("#edit-pub-action").text(action)
			$("#divEditPublisher" ).css("display", "inline-block");
			$("#divEditPublisher").css("visibility", "visible");
			centerMe($("#divEditPublisher"));			
			 tbl.lastPubIndex = -1;
    	},
    	error: function(result){
    		alert("here is result: " + result["responseText"]);
    		console.log(result);
		} 
	});


}

function sendPublisher(){

	tbl.srchPub =  $('#srch-publisher option:selected').val();
	tbl.edinPub = $('#edin-publisher option:selected').val();

	var dict = {};
	var action = $('#edit-pub-action').text();
	dict['action'] = action;
	if( action !== 'Add'){
		dict['publisher_id'] = $("#edit-pub-id").val();
	}
	if( action !== "Delete"){
		dict['publisher'] = $("#edit-pub-name").val();
		dict['web_address'] = $("#edit-pub-web-address").val();
		dict['min_words'] = $("#edit-pub-min-words").val();
		dict['max_words'] = $("#edit-pub-max-words").val();
		dict['remarks'] = $("#edit-pub-remarks").val();
	}

	beforeSend();
	$.ajax({url: "../update_publisher/", 
		type: "POST",
		data: $.param(dict),
		success: function(result){
			// alert(result);
			var myArray = result.split('SplitHere');
			$('#table-edit-publishers').replaceWith(myArray[0]);
			$('.publisher-select').replaceWith(myArray[1])

  			$("#srch-publisher option").each(function() {
			  	if($(this).val() === tbl.srchPub) {
			    	$(this).prop('selected', true);
			    	return false;
			  	}        
			});		
			$("#edin-publisher option").each(function() {
			  	if($(this).val() === tbl.edinPub) {
			    	$(this).prop('selected', true);
			    	return false;
			  	}        
			});	
			if(action === 'Edit'){
				tbl.resetHighlight = true;
				performSearch();
			}
		},
    	error: function(result){
    		// alert("here is result: " + result["responseText"]);
    		popInfo(result["responseText"])
    		// console.log(result);
		} 
	});
	$("#divEditPublisher").remove();
}

function sendDisposition(action){

	if(action === 'Cancel'){
		$("#updateDisp").remove();
		return;
	}

	tbl.srchDisp =  $('#srch-disposition option:selected').val();
	tbl.edinDisp = $('#edin-disposition option:selected').val();

	dispDict = {};
	dispDict['action'] = action;
	disposition_id = $('#disp-id').val();
	if( disposition_id.length > 0){
		dispDict['disposition_id'] = disposition_id;
	}
	if( action !== 'Delete'){
		dispDict['disposition'] = $('#disp-disposition').val();
	}

	beforeSend();
	$.ajax({url: "../update_dispositions/", 
		type: "POST",
		data: $.param(dispDict),
		success: function(result){
			var myArray = result.split('SplitHere');
			$('#table-edit-dispositions').replaceWith(myArray[0]);
			$('.disposition-select').replaceWith(myArray[1])

  			$("#srch-disposition option").each(function() {
			  	if($(this).val() === tbl.srchDisp) {
			    	$(this).prop('selected', true);
			    	return false;
			  	}        
			});		
			$("#edin-disposition option").each(function() {
			  	if($(this).val() === tbl.edinDisp) {
			    	$(this).prop('selected', true);
			    	return false;
			  	}        
			});	
			if(action === 'Edit'){
				tbl.resetHighlight = true;
				performSearch();
			}
		},
    	error: function(result) {
    		popInfo(result['responseText'])
    		// alert("error: " + result.responseText);
    	}  
	}); 	
	$("#updateDisp").remove();

}

function beforeSend(){

	var csrftoken=getCookie('csrftoken');
	$.ajaxSetup({
	    beforeSend: function(xhr, settings) {
	        xhr.setRequestHeader("X-CSRFToken", csrftoken);
	    }
	});
}

function myPop(myId, myTitle, myContent, myStyle, myFunc, numberButtons){		
	
	if( document.getElementById(myId) !== null){
		alert("Already used id: " + myId);
		return;
	};	
	// var s = '<div id="' + myId + '" class="popup draggable" style="' + myStyle + '">';
	var s = "<span id = '" + myId + "' class='popup draggable' style= 'border: 1px solid #505050;" + myStyle + "'>";
	s += '<h3>' + myTitle + '</h3>';
	s += '<p>' + myContent + '</p>';
	// s += '<br/>';
	if(numberButtons > 0){
		s += '<button  onclick="' + myFunc + ';$(this).parent().remove()">OK</button>';
	}
	if(numberButtons > 1){
		s += '<div style="width:10px;height:auto;display:inline-block;" />';
		s += '<button onclick="$(this).parent().remove()">Cancel</button>';	
	}
	s += '</span>';	
	$('#pop-span').append(s);	
	$("#" + myId).css("display", "inline-block");
	$("#" + myId).css("visibility", "visible");
	// $("#" + myId).css("left",left);
	// $("#" + myId).css("top",top);
	centerMe($("#" + myId));
}

function popWarning(obj, warning){
	
	var s = "<span id = 'warning' class= 'popup' onclick='$(this).remove()' class='popup' style='color:red;'>";
	s += warning + "<br />Click to close.</span>";
	
	var left = ($(obj).offset().left + 50).toString() + 'px';
	var top = ($(obj).offset().top + 20).toString() + 'px';

	$('#pop-span').append(s);
	$("#warning").css('display','inline-block');
	$("#warning").css("visibility", "visible");
	$("#warning").css("left",left);
	$("#warning").css("top",top);

}

function popInfo(info){ 

	
	var s = "<span id = 'info' class= 'popup draggable' ";
	s += "style='width:200px;padding:20px; color:black;border:1px solid  #505050;'>";
	s += "<p>" + info + "</p>";
	s += "<button style='color:#fff;background-color:#337ab7;border-color:#eea236;' ";
	s += "onclick='$(this).parent().remove()'>OK</button>";
	s += "</span>";

	$('#pop-span').append(s);
	$("#info").css('display','inline-block');
	$("#info").css("visibility", "visible");
	centerMe($("#info"));
}

function centerMe(obj){

    obj.css({
        position:'absolute',
        left: ($(window).width() - obj.outerWidth())/2,
        top: ($(window).height() - obj.outerHeight())/2
    });
}

function testButton(){
//	alert("hello");
	// alert( $('#in-disposition option:selected').text());
}




