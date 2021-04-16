<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function() {
	$(document).on('click', '#search_id', function(){
		if($("#mail_1").val().trim() == "" || $("#mail_2").val().trim()==""){
			alert('이메일을 입력해주세요.');
		} else {
			$.ajax({
	            url : './id_check_ok.do',
	            type : 'post',
	            dataType: 'xml',
	            data : {
	               'mail_1' : $('#mail_1').val(),
	               'mail_2' : $('#mail_2').val()
	            },
	            success : function(data){	            	
	            	//console.log('flag : ' + $(data).find("idsearch_flag").text() + '  id : '+ $(data).find("id").text());
	            	if($(data).find("idsearch_flag").text() === "0"){
	            		let result_id = "<div class='shadow p-3 mb-5 bg-body rounded' style='padding:5%;' align='center'> 확인된 아이디는 <span class='fs-4' style='color:blue; border-bottom: solid blue 1px;'>&nbsp;"+$(data).find("id").text()+"&nbsp;</span> 입니다.</div>";
	            		$("#result_search").html(result_id);
	            	} else if($(data).find("idsearch_flag").text() === "1"){
	            		alert("등록된 정보가 없습니다. 정확한 이메일을 입력해주세요.");
	            	} else {
	            		alert("DataBase Error 입니다. 죄송합니다.");
	            	}
	            },
	            error : function(){
	            	alert("서버 Error 입니다. 죄송합니다.");
	            }
            });      
		}	
	});
});

</script>
<div >
	<div class="modal-header">
        <h2 class="modal-title">아이디 찾기</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
    	<div style="padding-left:5%; padding-top:2%;" class="fs-5"> 가입 시, 입력한 이메일을 입력해주세요</div>
		<div style="padding-left:7%; color:blue;" class="fs-7"> * 네이버 로그인을 이용한 경우, 네이버에서 아이디를 찾을 수 있습니다.</div>
		<div style="padding-left:5%; padding-top:1%; padding-bottom: 3%;">
			<input type="text" size="12" id="mail_1"/>
			<span>&nbsp; @ &nbsp;</span>
			<input type="text" size="15" id="mail_2" />
    	</div>
    	<div style="padding-left:5%; padding-right:5%" id="result_search">
	    	<div></div>
   		</div>
    </div >
    <div class="modal-footer" style="margin-top:-3%;">
    	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
    	<button type="button" class="btn btn-primary" id="search_id">찾기</button>
    </div>
</div>