<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.exam.boardlist.BoardTO" %>
<%@ page import="com.exam.boardlist.BoardPagingTO" %>
<%@ page import="java.util.ArrayList" %>

<%

	request.setCharacterEncoding("utf-8");

	//ArrayList<BoardTO> lists = (ArrayList)request.getAttribute( "lists" );
	BoardPagingTO pagingTO = (BoardPagingTO)request.getAttribute( "pagingTO" );
	
	StringBuffer sbHtml = new StringBuffer();
	for( BoardTO to : pagingTO.getBoardLists() ) {
		String seq = to.getSeq();
		String date = to.getDate();
		String title = to.getTitle();
		String useq = to.getUseq();
		String filename = to.getFilename();
		String filesize = to.getFilesize();
		String content = to.getContent();
		String bseq = to.getBseq();
		String hit = to.getHit();
		String comment = to.getComment();
		
		
		sbHtml.append("<tr>");
		sbHtml.append("<td width='20%' class='last2'>");
		sbHtml.append("	<div class='board'>");
		sbHtml.append("		<table class='boardT'>");
		sbHtml.append("		<tr>");
		sbHtml.append("			<td class='boardThumbWrap'>");
		sbHtml.append("				<div class='boardThumb'>");
		
		
		sbHtml.append("					<a href='board_view.jsp'><img src='./upload/"+filename+"' border='0' width='100%' /></a>");
		
		//sbHtml.append("						<div class='transbox'>");
	  	//sbHtml.append("							<p>"+title+"</p>");
	  	//sbHtml.append("						</div>");
		
	  	sbHtml.append("				</div>");
		sbHtml.append("			</td>");
		sbHtml.append("		</tr>");
		sbHtml.append("		</table>");
		sbHtml.append("	</div>");
		sbHtml.append("</td>");
		sbHtml.append("</tr>");
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

<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>

<!-- ■■ 내가 추가한 부분 ■■ -->
<style type="text/css">
	
	.boardThumb img:hover {opacity:0.5;}
	.board_pagetab { text-align: center; } 
	.board_pagetab a { text-decoration: none; font: 15px verdana; color: #000; padding: 0 3px 0 3px; }
	.board_pagetab a:hover { text-decoration: underline; background-color:#f2f2f2; }
</style>
<!--
이미지(테이블) 가운데 위치하게 하고 싶음.. ◆◆
이미지 마우스 갖다대면 불투명
페이지탭 가운데 위치
페이지탭 ... 글자색 검은색
페이지탭 마우스 갖다대면 밑줄 & 회색 배경

-->
<!-- ■■ /내가 추가한 부분 ■■ -->

</head>
<body>

<div id="mySidebar" class="sidebar">
	<div class="sidebar-header">
		<h3>당신의 책갈피</h3>
	</div>

	<p>User1님이 로그인 중 입니다.</p>
	<a href="./home.do">Home</a>
	<a href="./mypage.do">My Page</a>
	<a href="./list.do">모든 게시글 보기</a>
	<a href="./book_list.do">책 구경하기</a>
</div>

<div id="main">
	<div id="header">
		<p>
			<span>
				<button class="sidebar-btn" onclick="sidebarCollapse()">
					<span><i class="fa fa-bars" aria-hidden="true"></i></span>
	             </button>
			</span>
	        <span><a class="navbar-brand" href="./home.do"> <img src="./images/logo.png" alt="logo" style="width: 100px;"></a></span>
	        <span><a href="./login.do">시작하기</a></span>
			<span><a href="./search.do"><i class="fa fa-search" aria-hidden="true"></i></a></span>		
    	</p>
    </div>
    
    <div id="content">
        <h1>게시글 리스트</h1>
        
        <!-- ■■ 내가 추가한 부분 ■■ -->
        <!-- 게시판 -->
	    <table class="board_list">
			<tr>
				<%= sbHtml %>
			</tr>
		</table>
		<!--//게시판-->
	
        <!--페이지넘버-->
		<div class="paginate_regular">
			<div class="board_pagetab">
				<span class="off"><a href="#">&lt;처음&gt;</a>&nbsp;</span>
				<span class="off"><a href="#">&lt;이전&gt;</a>&nbsp;</span>
				<span class="on"><a href="#">( 1 )</a></span>
				<span class="off"><a href="#"> 2 </a></span>
				<span class="off"><a href="#"> 3 </a></span>
				<span class="off"><a href="#"> 4 </a></span>
				<span class="off"><a href="#"> 5 </a></span>
				<span class="off">&nbsp;<a href="#">&lt;다음&gt;</a></span>
				<span class="off">&nbsp;<a href="#">&lt;끝&gt;</a></span>
			</div>
		</div>
		<!--//페이지넘버-->
		<!-- ■■ /내가 추가한 부분 ■■ -->
    </div>
</div>

</body>
</html>