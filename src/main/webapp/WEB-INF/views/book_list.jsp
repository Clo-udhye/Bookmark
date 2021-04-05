<%@page import="com.exam.user.UserTO"%>
<%@page import="com.exam.paging.pagingTO"%>
<%@page import="com.exam.booklist.BookTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    //************************************* To do --> 검색 페이지-Paging을 넘어가면 검색 결과가 유지가 안됨 **********************

 	// 현재 세션 상태를 체크한다
 	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	}
	//ArrayList<BookTO> booklists = (ArrayList)request.getAttribute("booklist");
    pagingTO pagelistTO = (pagingTO)request.getAttribute("paginglist");
    ArrayList<BookTO> booklists = pagelistTO.getBookList();
    int cpage = 1;
    if(pagelistTO.getCpage()!= 0){
    	cpage = pagelistTO.getCpage();
    }
    String bookname = "";
    StringBuffer SearchResult = new StringBuffer();
    if (request.getAttribute("bookname") != null){
    	bookname = (String)request.getAttribute("bookname");
    	SearchResult.append("<div ><h1><span id='result'>"+bookname+"</span> 으로 검색한 결과</h1></div>");
    } else {
    	SearchResult.append("<div><h1 style='padding-left: 50px;'>도서 리스트</h1></div>");
    }
    String search = request.getParameter("search");
	int totalRecord = pagelistTO.getTotalrecord();
	int recordPerPage= pagelistTO.getRecordPerPage();
	int totalPage = pagelistTO.getTotalPage();
	int blockPerPage = pagelistTO.getBlockPerPage();
	int startBlock = pagelistTO.getStartBlock();
	int endBlock = pagelistTO.getEndBlock();
	
	StringBuffer bookHTML = new StringBuffer();
	
	for (BookTO to : booklists){
		//변수 담아 오기
		String master_seq = to.getMaster_seq();
		String isbn13 = to.getIsbn13();
		String title= to.getTitle();
		String author = to.getAuthor();
		String publisher = "";
		if (to.getPublisher().equals("")){
			publisher = "미등록";
		} else {
			publisher = to.getPublisher();
		}
		String img_url = to.getImg_url();
		String description = "";
		if (to.getDescription().equals("")){
			description = "내용 없음";
		} else {
			description = to.getDescription() + "...";
		}
		String pub_date = to.getPub_date();
			// 아래의 HTMl 양식으로 append하기
			bookHTML.append("<div>");
			bookHTML.append("<table id=innerlist align='center'>");
			bookHTML.append("<tr>");
			bookHTML.append("<td rowspan='4' width='20%'><img width='200px' src='"+img_url+"' alt='이미지 없음' border='1px'/></td>");
			bookHTML.append("<td width=60% style='padding-top: 20px;'>책 제목 :"+title+"</td>");
			bookHTML.append("<td rowspan='4' width=40 align='center'>");
			bookHTML.append("<a type='button' href='./book_info.do?master_seq="+master_seq+"' id='simple_button' class='btn btn-dark' ' >자세히 보기</a>");
			bookHTML.append("</td>");
			bookHTML.append("</tr>");
			bookHTML.append("<tr><td><div>저자 :"+author+"</div></td></tr>");
			bookHTML.append("<tr><td><div>출판사 :"+publisher+"</div></td></tr>");
			bookHTML.append("<tr><td><p>책 설명 :"+description+"</p></td></tr>");
			bookHTML.append("</table>");
			bookHTML.append("</div>");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책갈피</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR&family=Quicksand:wght@500&display=swap');

.button1{
	float: right;
	margin-right: 0px;
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
	float: right;
	width: 30px;
	font-size: 20px;
}
#resist-books{
	font-family: 'Noto Serif KR', serif;
	font-family: 'Quicksand', sans-serif;
	padding-left: 50px;
}
#list {
  border: 1px solid black;
  padding: 15px;
  width:100%;
}
#innerlist {
  border: 1px solid black;
  padding: 15px;
  width:80%;
 
}
#logo{
	size: 24px;
}
table {
  border-spacing: 15px;
  padding : "10";
  table-layout: auto;
  
}

#simple_button{
	text-align: center;
	height:auto;
	padding-right: 10px;
	width: 120px;
}
#result {
	 font-style: italic;
	 color:blue;
}
.text1{
	font-color: white;
}
#end-page, #before-page, #next-page{
	color: black;
}
.opener { display:none; }
.opener:checked ~ .nav_item { display:block; }
</style>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!--  <style> #content {position: absolute; left: 50%; transform: translateX(-50%);}</style> -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>
</head>
<body>

