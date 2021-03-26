<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.exam.zipcode.ZipcodeTO"%>
<%@page import="java.util.ArrayList"%>    
    
<%
	ArrayList<ZipcodeTO> lists = (ArrayList)request.getAttribute("lists");
	//System.out.println(lists.size());
	
	StringBuffer html = new StringBuffer();
	for(ZipcodeTO to: lists){
		html.append("<button type='button' class='list-group-item list-group-item-action' aria-current='true'>");
		html.append("["+to.getZipcode()+"]"+" "+to.getSido()+" "+to.getGugun()+" "+to.getDong()+" "+to.getRi()+" "+to.getBunji());
		html.append("</button>");
	}

%>
<style type="text/css">
.list-group{
    max-height: 300px;
    margin-bottom: 10px;
    overflow:scroll;
    -webkit-overflow-scrolling: touch;
}
.button1, .button2{
	width: 30px;
	font-size: 25px;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){ 
	$('#address_select').val($('#address').val());
	$('#address').val('');
	$('#ok').click(function(){
		 $('#address').val($('#address_select').val());
	  });
	
	$('.list-group button').click(function(e){
		$('#address_select').val($(this).tab().text());
		$(this).tab('show')
	});
	
	$("#zipsearch-btn").click(function(){
		//console.log('버튼 클릭');
		//$('.modal-content').load("./zipsearch.do?strDong="+$('#address_select').val());
		const regexp2 = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|0-9]{2,12}$/;
		if(!regexp2.test($('#address_select').val().trim())){
			alert('동이름으로 검색해주세요');
			return;
		}else{
			//console.log($('#address_select').val());
			$('.modal-content').load("./zipsearch.do?strDong="+$('#address_select').val());	
		}
		
  });
		
	
});

	

</script>  
	<div class="modal-header">
		<h5 class="modal-title">주소 찾기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	</div>
	<div class="modal-body">
		<div class="input-group mb-3">
			<input type="text" class="form-control" placeholder="주소" id="address_select">
			<button class="btn btn-outline-secondary" type="button" id="zipsearch-btn">검색</button>
		</div>
		<div class="list-group">
			<%=html %>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="ok">확인</button>
	</div>