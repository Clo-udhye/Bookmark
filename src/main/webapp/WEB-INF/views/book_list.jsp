<%@page import="com.exam.paging.pagingTO"%>
<%@page import="com.exam.booklist.BookTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
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
    	SearchResult.append("<div><h1>도서 리스트</h1></div>");
    }
    
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
			bookHTML.append("<td rowspan='4' width='20%'><img width='200px' src='"+img_url+"' alt='이미지 없음'/></td>");
			bookHTML.append("<td width=60% >책 제목 :"+title+"</td>");
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
table {
  border-spacing: 15px;
  padding : "10";
  
}
.button1{
	width: 30px;
	font-size: 25px;

}
#simple_button{
	text-align: center;
	position: right;
	width: 120px;
}
#result {
	 font-style: italic;
	 color:blue;
}
.text1{
	font-color: white;
}
.opener { display:none; }
.opener:checked ~ .nav_item { display:block; }
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

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
		<table>
		<tr>
			<td width=5%><span>
				<button class="sidebar-btn" onclick="sidebarCollapse()">
					<span><i class="fa fa-bars" aria-hidden="true"></i></span>
	             </button>
			</span>
			</td>
	        <td width=5%><span><a class="navbar-brand" href="./home.do" > <img src="./images/logo.png" alt="logo" style="width: 100px;"></a></span></td>
	       
		   <td width=85% align="right"><span><a class="button1" href="./login.do" style="color: black; " >start</a></span></td>
		   <td width=5%><span><a href="./search.do" style="color: black;"><i class="fa fa-search fa-lg" aria-hidden="true"></i></a></span></td>
			
		</tr>
		</table>		
    	</p>
    </div>
    
    <div id="content" width=100% > 
        <%=SearchResult %>
        <div width=100% >
        	<table>
        	
        	<tr><td width = 80% height="40" > 현재 <%= totalRecord %>개의 책이 등록되어 있습니다.</td></tr>
        		<tr>
        			<td height="50" width="300" ></td>
        			<td>
        				<table width="550">
        				<form action="./book_list_search.do" type="get" align="left">
        				<tr>
	        				<td  width="50">
	        					<select name="search" style="border-radius: 4px">
								    <option value="제목" selected="selected">제목 검색</option>
								    <option value="작가">작가 명 검색</option>
								</select>
							</td>
        					<td>
        						<input type="text" name = "bookname" width=50 style="border-radius: 4px"/>
       						</td>
        					<td width="213" align="left">
        						<button type="submit" value="검색" width="50" class="btn btn-dark">검색</button>
        						
        						
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
     
     	if (startBlock== 1){
			out.println("<span><a>처음</a></span>");
		} else {
			out.println("<span><a href='./book_list.do?cpage=1'>처음</a></span>");
		}
		
		out.println("&nbsp;");
		
		if(cpage == 1){
			out.println("<span><a href=''>이전 페이지</a></span>");
		} else{
			out.println("<span><a href='./book_list.do?cpage="+(cpage-1)+"'><i class='fa fa-arrow-left' aria-hidden='true' color='white'></i></a></span>");
		}
		
		out.println("&nbsp;&nbsp;");
     	
     	for(int i=startBlock; i<=endBlock; i++){
     		if(cpage == i){
     			out.println("<span>["+i+"]</span>");
     		} else {
     			out.println("<span><a href ='./book_list.do?cpage="+i+"'>"+i+"</a></span>");
     		}
     	}
     	
     	out.println("&nbsp;");
		
		if(cpage == totalPage){
			out.println("<span><a href=''>다음 페이지</a></span>");
		} else{
			out.println("<span><a href='./book_list.do?cpage="+(cpage+1)+"' ><i class='fa fa-arrow-right' aria-hidden='true'></i></a></span>");
		}
		
		
		out.println("&nbsp;");
		
		if (endBlock== totalPage){
			out.println("<span><a> 끝</a></span>");
		} else {
			out.println("<span><a href='./book_list.do?cpage="+totalPage+"'> 끝</a></span>");
		}
		
     	
     %>
     </div>
     </footer>
     <br><br>
</div>

</body>
</html>