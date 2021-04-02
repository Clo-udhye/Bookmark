<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.exam.admin.AdminBoardListTO"%>
<%@page import="com.exam.admin.PagingBoardTO"%>
<%@page import="com.exam.admin.AdminUserListTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.admin.PagingUserTO"%>
<%@page import="com.exam.user.UserTO"%>
    
<%
		StringBuffer userHtml = new StringBuffer();
		StringBuffer boardHtml = new StringBuffer();

		UserTO userInfo = null;
    	if(session.getAttribute("userInfo") != null) {
    		userInfo = (UserTO)session.getAttribute("userInfo");
    		if(!userInfo.getId().equals("testadmin1")) {
		    	out.println("<script type='text/javascript'>");
		    	out.println("alert('관리자만 접근할수있습니다.')");
		    	out.println("location.href='./home.do';");
		    	out.println("</script>");
    		} else{
    			// 사용자 관리
    	    	PagingUserTO pUto = (PagingUserTO)request.getAttribute( "pUserList" );
    	    	int upage = pUto.getUpage();
    	    	
    	    	int uTotalRecode = pUto.getTotalrecord();    	
    	    	int uTotalPage = pUto.getTotalPage();

    	    	int uStartBlock = pUto.getStartBlock();
    	    	int uEndBlock = pUto.getEndBlock();
    	    	
    	    	ArrayList<AdminUserListTO> userList = pUto.getUserList();
    			
    	    	// 게시글 관리
    	    	PagingBoardTO pBto = (PagingBoardTO)request.getAttribute( "pBoardList" );
    	    	int bpage = pBto.getBpage();
    	    	
    	    	int bTotalRecode = pBto.getTotalrecord();    	
    	    	int bTotalPage = pBto.getTotalPage();

    	    	int bStartBlock = pBto.getStartBlock();
    	    	int bEndBlock = pBto.getEndBlock();
    	    	
    	    	ArrayList<AdminBoardListTO> boardList = pBto.getBoardList();
    	    	
    	    	//사용자 관리
    	    	//StringBuffer userHtml = new StringBuffer();
    	    	userHtml.append("<table border=1 width=500 class='table table-hover'>");
    	    	userHtml.append("<thead>");
    	    	userHtml.append("<tr>");
    	    	userHtml.append("<td colspan='5'>");
    	    	userHtml.append("총 회원 : " + uTotalRecode +"명");
    	    	userHtml.append("</td>");
    	    	userHtml.append("</tr>");
    	    	userHtml.append("<tr>");
    	    	userHtml.append("<th>#</th><th>아이디</th><th>별명</th><th>게시글수</th><th>&nbsp;</th>");
    	    	userHtml.append("</tr>");
    	    	userHtml.append("</thead>");
    	    	userHtml.append("<tbody>");
    	    	for(AdminUserListTO to: userList){
    	    		userHtml.append("<tr>");
    	    		userHtml.append("<th>"+to.getUseq()+"</th>");
    	    		userHtml.append("<td>"+to.getId()+"</td>");
    	    		userHtml.append("<td>"+to.getNickname()+"</td>");
    	    		userHtml.append("<td>"+to.getBcount()+"</td>");
    	    		userHtml.append("<td>");
    	    		userHtml.append("<input id='"+to.getNickname()+"("+to.getId()+")' useq='"+ to.getUseq() +"' type='button' class='btn btn-outline-dark btn-sm userdel_btn' value='탈퇴' />");
    	    		userHtml.append("</td>");
    	    		userHtml.append("</tr>");
    	    	}
    	    	//마지막페이지 테이블 크기 맞춤 
    	    	for(int i=userList.size(); i<pUto.getRecordPerPage(); i++){
    	    		userHtml.append("<tr height='47.33'>");
    	    		userHtml.append("<td colspan='5'>&nbsp;</td>");
    	    		userHtml.append("</tr>");
    	    	}
    	    	userHtml.append("</tbody>");
    	    	userHtml.append("<tfoot>");
    	       	userHtml.append("<tr>");
    	       	userHtml.append("<td colspan='5'>");
    	    	userHtml.append("<div>");
    	    	userHtml.append("<ul class='pagination'>");
    	    	
    	    	//처음으로
    	    	userHtml.append("<li class='page-item'>");
    	    	if(upage == 1) {
    	    		userHtml.append("<a class='page-link' aria-label='First'>");
    	    	}else{
    	    		userHtml.append("<a class='page-link' href='./admin.do?upage=1&bpage="+bpage+"' aria-label='First'>");
    	    	}
    	    	userHtml.append("<span aria-hidden='true'>&laquo;</span>");
    	    	userHtml.append("</a>");
    	    	userHtml.append("</li>");
    	    	
    	    	//이전 페이지
    	    	userHtml.append("<li class='page-item'>");
    	    	if(upage == 1) {
    	    		userHtml.append("<a class='page-link' aria-label='Previous'>");
    	    	}else{
    	    		userHtml.append("<a class='page-link' href='./admin.do?upage="+(upage-1)+"&bpage="+bpage+"' aria-label='Previous'>");
    	    	}
    	    	userHtml.append("<span aria-hidden='true'>&lt;</span>");
    	    	userHtml.append("</a>");
    	    	userHtml.append("</li>");
    	    	
    	    	// 페이지
    	    	for(int i=uStartBlock; i<=uEndBlock; i++) {
    			
    				if(upage == i) {
    					// 현재 페이지
    					userHtml.append("<li class='page-item active'><a class='page-link' href='./admin.do?upage="+i+"&bpage="+bpage+"'>"+i+"</a></li>");
    				} else {
    					userHtml.append("<li class='page-item'><a class='page-link' href='./admin.do?upage="+i+"&bpage="+bpage+"'>"+i+"</a></li>");
    				}
    			}
    	    	
    	    	//다음 페이지
    	    	userHtml.append("<li class='page-item'>");
    	    	if(upage == uTotalPage) {
    	    		userHtml.append("<a class='page-link' aria-label='Next'>");
    	    	}else{
    	    		userHtml.append("<a class='page-link' href='./admin.do?upage="+(upage+1)+"&bpage="+bpage+"' aria-label='Next'>");
    	    	}
    	    	userHtml.append("<span aria-hidden='true'>&gt;</span>");
    	    	userHtml.append("</a>");
    	    	userHtml.append("</li>");
    	    	
    	    	// 끝페이지
    	    	userHtml.append("<li class='page-item'>");
    	    	if(upage == uTotalPage) {
    	    		userHtml.append("<a class='page-link' aria-label='Last'>");
    	    	}else{
    	    		userHtml.append("<a class='page-link' href='./admin.do?upage="+uTotalPage+"&bpage="+bpage+"' aria-label='Last'>");
    	    	}
    	    	userHtml.append("<span aria-hidden='true'>&raquo;</span>");
    	    	userHtml.append("</a>");
    	    	userHtml.append("</li>");
    	    	
    	    	userHtml.append("</ul>");
    	    	userHtml.append("</div>");
    	    	userHtml.append("</td>");
    	    	userHtml.append("</tr>");
    	    	userHtml.append("</tfoot>");
    	    	userHtml.append("</table>");
    	    	
    	    	
    	    	// 게시글 관리
    	    	//StringBuffer boardHtml = new StringBuffer();
    	    	boardHtml.append("<table border=1 width=900 class='table table-hover'>");
    	    	boardHtml.append("<thead>");
    	 
    	    	boardHtml.append("<tr>");
    	    	boardHtml.append("<td colspan=7>");
    	    	boardHtml.append("총 게시글 : " + bTotalRecode +"개");
    	    	boardHtml.append("</td>");
    	    	boardHtml.append("</tr>");
    	    	
    	    	boardHtml.append("<tr>");
    	    	boardHtml.append("<th>#</th><th>제목</th><th>작성자</th><th>조회수</th><th>댓글</th><th>좋아요</th><th>&nbsp;</th>");
    	    	boardHtml.append("</tr>");
    	    	boardHtml.append("</thead>");
    	    	boardHtml.append("<tbody>");
    	    	for(AdminBoardListTO to: boardList){
    	    		boardHtml.append("<tr id='' bseq='"+to.getBseq()+"' class='board_list' data-bs-toggle='modal' data-bs-target='#view-modal'>");
    	    		boardHtml.append("<th>"+to.getBseq()+"</th>");
    	    		boardHtml.append("<td>"+to.getTitle()+"</td>");
    	    		boardHtml.append("<td>"+to.getNickname()+"("+to.getId()+")</td>");
    	    		boardHtml.append("<td>"+to.getHit()+"</td>");
    	    		boardHtml.append("<td>"+to.getComment()+"</td>");
    	    		boardHtml.append("<td>"+to.getLikey()+"</td>");
    	    		boardHtml.append("<td>");
    	    		boardHtml.append("<input id='' bseq='"+to.getBseq()+"' type='button' class='btn btn-outline-dark btn-sm boarddel_btn' value='게시글삭제' />");
    	    		boardHtml.append("</td>");
    	    		boardHtml.append("</tr>");
    	    	}
    	    	//마지막페이지 테이블 크기 맞춤 
    	    	for(int i=boardList.size(); i<pBto.getRecordPerPage(); i++){
    	    		boardHtml.append("<tr height='47.33'>");
    	    		boardHtml.append("<td colspan='7'>&nbsp;</td>");
    	    		boardHtml.append("</tr>");
    	    	}
    	    	boardHtml.append("</tbody>");
    	    	boardHtml.append("<tfoot>");
    	    	boardHtml.append("<tr>");
    	    	boardHtml.append("<td colspan='7'>");
    	    	boardHtml.append("<div>");
    	    	boardHtml.append("<ul class='pagination'>");
    	    	//처음으로
    	    	boardHtml.append("<li class='page-item'>");
    	    	if(bpage == 1) {
    	    		boardHtml.append("<a class='page-link' aria-label='First'>");
    	    	}else{
    	    		boardHtml.append("<a class='page-link' href='./admin.do?upage="+upage+"&bpage=1' aria-label='First'>");
    	    	}
    	    	boardHtml.append("<span aria-hidden='true'>&laquo;</span>");
    	    	boardHtml.append("</a>");
    	    	boardHtml.append("</li>");
    	    	
    	    	//이전 페이지
    	    	boardHtml.append("<li class='page-item'>");
    	    	if(bpage == 1) {
    	    		boardHtml.append("<a class='page-link' aria-label='Previous'>");
    	    	}else{
    	    		boardHtml.append("<a class='page-link' href='./admin.do?upage="+upage+"&bpage="+(bpage-1)+"' aria-label='Previous'>");
    	    	}
    	    	boardHtml.append("<span aria-hidden='true'>&lt;</span>");
    	    	boardHtml.append("</a>");
    	    	boardHtml.append("</li>");
    	    	
    	    	// 페이지
    	    	for(int i=bStartBlock; i<=bEndBlock; i++) {
    			
    				if(bpage == i) {
    					// 현재 페이지
    					boardHtml.append("<li class='page-item active'><a class='page-link' href='./admin.do?upage="+upage+"&bpage="+i+"'>"+i+"</a></li>");
    				} else {
    					boardHtml.append("<li class='page-item'><a class='page-link' href='./admin.do?upage="+upage+"&bpage="+i+"'>"+i+"</a></li>");
    				}
    			}
    	    	
    	    	//다음 페이지
    	    	boardHtml.append("<li class='page-item'>");
    	    	if(bpage == bTotalPage) {
    	    		boardHtml.append("<a class='page-link' aria-label='Next'>");
    	    	}else{
    	    		boardHtml.append("<a class='page-link' href='./admin.do?upage="+upage+"&bpage="+(bpage+1)+"' aria-label='Next'>");
    	    	}
    	    	boardHtml.append("<span aria-hidden='true'>&gt;</span>");
    	    	boardHtml.append("</a>");
    	    	boardHtml.append("</li>");
    	    	
    	    	// 끝페이지
    	    	boardHtml.append("<li class='page-item'>");
    	    	if(bpage == bTotalPage) {
    	    		boardHtml.append("<a class='page-link' aria-label='Last'>");
    	    	}else{
    	    		boardHtml.append("<a class='page-link' href='./admin.do?upage="+upage+"&bpage="+bTotalPage+"' aria-label='Last'>");
    	    	}
    	    	boardHtml.append("<span aria-hidden='true'>&raquo;</span>");
    	    	boardHtml.append("</a>");
    	    	boardHtml.append("</li>");
    	    	boardHtml.append("</ul>");
    	    	boardHtml.append("</div>");
    	    	boardHtml.append("</td>");
    	    	boardHtml.append("</tr>");
    	    	boardHtml.append("</tfoot>");
    	    	boardHtml.append("</table>");
    		}
    	} else {
    		out.println("<script type='text/javascript'>");
    		out.println("alert('로그인해주세요.')");
    		out.println("location.href='./login.do'");
    		out.println("</script>");
    	}
    
    %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책갈피</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>

