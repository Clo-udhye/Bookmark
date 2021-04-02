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
	String filename = to.getFilename();
	String content = to.getContent();
	String book_title = to.getBook_title();
	String comment = to.getComment();
	String hit = to.getHit();
	String boardUserID = to.getUserID();
	String UserID_board = to.getUserID();
	
	// StringBuffer를 통한 board데이터 
	StringBuffer commentHTML = new StringBuffer();
	ArrayList<Board_CommentTO> comment_lists = (ArrayList)request.getAttribute("board_commentTO");
	if(comment_lists.size() == 0){
		commentHTML.append("<tr><td colspan='4'>등록된 댓글이 없습니다. 댓글을 통해 소통해봐요!</td></tr>");
	} else {
		for (Board_CommentTO comment_to : comment_lists){
			String comment_nickname = comment_to.getNickname();
			String comment_content = comment_to.getContent();
			String comment_date_time = comment_to.getDate_time().substring(0,16);
			commentHTML.append("<tr>");
			if(comment_to.getUseq().equals(userSeq)){
				commentHTML.append("<td id='comment_seq' comment_seq_attr = '"+comment_to.getSeq()+"'>" + comment_nickname + "</td>");
				commentHTML.append("<td><div><textarea cols='50' rows='1' required wrap='hard' style='border:0px;' id='comment_text'>"+comment_content+"</textarea></div></td>");
				commentHTML.append("<td id='commennt_date'>"+comment_date_time+"</td>");
				commentHTML.append("<td><input type='button' id='comment_modify' value='수정' class='btn btn-dark btn-sm' style='CURSOR:hand;' title='내용 수정 후, 버튼을 누르면 수정됩니다.' /><input type='button' id='comment_delete' class='btn btn-dark btn-sm' value='삭제'/></td>");
			} else {
				commentHTML.append("<td>" + comment_nickname + "</td>");
				commentHTML.append("<td><div>"+comment_content+"</div></td>");
				commentHTML.append("<td colspan='2'>"+comment_date_time+"</td>");
			}
			commentHTML.append("</tr>");
		}
	}
	// 좋아요 갯수 표시 --> viewpage open에
	int likey_count = (Integer)request.getAttribute("likey_count");

	// BOard의 작성자 id 와 세션의 id가 불일치 일때 -->readonly
	StringBuffer BoardUseq_match = new StringBuffer();
	if(!UserID_board.equals(userID)){
		BoardUseq_match.append("readonly");
	}
	

%>
<link rel="stylesheet" type="text/css" href="./css/flexslider.css">
<script type="text/javascript" src="./js/jquery.flexslider-min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
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
   .line{
   	border-bottom: 1px solid gray;
   }
   #close_btn{
    float: right;
    
   }
   @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap');
   body {
 font-family: 'Noto Serif KR', serif;
  background: #white;
}

#comment_modify, #comment_delete {
	width : 25px;
	font-size : 3px;
	padding : 1px;
}
</style>
<script type="text/javascript">
// flexslider load
$(document).ready(function() {
	$('.flexslider').flexslider({
	    animation: "slide"
	  });
})
// 모달창 x 버튼 누르면 페이지 리로드
$(function (){
	$("#close_btn").click(function() {
		location.reload();
	});
});

//게시글 modify 페이지 --> 이미지 수정 및 책 수정 미포함으로 인해서 --> 일시 중단 by 정예찬
//$(document).ready(function(){
//		    $("#modify").click(function(){
//		    	alert('수정 버튼 클릭');
//		        $('.modal-content').load("./modify.do" + "?seq=" +seq);
//		    });
// });

//제목 및 게시글 수정
$(function() {
   $("#modify").click(function() {
      //alert("수정 버튼 클락");
      let board_title = $("#board_title").val();
      let board_content = $("#board_content").val()
      //console.log(board_title + "\n" + board_content);
      $.ajax({
         url : './board_modify.do',
         type : 'POST',
         data : {
            "value" : "modify",
            "user" : "<%=userSeq %>",
            "bseq" : <%=seq %>,
            "board_title" : board_title,
            "board_content" : board_content
         },
         success : function (data) {
            // ************* 계속 콜백 200 에러뜸 --> invalid xml 로 에러 생성 ***** 왜냐면 제목에 <> 가 있어서 인식오류
            alert("게시글 수정 작업이 완료되었습니다.");
            let board_title1 = $(data).find('title').text();
            let board_content1 = $(data).find('content').text();
            $("#board_title").val(board_title1);
            $("#board_content").html(board_content1);
         },
         error : function (request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         }
      });
   });
});

