
var ajaxRequest;
var silentValue = "1";


$('form').on('submit', function(form) {
     form.preventDefault();
     
     var title = $('#exampleInputTitle').val();
     var msg = $('#exampleInputMessage').val();
     
     if (title != "" && msg != "") {
	    
	    var uri = "/notify";
             var json = {"title": title, "message": msg, "silentValue":silentValue};
	     
		ajaxRequest = $.ajax({
		            url: uri,
		            type: "POST",
		            contentType: "application/json; charset=utf-8",
					dataType: "json",
		            data: JSON.stringify(json)
		        });
		
			/* Alert the user when finished without error */
		     ajaxRequest.done(function (response, textStatus, jqXHR){
		          alert("Sucessfully Submitted");
		     });
		
		     /* If the call fails  */
		     ajaxRequest.fail(function (jqXHR, textStatus, errorThrown){
		        // Log the error
		        console.error(
		            "The following error occurred: "+
		            textStatus, errorThrown
		        );
		    });
	     
	     $('#exampleInputTitle').val('');
		 $('#exampleInputMessage').val('');
     }
     
     
});



$("#silent").click(function(){
                   if (silentValue == "1"){
                   this.value = "Silent: ON";
                   silentValue = "0";
                   } else {
                   silentValue = "1";
                   this.value = "Silent: OFF";
                   }
                   });