<!-- 글쓰기 Summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$('.userdel_btn').click(function(e){
			//alert($(this).attr('id'));
			let result = confirm($(this).attr('id')+' 을/를 탈퇴하시겠습니까?')
			if(result){
				//탈퇴
				location.href='./user_delete_ok.do?useq='+$(this).attr('useq');
			}
		});
		
		$('.boarddel_btn').click(function(e){
			let result = confirm($(this).attr('bseq')+'번 게시글을 삭제하시겠습니까?')
			if(result){
				//게시글 삭제
				location.href='./board_delete_ok.do?bseq='+$(this).attr('bseq');
			}
		});
		
		$('.board_list').click(function(e){
			//alert($(this).attr('bseq')+"클릭");
			//console.log("./view.do?seq=" + $(this).attr('bseq'));
			$('.view-content').load("./view.do?seq=" + $(this).attr('bseq'));
		});
		
		$('#write_notice').click(function(e){
			alert('공지사항 쓰기');
			//공지사항 쓰기 기능
		});
		
		$("#write_button").on('click', function(){
			<%if(userInfo!=null){%>
				$("#write-modal").modal("show");
				$('.write-content').load("./write.do");
			<%}else{%>
				var comfirm_login = confirm("로그인이 필요한 서비스입니다. \n'확인'버튼을 클릭 시, 로그인 창으로 이동합니다.");
				if(comfirm_login==true){
					location.href="./login.do";
				}
			<%}%>	        	
	    });
		
		$('#view-modal').on('hidden.bs.modal', function(){
			location.reload();
		});
	});