// 게시글 삭제
$(function() {
	$("#delete").click(function() {
		var delete_confirm = confirm("삭제 하시겠습니까?");
		if(delete_confirm == true){
			$.ajax({
				url : './board_modify.do',
				type : 'POST',
				data : {
					"value" : "delete",
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
						let result = "<tr>";
						result += "<th width='80' class='line'>별명</th><th width='300' class='line'>내용</th><th>일시</th><th class='line' style='padding-left : 5px;'>비고</th>";
						result += "</tr>";
						$(data_xml).find('comment').each(function(){
							result += "<tr>";
							let useq = $(this).find('useq').text();
							let date_time = $(this).find('date_time').text().substring(0,19);
							if (useq === '<%= userSeq%>') {
								result += "<td id='comment_seq' comment_seq_attr = '"+$(this).find('seq').text()+"'>" +$(this).find('nickname').text()+"</td>";
								result += "<td><div><textarea cols='55' rows='1' required wrap='hard' style='border:0px;' id='comment_text'>" +$(this).find('content').text()+"</textarea></div></td>";
								result += "<td>"+date_time+"</td>";
								result += "<td><input type='button' id='comment_modify' class='btn btn-dark btn-sm' value='수정' style='CURSOR:hand;' title='내용 수정 후, 버튼을 누르면 수정됩니다.' /><input type='button' id='comment_delete' class='btn btn-dark btn-sm' value='삭제'/></td>";
							} else {
								result += "<td id='comment_seq' comment_seq_attr = '"+$(this).find('seq').text()+"'>" +$(this).find('nickname').text()+"</td>";
								result += "<td><div>" +$(this).find('content').text()+"</div></td>";
								result += "<td colspan='2'>"+date_time+"</td>";
							}
							result += "</tr>";
						});
						$('#wrapTable').html(result);
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
	$(document).on("click","#comment_modify",function(){
		let comment_text = $("#comment_text").val();
		let comment_seq = $("#comment_seq").attr("comment_seq_attr");
		if(comment_text.length < 5){
			alert('최소 5자 이상 입력이 필요합니다.');
			$('#comment_text').focus();
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
					let result = "<tr>";
					result += "<th width='80' >별명</th><th width='300'>내용</th><th>일시</th><th style='padding-left : 5px;'>비고</th>";
					result += "</tr>";
					$(data_xml).find('comment').each(function(){
						result += "<tr>";
						let useq = $(this).find('useq').text();
						let date_time = $(this).find('date_time').text().substring(0,19);
						if (useq === '<%= userSeq%>') {
							result += "<td id='comment_seq' comment_seq_attr = '"+$(this).find('seq').text()+"'>" +$(this).find('nickname').text()+"</td>";
							result += "<td><div><textarea cols='55' rows='1' required wrap='hard' style='border:0px;' id='comment_text'>" +$(this).find('content').text()+"</textarea></div></td>";
							result += "<td>"+date_time+"</td>";
							result += "<td><input type='button' id='comment_modify' class='btn btn-dark btn-sm' value='수정' style='CURSOR:hand;' title='내용 수정 후, 버튼을 누르면 수정됩니다.' /><input type='button' id='comment_delete' class='btn btn-dark btn-sm' value='삭제'/></td>";
						} else {
							result += "<td id='comment_seq' comment_seq_attr = '"+$(this).find('seq').text()+"'>" +$(this).find('nickname').text()+"</td>";
							result += "<td><div>" +$(this).find('content').text()+"</div></td>";
							result += "<td colspan='2'>"+date_time+"</td>";
						}
						result += "</tr>";
					});
					$('#wrapTable').html(result);
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
	$(document).on("click","#comment_delete",function(){
		let comment_delete_confirm = confirm("댓글을 삭제하시겠습니까?");
		if(comment_delete_confirm == true){
			let comment_text = $("#comment_text").val();
			let comment_seq = $("#comment_seq").attr("comment_seq_attr");
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
					let result = "<tr>";
					result += "<th width='80' >별명</th><th width='300'>내용</th><th>일시</th><th style='padding-left : 5px;'>비고</th>";
					result += "</tr>";
					$(data_xml).find('comment').each(function(){
						result += "<tr>";
						let useq = $(this).find('useq').text();
						let date_time = $(this).find('date_time').text().substring(0,19);
						if (useq === '<%= userSeq%>') {
							result += "<td id='comment_seq' comment_seq_attr = '"+$(this).find('seq').text()+"'>" +$(this).find('nickname').text()+"</td>";
							result += "<td><div><textarea cols='55' rows='1' required wrap='hard' style='border:0px;' id='comment_text'>" +$(this).find('content').text()+"</textarea></div></td>";
							result += "<td>"+date_time+"</td>";
							result += "<td><input type='button' id='comment_modify' value='수정' style='CURSOR:hand;' title='내용 수정 후, 버튼을 누르면 수정됩니다.' /><input type='button' id='comment_delete' value='삭제'/></td>";
						} else {
							result += "<td id='comment_seq' comment_seq_attr = '"+$(this).find('seq').text()+"'>" +$(this).find('nickname').text()+"</td>";
							result += "<td><div>" +$(this).find('content').text()+"</div></td>";
							result += "<td colspan='2'>"+date_time+"</td>";
						}
						result += "</tr>";
					});
					$('#wrapTable').html(result);
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
       		<td rowspan="3" border="1" style="padding-top : 40px;"> 
       			<div class="flexslider" style="width : 500px; height : 500px;">
       				<ul class="slides">
       					<li><img src="./upload/<%=filename %>" style="width : 500px; height : 500px;"/></li>
       					<li><img src="./upload/<%=filename %>" style="width : 500px; height : 500px;"/></li>
       					<li><img src="./upload/<%=filename %>" style="width : 500px; height : 500px;"/></li>
       				</ul>
       			</div>
   			</td>
       		<td >
	       		<table width="620" height="50">
	       			<tr>
	       				<td width="150" class="line">작성자 : <%=nickname %></td>
	       				<td width="180" class="line">작성 일자 : <%= date %></td>
	       				<td width="100" class="line">조회수 : <%=hit %></td>
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
                		<tr class="line"><td  height="10"> <input type="text" value="<%=title%>" id="board_title" size="58 " style="border: none;" <%=BoardUseq_match %>/></td></tr>
                  		<tr height="230">

       					<td>
       						<!-- <div id="vertical1">
       							<div class="wrap"> 
       								<table border="1" height="230" width="580" class="wrapTable"> <tr><td>  -->
       								<textarea cols="63" rows="10" required wrap="hard" id="board_content" style="border:none;" <%=BoardUseq_match %>><%=content %></textarea>
       								<!-- </td></tr></table>
       							</div>
       						</div>  -->
   						</td>
       				</tr>
       				<tr>
       					<td>
       						<div id="vertical2">
       							<div class="wrap">
       								<table height="70" width="580" id="wrapTable">
       								<tr>
       									<th class="line" width="80" >별명</th><th class="line" width="300">내용</th><th class="line" >일시</th><th class="line"  width="70" style="padding-left : 5px;">비고</th>
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
   			 		<td width="120" id="ajax_likey_count">
   			 			좋아요  <%=likey_count %>개
		 			</td>
		 			<td width="200"></td>
		 			<td width="100"></td>
	 			</tr>
       			<tr>
	       				<td colspan="3" width="520">
       						<input type="text" placeholder="댓글을 입력해주세요." size="53" id="comment_text_input"/>
	       				</td>
	       				<td>
<<<<<<< HEAD
	       					<button class="btn btn-sm" value="등록하기" height="100" id="comment_btn"><i class="fas fa-arrow-circle-up"></i></button>
=======
                        <button value="등록하기" height="100" id="comment_btn" class="btn"><i class="fas fa-arrow-circle-up" style="font-size: 20px;"></i></button>
>>>>>>> 155e4d6dac34fddadbe8e9da6c3a243c34ed2805
	       				</td>
       			</tr>
       		</table>
       	</td>
       	</tr>
    </table>
    <!-- 모달창 정보
    <div id="modal" class="modal fade" tabindex="-1" role="dialog">
       <div class="modal-dialog modal-dialog modal-xl modal-dialog-centered">
          <div class="modal-content">
          
          </div>
       </div>
    </div>
     -->
