<%@page import="com.exam.user.UserTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.theseMonthBoard.Board_CommentTO"%>
<%@page import="com.exam.theseMonthBoard.Home_BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 시, 해당 게시글 좋아요 유무
	int like_count_check = 0;
	UserTO userInfo = null;
	String userID = null;
	String userSeq = null;
	if (session.getAttribute("userInfo") != null) {
		userInfo= (UserTO)session.getAttribute("userInfo");
		userID = userInfo.getId();
		userSeq = userInfo.getSeq();
		like_count_check = (Integer)request.getAttribute("like_count_check");
	}
	
	//본인 게시글 일 시, 수정/삭제 버튼 생성
   StringBuffer likey_button = new StringBuffer();
   if(like_count_check != 0){
      likey_button.append("<button value='like' class='btn' id= 'button_likey' ><i class='fas fa-heart' style='font-size: 25px; color: red;'></i></button>");
   } else {
      likey_button.append("<button value='like' class='btn' id= 'button_likey' ><i class='far fa-heart' style='font-size: 25px;'></i></button>");
   }

	//board 데이터 로드
	Home_BoardTO to = (Home_BoardTO)request.getAttribute("home_BoardTO");
	String seq = to.getSeq();
	String date = to.getDate().substring(0, 11);
	String title = to.getTitle();
	String nickname = to.getNickname();
	String[] filenames = to.getFilename().split("//");
	String content = to.getContent();
	String bookseq = to.getBseq();
	String book_title = to.getBook_title();
	String comment = to.getComment();
	String hit = to.getHit();
	String boardUserSeq = to.getUseq();
	String UserID_board = to.getUserID();
	String board_profile = to.getProfile();
	
	// StringBuffer를 통한 board데이터 
	StringBuffer commentHTML = new StringBuffer();
	ArrayList<Board_CommentTO> comment_lists = (ArrayList)request.getAttribute("board_commentTO");
	
	if(comment_lists.size() == 0){
		commentHTML.append("<li style='padding:20px 20px'>등록된 댓글이 없습니다. 댓글을 통해 소통해봐요!</li>");
	} else {
		for (Board_CommentTO comment_to : comment_lists){
			String comment_useq = comment_to.getUseq();
			String comment_nickname = comment_to.getNickname();
			String comment_profile = comment_to.getFilename();
			String comment_content = comment_to.getContent();
			String comment_date_time = comment_to.getDate_time().substring(0,16);
			commentHTML.append("<li class='comment' comment_seq='"+comment_to.getSeq()+"' comment_nickname='"+comment_nickname+"' comment_text='"+comment_content+"' comment_date='"+comment_date_time+"'>");
			commentHTML.append("<div style='float:left; width:610px'>");
			commentHTML.append("<span class='pic' style='float:left; margin:0px; padding:5px 5px 5px 5px;'>");
			commentHTML.append("<img class='profile_img' src='./profile/"+comment_profile+"' style='float:left' />");
			commentHTML.append("</span>");
			commentHTML.append("<span class='txt' style='margin:0px; padding:2px 5px 2px 2px;'>");
			
			//commentHTML.append("<span id='c_txt"+comment_to.getSeq()+"'><a href='./mypage.do?"+comment_to.getSeq()+" style='text-decoration: none; color:black;'><span style='font-size:18px;'><b>"+comment_nickname+"</b></span></a>&nbsp;&nbsp;"+comment_content+"&nbsp;&nbsp;<span style='color:#dcdcdc; font-size:3px;'>"+comment_date_time+"</span></span>");
			commentHTML.append("<span id='c_txt"+comment_to.getSeq()+"'>");
			if(!comment_useq.equals("-1")){
				commentHTML.append("	<a href='./mypage.do?useq="+comment_useq+"' style='text-decoration: none; color:black;'>");	
			}else{
				commentHTML.append("	<a style='text-decoration: none; color:black;'>");
			}
			
			commentHTML.append("		<span style='font-size:18px;'><b>"+comment_nickname+"</b></span>");
			commentHTML.append("	</a>&nbsp;&nbsp;");
			commentHTML.append("	<span>"+comment_content+"</span>&nbsp;&nbsp;");
			commentHTML.append("	<span style='color:#dcdcdc; font-size:3px;'>"+comment_date_time+"</span>");
			commentHTML.append("</span>");
				
			commentHTML.append("<input type='hidden' class='modify_input' id='modify_input"+comment_to.getSeq()+"' size='40' value='"+comment_content+"'/>");
			commentHTML.append("<button type='button' class='modify_ok_btn btn btn-sm btn-secondary' id='modify_ok_btn"+comment_to.getSeq()+"' comment_seq='"+comment_to.getSeq()+"' style='display:none; margin-left:10px;'>수정</button>");
			commentHTML.append("</span>");
			//style="display: none;
			if(comment_to.getUseq().equals(userSeq)){
				commentHTML.append("<div class='btn-group dropend'>");
				commentHTML.append("<button type='button' class='btn d-inline-block dropdown-bs-toggle' data-bs-toggle='dropdown' id='menu-btn' style='padding:6px 3px; color:#dcdcdc;'><i class='fas fa-ellipsis-h'></i></button>");
				commentHTML.append("<ul class='dropdown-menu'>");
				commentHTML.append("  <li><button type='button' class='dropdown-item comment_modify' comment_seq='"+comment_to.getSeq()+"'>수정</button></li>");
				commentHTML.append("  <li><button type='button' class='dropdown-item comment_delete' comment_seq='"+comment_to.getSeq()+"'>삭제</button></li>");
				commentHTML.append("</ul>");
				commentHTML.append("</div>");
			}
			commentHTML.append("</div>");
			commentHTML.append("</li>");
		}
	}
	// 좋아요 갯수 표시 --> viewpage open에
	int likey_count = (Integer)request.getAttribute("likey_count");