</script>
<style>
.button1{
	float: right;
	margin-right:50px;
	width: 30px;
	font-size: 20px;

}
.button2{
	float: right;
	margin-right: 50px;
	width: 30px;
	font-size: 20px;
}
.button3{
	align: right;
	width: 30px;
	font-size: 20px;
}

</style>
</head>
<body>

<div id="mySidebar" class="sidebar">
	<div class="sidebar-header">
		<h3>당신의 책갈피</h3>
	</div>

	<%if (userInfo != null) {%>
		<p><%=userInfo.getNickname()%>님이 로그인 중 입니다.</p>
	<%} else {%>
		<p>로그인해주세요.</p>
	<%}%>
	<a href="./home.do">Home</a>
		<%if(userInfo != null){
		if(userInfo.getId().equals("testadmin1")) {%>
			<a href="./admin.do">Admin Page</a>
		<%} else{ %>
			<a href="./mypage.do?useq=<%=userInfo.getSeq()%>" >My Page</a>
		<%}
	}%>
	<a href="./list.do">모든 게시글 보기</a>
	<a href="./book_list.do">책 구경하기</a>
	
	<div style="padding:8px; position:absolute; bottom:2%; width:100%">
		<button style="width:100%" id="write_button" type="button" class="btn btn-outline-light">글쓰기</button>
	</div>
