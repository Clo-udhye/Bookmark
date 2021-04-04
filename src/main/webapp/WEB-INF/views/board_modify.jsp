<%@page import="com.exam.theseMonthBoard.Home_BoardTO"%>
<%@page import="com.exam.user.UserTO"%>
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
	String UserID_board = to.getUserID();
	String board_profile = to.getProfile();
	
	int len_title = title.length(); 
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
<script type="text/javascript">
$(document).ready(function(){
	$(".flexslider").flexslider({
		animation: "slide",	
		slideshow: false,
		disableDragAndDrop: true,
	});
	
	$('#summernote').summernote({
		placeholder: '게시글 입력...',
		dialogsInBody: true,
		width: 630,
		height: 320,
		disableResizeEditor: true,
		toolbar: [
		    // [groupName, [list of button]]
		    ['style', ['bold', 'italic', 'underline']],
		    ['fontsize', ['fontsize']],
		    ['color', ['color']]
		  ]
	});
	$('.note-statusbar').hide();
	
	//저장버튼 클릭
    $(document).on('click', '#complete_btn', function () {
        if($('#title').val()==''){
        	alert('제목을 입력해주세요.');
        	$('#title').focus();
        	return false;
        }
        if($('#summernote').val()==''){
        	alert('내용을 입력해주세요.');
        	$('#summernote').focus();
        	return false;
        }
        if($('#summernote').val().length>10000){
        	alert('10000자 이하로 입력하세요.');
        	$('#summernote').focus();
        	return false;
        }
      	
        //document.mfrm.submit();
        $.ajax({
            url : './modify_ok.do',
            type : 'post',
            dataType: 'xml',
            data : {
               'board_title': $('#title').val(),
               'board_content': $('#summernote').val(),
               'useq' : $('#useq').val(),
               'bseq': $('#boardseq').val()
            },
            success : function(xmlData){	            	
            	//alert('flag : ' + $(xmlData).find("flag").text());
            	if($(xmlData).find("flag").text()==1){
            		alert('게시글이 수정되었습니다.');
            		$('.view-content').load("./view.do?seq="+<%=seq%>);
            	}else{
            		alert('게시글 수정에 실패했습니다.');
            	}
			},
			error : function(request,status, error) {
				alert("[에러] : code "+ request.status);
				//alert("code:"+request.status+"\n"+"error:"+error);
			}
		});	
    });
	
	$('#title').keyup(function(){
		//제목 글자수 세기
        $('#counter-title').html('('+$(this).val().length+'/100)');
	});	
	
	$('#close-btn').on('click', function(){
		var confirm_result = confirm('저장하지않고 게시글로 돌아갈까요?');	
		if(confirm_result){
			$('.view-content').load("./view.do?seq="+<%=seq%>);
		}
	});
});
</script>

<div class="modal-header">
	<h4 class="modal-title">게시물 수정</h4>
	<button type="button" class="btn d-inline-block" id="close-btn" style="padding:6px 12px 6px 3px; color:#dcdcdc;"><i class="fas fa-times"></i></button>
</div>
<form action="./modify_ok.do" name="mfrm" method="post">
<input type="hidden" id="useq" name="useq" value="<%=userSeq %>">
<input type="hidden" id="boardseq" name="boardseq" value="<%=seq %>">
<div class="modal-body" style="padding:0;">
	<table>
		<tr>
			<td>
				<div id="img_preview" class="flexslider">
        			<ul class="slides">
        				<li><img src="./upload/<%=filename %>" style="width : 500px; height : 500px;"/></li>
                        <li><img src="./upload/<%=filename %>" style="width : 500px; height : 500px;"/></li>
                        <li><img src="./upload/<%=filename %>" style="width : 500px; height : 500px;"/></li>
        			</ul>
        		</div>
			</td>
			<td>
				<table width=100%>
					<tr class="writerInfo button-bar" style="border-bottom:1px solid #d2d2d2;">
						<td>
							<img class="profile_img" src="./profile/<%=board_profile %>">
							<span class="nickname"><%=nickname %></span>
							<span class="userID">(<%=UserID_board %>)</span>
							<span>
								&nbsp;&nbsp;
								<span class="date"style="color:#d2d2d2;">작성일자 : <%= date %></span>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</span>
						</td>
					</tr>
					<tr class="bookInfo">
						<td>
							<span style="float:right; padding:2px 10px">
								<i class="fas fa-book-open"></i>&nbsp;<%=book_title %>
							</span>
						</td>
					</tr>	
					<tr class="boardInfo">
						<td>
							<table>
								<tr>
									<td>
										<div class="col-lg-10 d-inline-block">
											<input class="form-control" type="text" placeholder="제목을 입력해주세요." id="title" name="title" maxlength="100" size="5" value="<%=title%>"/>
										</div>
										<div class="d-inline">	
											<span id="counter-title">(<%=len_title %>/100)</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>
			 							<textarea id="summernote" name="summernote"><%=content %></textarea>
									</td>
								</tr>
							</table>
						</td>
					</tr>								
				</table>
			</td>
		</tr>
	</table>
</div>
<div class="modal-footer">
	<input type="button" value="수정" id="complete_btn" class="btn btn-default" />
</div>
</form>