%>
<link rel="stylesheet" type="text/css" href="./css/flexslider.css">
<script type="text/javascript" src="./js/jquery.flexslider-min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">



<style type="text/css">
.profile_img {
	padding: 5px;
	width: 45px;
	height: 45px;
	border-radius: 50%;
	}
#img_preview{
	width: 500px; 
	height: 500px;
	}
.userID{
	color: #d2d2d2;
}	

ul, ol, li{ margin:0; padding:0; list-style:none;}

</style>
<script>
$(document).ready(function(){
	$(".flexslider").flexslider({
		animation: "slide",	
		slideshow: false,
		disableDragAndDrop: true,
	});	
	
	// 모달창 x 버튼 누르면 페이지 리로드
	$('#close-btn').on('click', function(){
		location.reload();
	});
	
	$('#view-modal').on('hidden.bs.modal', function(){
		location.reload();
	// 음... .viewcontent --> text 비우기 생각하기!!!!!!!!!!!!!!!!!!!!!!!!!!
	});
	
	$('#board_modify').click(function(e){
		//alert($(this).attr('bseq')+"클릭");
		//console.log("./view.do?seq=" + $(this).attr('bseq'));
		$('.view-content').load("./modify.do?seq=" + <%=seq%>);
	});
		
	// 게시글 삭제
	$(function() {
		$("#board_delete").click(function() {
			var delete_confirm = confirm("삭제 하시겠습니까?");
			if(delete_confirm == true){
				$.ajax({
					url : './board_delete_ok_xml.do',
					type : 'POST',
					data : {
						"value" : "delete",
						"user" : "<%=userSeq %>",
						"bseq" : <%=seq %>
					},
					success : function (data) {
						if($(data).find('flag').text()==1){
							alert("게시글이 삭제 되었습니다.");
							location.reload();
						}else{
							alert("게시글 삭제에 실패했습니다.");
						}
					},
					error : function (error){
						console.log('Error');
					}
				});
			}
		});
	});

	// like && unlikey
	$(function() {
		let like_count_check = <%=like_count_check%>;
		$(document).on("click","#button_likey",function(){
			if(like_count_check == 0){
				<% 
					if (userInfo != null) { //로그인 되어있는 경우
				%>
						$.ajax({
							url : './likey.do',
							type : 'POST',
							data : {
								"value" : "likey",
								"user" : "<%=userSeq %>",
								"bseq" : <%=seq %>
							},
							async : false,
							success : function (data) {
								let result = "좋아요 ";
								result += Number($(data).find('result').text());
								result += "개";
								$("#ajax_likey_count").html(result);
								like_count_check = Number($(data).find('resultcheck').text());
								$("#button_likey").html("<i class='fas fa-heart' style='font-size: 25px; color: red;'>");
								//.attr('style', 'font-size: 25px; color: red;');
								//console.log("like_count_check :" + like_count_check);
							},
							error : function (request,status,error){
								console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
							}
						});
					<%
					} else { // 로그인이 안되어 있는 경우 --> 로그인 창 --> 로그인 후 현 페이지로 돌아오는 거 필요
					%>
						var comfirm_login = confirm("로그인이 필요한 서비스입니다. \n'확인'버튼을 클릭 시, 로그인 창으로 이동합니다.");
							if(comfirm_login == true){
								location.href="login.do";
							}
					<% } %>
				} else if(like_count_check >= 1){	
					$.ajax({
						url : './likey.do',
						type : 'POST',
						data : {
							"value" : "unlikey",
							"user" : "<%=userSeq %>",
							"bseq" : <%=seq %>
						},
						async : false,
						success : function (data) {	
							let result = "좋아요 ";
							result += $(data).find('result').text();
							result += "개";
							
							$("#ajax_likey_count").html(result);
							like_count_check = Number($(data).find('resultcheck').text());
							$("#button_likey").html("<i class='far fa-heart' style='font-size: 25px;'>");
							//.attr('style', '');
							//console.log("like_count_check :" + like_count_check);
						},
						error : function (request,status,error){
							console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});
				}
		});
	});

	// comment create 
	$(function() {
		$(document).on("click","#comment_btn",function(){
			<%
			if (userInfo != null) {
				userID = userInfo.getId();
			%>
				let comment = $('#comment_text_input').val();
				if(comment == ''){
					alert('댓글을 입력해주세요');
					$('#comment_text').focus();
				} else if(comment.length < 5){
					alert('최소 5자 이상 입력이 필요합니다.');
					$('#comment_text').focus();
				} else if(comment.length > 2000){
	                  alert('2000자까지만 입력 가능합니다.');
	                  $('#comment_text').focus();
				} else {
					$.ajax({
						url : './comment.do',
						type : 'POST',
						data : {
							"value" : "create",
							"user" : "<%=userSeq %>",
							"comment" : comment,
							"seq" : <%=seq %>
						},
						success : function (data_xml) {
							alert('댓글 입력 완료');
							let result = "";
							$(data_xml).find('comment').each(function(){
								let useq = $(this).find('useq').text();
								let date_time = $(this).find('date_time').text().substring(0,19);
								
								result +="<li class='comment' comment_seq='"+$(this).find('seq').text()+"' comment_nickname='"+$(this).find('nickname').text()+"' comment_text='"+$(this).find('content').text()+"' comment_date='"+date_time+"'>"
								result+="<div style='float:left; width:610px'>";
								result+="<span class='pic' style='float:left; margin:0px; padding:5px 5px 5px 5px;'>";
								result+="<img class='profile_img' src='./profile/"+$(this).find('profile').text()+"' style='float:left' />";
								result+="</span>";
								result+="<span class='txt' style='margin:0px; padding:2px 5px 2px 2px;'>";
								
								//result+="<span id='c_txt"+$(this).find('seq').text()+"'><span style='font-size:18px;'><b>"+$(this).find('nickname').text()+"</b></span>&nbsp;&nbsp;"+$(this).find('content').text()+"&nbsp;&nbsp;<span style='color:#dcdcdc; font-size:3px;'>"+date_time+"</span></span>";
								result+="<span id='c_txt"+$(this).find('seq').text()+"'>";
								if(useq!="-1"){
									result+="	<a href='./mypage.do?useq="+useq+"' style='text-decoration: none; color:black;'>";	
								}else{
									result+="	<a style='text-decoration: none; color:black;'>";
								}
								
								result+="		<span style='font-size:18px;'><b>"+$(this).find('nickname').text()+"</b></span>";
								result+="	</a>&nbsp;&nbsp;";
								result+="	<span>"+$(this).find('content').text()+"</span>&nbsp;&nbsp;";
								result+="	<span style='color:#dcdcdc; font-size:3px;'>"+date_time+"</span>";
								result+="</span>";
								
								result+="<input type='hidden' class='modify_input' id='modify_input"+$(this).find('seq').text()+"' size='40' value='"+$(this).find('content').text()+"'/>";
							    result+="<button type='button' class='modify_ok_btn btn btn-sm btn-secondary' id='modify_ok_btn"+$(this).find('seq').text()+"' comment_seq='"+$(this).find('seq').text()+"' style='display:none; margin-left:10px;'>수정</button>";
								result+="</span>";
								if(useq == <%=userSeq%>){
									result+="<div class='btn-group dropend' style='z-index:10'>";
									result+="<button type='button' class='btn d-inline-block dropdown-bs-toggle' data-bs-toggle='dropdown' id='menu-btn' style='padding:6px 3px; color:#dcdcdc;'><i class='fas fa-ellipsis-h'></i></button>";
									result+="<ul class='dropdown-menu'>";
									result+="  <li><button type='button' class='dropdown-item comment_modify' comment_seq='"+$(this).find('seq').text()+"'>수정</button></li>";
							        result+="  <li><button type='button' class='dropdown-item comment_delete' comment_seq='"+$(this).find('seq').text()+"'>삭제</button></li>";
									result+="</ul>";
									result+="</div>";
								}
								result+="</div>";
								result+="</li>";
							});
							$('#comment_list').html(result);
							$('#comment_text_input').val('');
						},
						error : function (error){
							console.log('Error');
						}
					});	
					
				}
				
				
			<%
			} else {
			%>
				var comfirm_login = confirm("로그인이 필요한 서비스입니다. \n'확인'버튼을 클릭 시, 로그인 창으로 이동합니다.");
				if(comfirm_login == true){
					location.href="login.do";
				}	
			<% } %>
		});
	});

	//comment_modify
	$(document).ready(function () { //$(document).read --> 페이지가 로드되었을 때, // $(document).on("click","#comment_modify",function(){
		$(document).on("click",".comment_modify",function(){
			let cseq=$(this).attr('comment_seq');	
			$('#c_txt'+cseq).hide();
			$('#modify_input'+cseq).attr('type', 'text');
			$('#modify_ok_btn'+cseq).show();
		});
		
		$(document).on('click', '.modify_ok_btn', function(){
			let comment_seq=$(this).attr('comment_seq');
			let comment_text = $('#modify_input'+comment_seq).val();
			
			if(comment_text.length < 5){
				alert('최소 5자 이상 입력이 필요합니다.');
				$('#modify_input'+comment_seq).focus();
			} else {
				$.ajax({
					url : './comment.do',
					type : 'POST',
					data : {
						"value" : "modify",
						"comment_seq" : comment_seq,
						"comment" : comment_text,
						"seq" : <%=seq%>
					},
					success : function (data_xml) {
						alert('댓글 수정 완료');
						let result = "";
						$(data_xml).find('comment').each(function(){
							let useq = $(this).find('useq').text();
							let date_time = $(this).find('date_time').text().substring(0,19);
							
							result +="<li class='comment' comment_seq='"+$(this).find('seq').text()+"' comment_nickname='"+$(this).find('nickname').text()+"' comment_text='"+$(this).find('content').text()+"' comment_date='"+date_time+"'>"
							result+="<div style='float:left; width:610px'>";
							result+="<span class='pic' style='float:left; margin:0px; padding:5px 5px 5px 5px;'>";
							result+="<img class='profile_img' src='./profile/"+$(this).find('profile').text()+"' style='float:left' />";
							result+="</span>";
							result+="<span class='txt' style='margin:0px; padding:2px 5px 2px 2px;'>";
							//result+="<span id='c_txt"+$(this).find('seq').text()+"'><span style='font-size:18px;'><b>"+$(this).find('nickname').text()+"</b></span>&nbsp;&nbsp;"+$(this).find('content').text()+"&nbsp;&nbsp;<span style='color:#dcdcdc; font-size:3px;'>"+date_time+"</span></span>";
							result+="<span id='c_txt"+$(this).find('seq').text()+"'>";
							if(useq!="-1"){
								result+="	<a href='./mypage.do?useq="+useq+"' style='text-decoration: none; color:black;'>";	
							}else{
								result+="	<a style='text-decoration: none; color:black;'>";
							}
							
							result+="		<span style='font-size:18px;'><b>"+$(this).find('nickname').text()+"</b></span>";
							result+="	</a>&nbsp;&nbsp;";
							result+="	<span>"+$(this).find('content').text()+"</span>&nbsp;&nbsp;";
							result+="	<span style='color:#dcdcdc; font-size:3px;'>"+date_time+"</span>";
							result+="</span>";
							result+="<input type='hidden' class='modify_input' id='modify_input"+$(this).find('seq').text()+"' size='40' value='"+$(this).find('content').text()+"'/>";
						    result+="<button type='button' class='modify_ok_btn btn btn-sm btn-secondary' id='modify_ok_btn"+$(this).find('seq').text()+"' comment_seq='"+$(this).find('seq').text()+"' style='display:none; margin-left:10px;'>수정</button>";
							result+="</span>";
							if(useq == <%=userSeq%>){
								result+="<div class='btn-group dropend'>";
								result+="<button type='button' class='btn d-inline-block dropdown-bs-toggle' data-bs-toggle='dropdown' id='menu-btn' style='padding:6px 3px; color:#dcdcdc;'><i class='fas fa-ellipsis-h'></i></button>";
								result+="<ul class='dropdown-menu'>";
								result+="  <li><button type='button' class='dropdown-item comment_modify' comment_seq='"+$(this).find('seq').text()+"'>수정</button></li>";
						        result+="  <li><button type='button' class='dropdown-item comment_delete' comment_seq='"+$(this).find('seq').text()+"'>삭제</button></li>";
								result+="</ul>";
								result+="</div>";
							}
							result+="</div>";
							result+="</li>";
						});
						$('#comment_list').html(result);
						
					},
					error : function (error){
						console.log('Error');
					}
				});	
			}		
		});
		
	});

	//comment_delete
	$(function () {
		$(document).on("click",".comment_delete",function(){
			let comment_delete_confirm = confirm("댓글을 삭제하시겠습니까?");
			if(comment_delete_confirm == true){
				let comment_text = $("#comment_text").val();
				let comment_seq = $(this).attr("comment_seq");
				console.log(comment_seq);
				$.ajax({
					url : './comment.do',
					type : 'POST',
					data : {
						"value" : "delete",
						"comment_seq" : comment_seq,
						"comment" : comment_text,
						"seq" : <%=seq %>
					},
					success : function (data_xml){
						let result = "";
						$(data_xml).find('comment').each(function(){
							let useq = $(this).find('useq').text();
							let date_time = $(this).find('date_time').text().substring(0,19);
							
							result +="<li class='comment' comment_seq='"+$(this).find('seq').text()+"' comment_nickname='"+$(this).find('nickname').text()+"' comment_text='"+$(this).find('content').text()+"' comment_date='"+date_time+"'>"
							result+="<div style='float:left; width:610px'>";
							result+="<span class='pic' style='float:left; margin:0px; padding:5px 5px 5px 5px;'>";
							result+="<img class='profile_img' src='./profile/"+$(this).find('profile').text()+"' style='float:left' />";
							result+="</span>";
							result+="<span class='txt' style='margin:0px; padding:2px 5px 2px 2px;'>";
							//result+="<span id='c_txt"+$(this).find('seq').text()+"'><span style='font-size:18px;'><b>"+$(this).find('nickname').text()+"</b></span>&nbsp;&nbsp;"+$(this).find('content').text()+"&nbsp;&nbsp;<span style='color:#dcdcdc; font-size:3px;'>"+date_time+"</span></span>";
							result+="<span id='c_txt"+$(this).find('seq').text()+"'>";
							if(useq!="-1"){
								result+="	<a href='./mypage.do?useq="+useq+"' style='text-decoration: none; color:black;'>";	
							}else{
								result+="	<a style='text-decoration: none; color:black;'>";
							}
							
							result+="		<span style='font-size:18px;'><b>"+$(this).find('nickname').text()+"</b></span>";
							result+="	</a>&nbsp;&nbsp;";
							result+="	<span>"+$(this).find('content').text()+"</span>&nbsp;&nbsp;";
							result+="	<span style='color:#dcdcdc; font-size:3px;'>"+date_time+"</span>";
							result+="</span>";
							result+="<input type='hidden' class='modify_input' id='modify_input"+$(this).find('seq').text()+"' size='40' value='"+$(this).find('content').text()+"'/>";
						    result+="<button type='button' class='modify_ok_btn btn btn-sm btn-secondary' id='modify_ok_btn"+$(this).find('seq').text()+"' comment_seq='"+$(this).find('seq').text()+"' style='display:none; margin-left:10px;'>수정</button>";
							result+="</span>";
							if(useq == <%=userSeq%>){
								result+="<div class='btn-group dropend'>";
								result+="<button type='button' class='btn d-inline-block dropdown-bs-toggle' data-bs-toggle='dropdown' id='menu-btn' style='padding:6px 3px; color:#dcdcdc;'><i class='fas fa-ellipsis-h'></i></button>";
								result+="<ul class='dropdown-menu'>";
								result+="  <li><button type='button' class='dropdown-item comment_modify' comment_seq='"+$(this).find('seq').text()+"'>수정</button></li>";
						        result+="  <li><button type='button' class='dropdown-item comment_delete' comment_seq='"+$(this).find('seq').text()+"'>삭제</button></li>";
								result+="</ul>";
								result+="</div>";
							}
							result+="</div>";
							result+="</li>";
						});
						$('#comment_list').html(result);
					},
					error : function (error){
						console.log('Error');
					}
				});	
			}
		});
	});
});
	
	

</script>



 
    
<div class="modal-body" style="padding:0;">
	<table>
		<tr>
			<td>
				<div id="img_preview" class="flexslider">
        			<ul class="slides">
        				<% for(String filename : filenames){%>
        					<li><img src="./upload/<%=filename %>" style="width : 500px; height : 500px;"/></li>
                        <%} %>
        			</ul>
        		</div>
			</td>
			<td>
				<table width=100%>
					<tr class="writerInfo button-bar" style="border-bottom:1px solid #d2d2d2;">
						<td>
							<img class="profile_img" src="./profile/<%=board_profile %>">
							<a href='./mypage.do?useq=<%=boardUserSeq %>' style="text-decoration: none; color:black;"><b><span class="nickname"><%=nickname %></span></b></a>
							<span class="userID">(<%=UserID_board %>)</span>
							<span>
								&nbsp;&nbsp;
								<span class="date"style="color:#d2d2d2;">작성일자 : <%= date %></span>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="hit" style="color:#d2d2d2;">조회수: <%=hit %></span>
							</span>
							<div class="d-inline-block" style="float:right;">
								<%if(userID != null && userID.equals(UserID_board)){ %>
									<div class="btn-group dropup">
										<button type="button" class="btn d-inline-block dropdown-bs-toggle" data-bs-toggle="dropdown" id="menu-btn" style="padding:6px 3px; color:#dcdcdc;"><i class="fas fa-ellipsis-h"></i></button>
										<ul class="dropdown-menu">
										   <li><button type="button" class="dropdown-item" id="board_modify">수정</button></li>
										   <li><button type="button" class="dropdown-item" id="board_delete">삭제</button></li>
										</ul>
									</div>
								<%} %>
								<button type="button" class="btn d-inline-block" id="close-btn" style="padding:6px 12px 6px 3px; color:#dcdcdc;"><i class="fas fa-times"></i></button>
							</div>
							
							
						</td>
					</tr>
					<tr class="bookInfo">
						<td>
							<span style="float:right; padding:2px 10px">
								<a href='./book_info.do?master_seq=<%=bookseq %>' style="text-decoration: none; color:black;"><i class="fas fa-book-open"></i>&nbsp;<%=book_title %></a>
							</span>
						</td>
					</tr>	
					<tr class="boardInfo">
						<td>
							<table>
								<tr>
									<td>
										<p id="board_title" style="border-bottom:1px solid #d2d2d2; padding:2px 20px; margin:0px;">
											<%=title%> 
										</p>
									</td>
								</tr>
								<tr>
									<td>
			 							<div id="content"  wrap="hard" id="board_content" style="width:628px; height:215px; overflow-y: scroll; padding:10px; border-bottom:1px solid #d2d2d2;">
											<%=content %>
										</div>
									</td>
								</tr>
								<tr class="comment-area">
									<td>
										<div style="height:95px; width:628px; overflow-y: scroll;">
											 <ul id="comment_list">
												<%= commentHTML %>
											 </ul>
										</div>
									</td>
								</tr>
								<tr class="action-area">
									<td>
										<div style="height:45px; width:628px; border-top:1px solid #d2d2d2">										
											<%=likey_button %>
											<sapn id="ajax_likey_count">
												좋아요  <%=likey_count %>개
											</sapn>
											<table>
												<tr>
											    	<td>
														<input type="text" placeholder="댓글을 입력해주세요." size="55" id="comment_text_input"/>
													</td>
													<td>
														<button value="등록하기" height="100" id="comment_btn" class="btn"><i class="fas fa-arrow-circle-up" style="font-size: 20px;"></i></button>
											        </td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>								
				</table>
			</td>
		</tr>
	</table>
	<br/>
</div>
