<%@page import="com.exam.user.UserTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.theseMonthBoard.Board_CommentTO"%>
<%@page import="com.exam.theseMonthBoard.Home_BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

		// 댓글 작성 및 좋아요 누를 시 --> 조회수도 같이 증가 --> 좋아요, 댓글 관련 ajax 처리
		// 모달 반복 클릭 시, --> 배경계속 까매짐 --> 

	//로그인 시, 해당 게시글 좋아요 유무
	int like_count_check = 0;
	//현재 세션 상태를 체크한다
	UserTO userInfo = null;
	String userID = null;
	String userSeq = null;
	if (session.getAttribute("userInfo") != null) {
		userInfo= (UserTO)session.getAttribute("userInfo");
		userID = userInfo.getId();
		userSeq = userInfo.getSeq();
		like_count_check = (Integer)request.getAttribute("like_count_check");
		//System.out.println(like_count_check);
	}
	
	StringBuffer likey_button = new StringBuffer();
	if(like_count_check != 0){
		likey_button.append("<input type='button' value='like' style='color : white; background-color : gray;' id= 'button_likey' />");
	} else {
		likey_button.append("<input type='button' value='like' id= 'button_likey' />");
	}

	Home_BoardTO to = (Home_BoardTO)request.getAttribute("home_BoardTO");
	String seq = to.getSeq();
	String date = to.getDate().substring(0, 11);
	String title = to.getTitle();
	String nickname = to.getNickname();
	String filename = to.getFilename();
	String content = to.getContent();
	String book_title = to.getBook_title();
	String comment = to.getComment();
	String hit = to.getHit();
	String boardUserID = to.getUserID();
	//String useq = to.getUseq();
	String UserID_board = to.getUserID();
	
	StringBuffer commentHTML = new StringBuffer();
	ArrayList<Board_CommentTO> comment_lists = (ArrayList)request.getAttribute("board_commentTO");
	if(comment_lists.size() == 0){
		commentHTML.append("<tr><td colspan='4'>등록된 댓글이 없습니다. 댓글을 통해 소통해봐요!</td></tr>");
	} else {
		for (Board_CommentTO comment_to : comment_lists){
			String comment_nickname = comment_to.getNickname();
			String comment_content = comment_to.getContent();
			String comment_date_time = comment_to.getDate_time();
			commentHTML.append("<tr>");
			if(comment_to.getUseq().equals(userSeq)){
				commentHTML.append("<td id='comment_seq' comment_seq_attr = '"+comment_to.getSeq()+"'>" + comment_nickname + "</td>");
				commentHTML.append("<td><div><textarea cols='55' rows='1' required wrap='hard' style='border:0px;' id='comment_text'>"+comment_content+"</textarea></div></td>");
				commentHTML.append("<td>"+comment_date_time+"</td>");
				commentHTML.append("<td><input type='button' id='comment_modify' value='수정' style='CURSOR:hand;' title='내용 수정 후, 버튼을 누르면 수정됩니다.' /><input type='button' id='comment_delete' value='삭제'/></td>");
			} else {
				commentHTML.append("<td>" + comment_nickname + "</td>");
				commentHTML.append("<td><div>"+comment_content+"</div></td>");
				commentHTML.append("<td colspan='2'>"+comment_date_time+"</td>");
			}
			commentHTML.append("</tr>");
		}
	}
	int likey_count = (Integer)request.getAttribute("likey_count");
	
	StringBuffer BoardUseq_match = new StringBuffer();
	if(!UserID_board.equals(userID)){
		BoardUseq_match.append("readonly");
	}
	

%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
	#comment {
		width : 520;
		height : 100;
	}
	#vertical2 {
		width: max-content;
		overflow-y: scroll;
		height : 70px;
	}
	#vertical1 {
		width: max-content;
		overflow-y: scroll;
		height : 230px;
	}
	.wrap {
		float: left;
	}
	.wrapTable table {
		border : 1px;
	}
	.wrapTable tr,th,td {
		padding : 5px;
		margin : 5px;
	}
	#wrapTable tr:hover {
		background-color : ivory;
		font-color : black; 
	}
	#wrapTable {
		font-size : 8px;
	}
</style>

<script type="text/javascript">