<div id="mySidebar" class="sidebar">
	<div class="sidebar-header">
		<a><h3>당신의 책갈피</h3></a>
	</div>

	<%if (userInfo != null) {%>
		<div class="sidebar-userprofile">
			<div class="sidebar-user_img" align="center" style="padding-top: 10px; padding-bottom: 10px;">
				<img src="./profile/<%=userInfo.getProfile_filename() %>" border="0" width=80px height=80px style="border-radius: 50%;"/>
			</div>
			<div  align="center" style="color:gray; font-size:18px;"><%=userInfo.getNickname()%>님이</div>
			<div  align="center" style="color:gray; font-size:18px;">로그인 중 입니다.</div>
			<br/>
		</div>
	<%} else {%>
		<p>로그인해주세요.</p>
	<%}%>
	<a href="./home.do">Home</a>
		<%if(userInfo != null){
		if(userInfo.getId().equals("testadmin1")) {%>
			<a href="./admin.do">Admin Page</a>
		<%} else{ %>
			<a href="./mypage.do">My Page</a>
		<%}
	}%>
	<a href="./list.do">모든 게시글 보기</a>
	<a href="./book_list.do">책 구경하기</a>
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
    
    <div id="content" width=100% > 
        <%=SearchResult %>
        <div width=100% >
        	<table>
        	
        	<tr><td width = 80% height="40" id="resist-books" > 현재 <%= totalRecord %>개의 책이 등록되어 있습니다.</td></tr>
        		<tr>
        			<td height="50" width="200" ></td>
        			<td>
        				<table width="550">
        				<form action="./book_list_search.do" type="get" align="left">
        				<tr>
	        				<td  width="120">
	        					<select name="search" style="border-radius: 4px">
								    <option value="제목" selected="selected">제목 검색</option>
								    <option value="작가">작가 명 검색</option>
								</select>
							</td>
        					<td>
        						<input type="text" name = "bookname" width=120 style="border-radius: 4px"/>
       						</td>
        					<td width="213" align="left">
        						<button type="submit" value="검색" width="70" class="btn btn-dark" >검색</button>
        						
        						
       						</td>
        				</tr>
        				</form>
        				</table>
        			</td>
        		</tr>
        	</table>
        </div>
     </div>
     <div>
   		<%= bookHTML %>
     </div>
     <br><br>
     <footer>
     <div align="center">
     <%
     if(request.getAttribute("bookname") == null){
	     	if (startBlock== 1){
				out.println("<span><a style='color:black'>처음</a></span>");
			} else {
				out.println("<span><a href='./book_list.do?cpage=1' style='color:black'>처음</a></span>");
			}
			
			out.println("&nbsp;");
			
			if(cpage == 1){
				out.println("<span><a href=''><i class='fa fa-arrow-left' aria-hidden='true' style='color:black'></i></a></span>");
			} else{
				out.println("<span><a href='./book_list.do?cpage="+(cpage-1)+"'><i class='fa fa-arrow-left' aria-hidden='true' style='color:black'></i></a></span>");
			}
			
			out.println("&nbsp;&nbsp;");
	     	
	     	for(int i=startBlock; i<=endBlock; i++){
	     		if(cpage == i){
	     			out.println("<span>["+i+"]</span>");
	     		} else {
	     			out.println("<span><a href ='./book_list.do?cpage="+i+"' style='color:black'>"+i+"</a></span>");
	     		}
	     	}
	     	
	     	out.println("&nbsp;");
				if(cpage == totalPage){
					out.println("<span><a href=''><i class='fa fa-arrow-right' aria-hidden='true' color='black;'></i></a></span>");
				} else{
					out.println("<span><a href='./book_list.do?cpage="+(cpage+1)+"' ><i class='fa fa-arrow-right' aria-hidden='true' style='color:black'></i></a></span>");
				}
	     	
			out.println("&nbsp;");
				if (endBlock== totalPage){
					out.println("<span><a> 끝</a></span>");
				} else {
					out.println("<span><a href='./book_list.do?cpage="+totalPage+"'style='color:black'> 끝</a></span>");
				}
			
     } else {
    	 if (startBlock== 1){
				out.println("<span><a>처음</a></span>");
			} else {
				out.println("<span><a href='./book_list_search.do?search="+search+"&bookname="+bookname+"&cpage=1'>처음</a></span>");
			}
			
			out.println("&nbsp;");
			
			if(cpage == 1){
				out.println("<span><a href=''><i class='fa fa-arrow-left' aria-hidden='true' color='black'></i></a></span>");
			} else{
				out.println("<span><a href='./book_list_search.do?search="+search+"&bookname="+bookname+"&cpage="+(cpage-1)+"'><i class='fa fa-arrow-left' aria-hidden='true' style='color:black'></i></a></span>");
			}
			
			out.println("&nbsp;&nbsp;");
	     	
	     	for(int i=startBlock; i<=endBlock; i++){
	     		if(cpage == i){
	     			out.println("<span>["+i+"]</span>");
	     		} else {
	     			out.println("<span><a href ='./book_list_search.do?search="+search+"&bookname="+bookname+"&cpage="+i+"'>"+i+"</a></span>");
	     		}
	     	}
	     	
	     	out.println("&nbsp;");
     		if(cpage == totalPage){
				out.println("<span><a href=''><i class='fa fa-arrow-right' aria-hidden='true' color='black;'></i></a></span>");
			} else{
				out.println("<span><a href='./book_list_search.do?search="+search+"&bookname="+bookname+"&cpage="+(cpage+1)+"' ><i class='fa fa-arrow-right' aria-hidden='true' color='black;'></i></a></span>");
			}
			
			out.println("&nbsp;");
				if (endBlock== totalPage){
					out.println("<span><a> 끝</a></span>");
				} else {
					out.println("<span><a href='./book_list_search.do?search="+search+"&bookname="+bookname+"&cpage="+totalPage+"'> 끝</a></span>");
				}
     }    	
     %>
     </div>
     </footer>
     <br><br>
</div>

</body>
</html>