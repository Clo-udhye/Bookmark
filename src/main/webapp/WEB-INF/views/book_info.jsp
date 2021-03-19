<%@page import="com.exam.booklist.BookRelatedTO"%>
<%@page import="com.exam.booklist.BookTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	BookTO to = (BookTO)request.getAttribute("book_info");
	String master_seq = to.getMaster_seq();
	String isbn13 = to.getIsbn13();
	String title = to.getTitle();
	String author = to.getAuthor();
	String publisher = to.getPublisher();
	String img_url = to.getImg_url();
	String description = to.getDescription();
	String pub_date = to.getPub_date();
	
	int cpage = (int)request.getAttribute("cpage");
	// cpage는 받아오지만 뒤롸기 버튼 클릭 시 --> 해당 cpage를 받아가진 모못함
	
	StringBuffer board_related = new StringBuffer();
	
	ArrayList<BookRelatedTO> lists = (ArrayList)request.getAttribute("relatedBoard");
	if (lists.size() != 0 ){
		for (BookRelatedTO bookRelatedTO : lists){
			String board_title = bookRelatedTO.getBoard_title();
			String board_date = bookRelatedTO.getBoard_date().substring(0, 10);
			
			String user_nickname = bookRelatedTO.getUser_nickname();
			
			board_related.append("<tr>");
			board_related.append("<td>"+board_title+"</td>");
			board_related.append("<td>"+board_date+"</td>");
			board_related.append("<td>"+user_nickname+"</td>");
			board_related.append("</tr>");
		}
	} else {
		board_related.append("<tr>");
		board_related.append("<td colspan='3'> 관련 게시글이 없습니다.</td>");
		board_related.append("</tr>");
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
<style>
	#table {
		border: 1px solid black;
		width : 70%;
		height : 50%;
		align : center;
	}
	#img {
		padding : 10px;
		align : center;
		width : 400px;
	}
	.vertical {
		width: max-content;
		overflow-y: scroll;
		height : 200px;
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
	.wrapTable tr:hover {
		background-color : ivory;
		font-color : black; 
	}
	

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>
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
    <table id="table">
    	<tr>
    		<td colspan="3" align="right"><div ><input type="button" onclick="history.back()" value="뒤로 가기"></div></td>
   		</tr>
   		<tr>
   			<td rowspan="6"><img src="<%=img_url %>" alt="이미지 없음" id = "img"/></td>
   			<td><div>책 제목 : <%=title %></div></td>
   		</tr>
   		<tr>
   			<td><div>저자 : <%=author %></div></td>
   		</tr>
   		<tr>
   			<td><div>출판사 : <%=publisher %></div></td>
   		</tr>
   		<tr>
   			<td><div>출판일 : <%=pub_date %></div></td>
   		</tr>
   		<tr>
   			<td><p>책 설명 : <%=description %></td>
   		</tr>
   		<tr>
   			<td>
   				<div>
   					<div><h4>관련 게시글</h4></div>
   					<div class="vertical">
   						<div class="wrap">
					    	<table border=1 width="1000" class="wrapTable" >
					    		<tr>
						    		<th>게시글 제목</th>
						    		<th>작성 일자</th>
						    		<th>작성자</th>    		
					    		</tr>
					    		<%= board_related%>
					    	</table>
				    	</div>
			    	</div>
   				</div>
   			</td>
   		</tr>
        
        	
        </table>
    </div>
    <div>
    	
    </div>
</div>

</body>
</html>