</div>

<div id="main">
	<div id="header">
		<div>
			<table>
				<tr>
					<td width=5%><span>
						<button class="sidebar-btn" onclick="sidebarCollapse()">
							<span><i class="fa fa-bars" aria-hidden="true"></i></span>
			             </button>
					</span>
					</td>
					<td width=5%><span><a class="navbar-brand" href="./home.do"> <img src="./images/logo.png" alt="logo" style="width: 200px; height:50px; "></a></span></td>
					<% if(userInfo == null){ %>
						<td width=75% ><span><a class="button1" href="./login.do" id="start-button" style="color: black;">START</a></span></td>
	        		<% }else{ %>
	        			<td width=75% ><span><a class="button2" href="./logout_ok.do" id="logout-button" style="color: black;">LOGOUT</a></span></td>
	        		<% } %>
					<td width=5%><span><a class="button3" href="./search.do" style="color: black;"><i class="fa fa-search" aria-hidden="true"></i></a></span></td>
				</tr>
			</table>		
    	</div>
    </div>
    
    <div id="content" style="padding: 100px;" align= "center" >
        <table>
        	<tr>
        		<td>
        			<div id="user-list">
						<%=userHtml %>
					</div>
        		</td>
        		<td>
        			<div id="board-list">
						<%=boardHtml %>
					</div>
        		</td>
        	</tr>
        </table>
    </div>
</div>

<!-- 모달창 정보 -->
<div id="view-modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content view-content">                   
		</div>
	</div>
</div>
             
<div id="write-modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content write-content">
	    </div>
	</div>
</div>
</body>
</html>