$(function() {
	// 등록하기 버튼 클릭 시, 알림창 생성 및 댓글 DB 입력
	$('#comment_btn').click(function () {
		<%
		if (userInfo != null) {
			userID = userInfo.getId();
		%>
			let comment = $('#comment_text').val();
			console.log(comment);
			if(comment == ''){
				alert('댓글을 입력해주세요');
				$('#comment_text').focus();
			} else if(comment.length < 5){
				alert('최소 5자 이상 입력이 필요합니다.');
				$('#comment_text').focus();
			} else {
				$.ajax({
					url : './comment.do',
					type : 'POST',
					data : {
						"user" : "<%=userID %>",
						"comment" : comment,
						"bseq" : <%=seq %>
					},
					success : function (data) {
						alert('댓글 입력 완료');
						//location.reload();
						$('.modal-content').load("./view.do" + "?seq=" + <%=request.getParameter("seq")%>);
						
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
// 좋아요 버튼
$(function() {
	$('#button_likey').click(function () {
		<%
			//System.out.println("like_count_check :"+ like_count_check );
			if( like_count_check == 0){ // like한 기록이 없는 경우
				if (userInfo != null) { //로그인 되어있는 경우
					userID = userInfo.getId();
			%>
					$.ajax({
						url : './likey.do',
						type : 'POST',
						data : {
							"user" : "<%=userID %>",
							"bseq" : <%=seq %>
						},
						success : function (data) {
							$('.modal-content').load("./view.do" + "?seq=" + <%=request.getParameter("seq")%>);
						},
						error : function (error){
							console.log('Error');
						}
					});
				<%
				} else { // 로그인이 안되어 있는 경우 --> 로그인 창 --> 로그인 후 현 페이지로 돌아오는 거 필요
				%>
					var comfirm_login = confirm("로그인이 필요한 서비스입니다. \n'확인'버튼을 클릭 시, 로그인 창으로 이동합니다.");
						if(comfirm_login == true){
							location.href="login.do";
						}	
			<% 
				}
			} else if (like_count_check >= 1){ // 좋아요 누는 기록이 있는 경우 
				userID = userInfo.getId();
				%>
				$.ajax({
					url : './unlikey.do',
					type : 'POST',
					data : {
						"user" : "<%=userID %>",
						"bseq" : <%=seq %>
					},
					success : function (data) {
						$('.modal-content').load("./view.do" + "?seq=" + <%=request.getParameter("seq")%>);
						//console.log('좋아요 기록 삭제 성공');
					},
					error : function (error){
						console.log('Error');
					}
				});
				
			<% }%>	
	});
});
// 제목 및 게시글 수정
$(function() {
	$("#modify").click(function() {
		//alert("수정 버튼 클락");
		let board_title = $("#board_title").val();
		let board_content = $("#board_content").val()
		console.log(board_title + "\n" + board_content);
		
		$.ajax({
			url : './board_modify.do',
			type : 'POST',
			data : {
				"user" : "<%=userSeq %>",
				"bseq" : <%=seq %>,
				"board_title" : board_title,
				"board_content" : board_content
			},
			success : function (data) {
				alert("게시글 수정 작업이 완료되었습니다.");
				$('.modal-content').load("./view.do" + "?seq=" + <%=request.getParameter("seq")%>);
			},
			error : function (error){
				console.log('Error');
			}
		});
	});
});

// 모달창 x 버튼 누르면 페이지 리로드
$(function (){
	$("#close_btn").click(function() {
		location.reload();
	});
});
// 게시글 삭제
$(function() {
	$("#delete").click(function() {
		var delete_confirm = confirm("삭제 하시겠습니까?");
		if(delete_confirm == true){
			$.ajax({
				url : './board_delete.do',
				type : 'POST',
				data : {
					"user" : "<%=userSeq %>",
					"bseq" : <%=seq %>
				},
				success : function (data) {
					alert("게시글이 삭제 되었습니다.");
					history.back(-2);
				},
				error : function (error){
					console.log('Error');
				}
			});
		}
	});
});
//comment_modify
$(function () {
	$("#comment_modify").click(function() {
		let comment_text = $("#comment_text").val();
		//console.log(comment_text);
		let comment_seq = $("#comment_seq").attr("comment_seq_attr");
		//console.log(comment_seq);
		if(comment_text.length < 5){
			alert('최소 5자 이상 입력이 필요합니다.');
			$('#comment_text').focus();
		} else {
			$.ajax({
				url : './comment_modify.do',
				type : 'POST',
				data : {
					"value" : "modify",
					"comment_seq" : comment_seq,
					"comment" : comment_text
				},
				success : function (data) {
					alert('댓글 수정 완료');
					$('.modal-content').load("./view.do" + "?seq=" + <%=request.getParameter("seq")%>);
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
	$("#comment_delete").click(function() {
		let comment_delete_confirm = confirm("댓글을 삭제하시겠습니까?");
		if(comment_delete_confirm == true){
			let comment_text = $("#comment_text").val();
			let comment_seq = $("#comment_seq").attr("comment_seq_attr");
			$.ajax({
				url : './comment_modify.do',
				type : 'POST',
				data : {
					"value" : "delete",
					"comment_seq" : comment_seq,
					"comment" : comment_text
				},
				success : function (data) {
					alert('댓글 삭제 완료');
					$('.modal-content').load("./view.do" + "?seq=" + <%=request.getParameter("seq")%>);
				},
				error : function (error){
					console.log('Error');
				}
			});	
		}
	});
});
</script>
       <table>
       	<tr>
       		<td rowspan="3" border="1"> <img src="./upload/<%=filename %>" style="width : 500px; height : 500px;"/></td>
       		<td >
	       		<table width="620" height="50">
	       			<tr>
	       				<td width="150">작성자 : <%=nickname %></td>
	       				<td width="180">작성 일자 : <%= date %></td>
	       				<td width="100">조회수 : <%=hit %></td>
	       				<td rowspan="2">
	       				<table>
	       				<% if (userInfo == null) {%> <!-- 로그인이 안되어 있을 시, 수정.삭제 버튼 x -->
	       					<tr><td></td></tr>
	       				<% } else if (userID != null && userID.equals(boardUserID)) { %> <!-- 로그인 o, Board의 useq랑 같을 때 -> 버튼 생성 -->
	       					<tr>
	       						<td>
	       							<input type="button" value="수정" id="modify" style="CURSOR:hand;" title="제목과 내용을 수정 후, '수정'버튼을 누르면 수정됩니다."/>
       							</td>
       							<td>
       								<input type="button" value="삭제" id="delete"/>
   								</td>
							</tr>
	       				<% }else {%> <!-- 그 외의 경우 버튼 생성 x -->
	       					<tr><td></td></tr>
	       				<% } %>
	       				</table>
	       				 	 
	       				</td >
	       				<td rowspan="2" align="top" width="30">
	       					<div align="right">
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="close_btn"></button></span>
						    </div>
	       				</td>
	       			</tr>
	       			<tr>
	       				<td colspan="3">책 제목 : <%=book_title %></td><td></td>
	       			</tr>
	       		</table>
       		</td>
       	</tr>
       	<tr>
       		<td>
       			<table width="600" height="350">
       			<tr><td height="10">제목 :  <input type="text" value="<%=title%>" id="board_title" size="69" <%=BoardUseq_match %>/></td></tr>
       				<tr height="230">
       					<td>
       						<!-- <div id="vertical1">
       							<div class="wrap"> 
       								<table border="1" height="230" width="580" class="wrapTable"> <tr><td>  -->
       								<textarea cols="78" rows="10" required wrap="hard" id="board_content" <%=BoardUseq_match %>><%=content %></textarea>
       								<!-- </td></tr></table>
       							</div>
       						</div>  -->
   						</td>
       				</tr>
       				<tr>
       					<td>
       						<div id="vertical2">
       							<div class="wrap">
       								<table border="1" height="70" width="580" id="wrapTable">
       								<tr>
       									<th width="80" >별명</th><th width="300">내용</th><th>일시</th><th style="padding-left : 5px;">비고</th>
       								</tr>
			       						<%= commentHTML %>
			       						
		       						</table>
       							</div>
       						</div>
       					</td>
       				</tr>
       			</table>
       		</td>
       	</tr>
       	<tr>
       	<td>
       		<table height="100" width="600" border="1">
       			<tr>
       				<td width="80">
       			 		<%=likey_button %>
   			 		</td>
   			 		<td width="120">
   			 			좋아요 x <%=likey_count %>개
		 			</td>
		 			<td width="200"></td>
		 			<td width="100"></td>
	 			</tr>
       			<tr>
	       				<td colspan="3" width="520">
       						<input type="text" placeholder="댓글을 입력해주세요." size="60" id="comment_text"/>
	       				</td>
	       				<td>
	       					<input type="button" value="등록하기" height="100" id="comment_btn"/>
	       				</td>
       			</tr>
       		</table>
       	</td>
       	</tr>
    </table>