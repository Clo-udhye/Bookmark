<%@page import="com.exam.user.UserTO"%>
<%@page import="com.exam.booklist.BookRelatedTO"%>
<%@page import="com.exam.booklist.BookTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//현재 세션 상태를 체크한다
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	}
	
	BookTO to = (BookTO)request.getAttribute("book_info");
	String master_seq = to.getMaster_seq();
	String isbn13 = to.getIsbn13();
	String title = to.getTitle();
	String author = to.getAuthor();
	String publisher = to.getPublisher();
	String img_url = to.getImg_url();
	String description = to.getDescription();
	String pub_date = to.getPub_date();
	
	int cpage = (Integer)request.getAttribute("cpage");
	// cpage는 받아오지만 뒤롸기 버튼 클릭 시 --> 해당 cpage를 받아가진 모못함
	
	StringBuffer board_related = new StringBuffer();
	int i = 0;
	ArrayList<BookRelatedTO> lists = (ArrayList)request.getAttribute("relatedBoard");
	if (lists.size() != 0 ){
		for (BookRelatedTO bookRelatedTO : lists){
			String board_title = bookRelatedTO.getBoard_title();
			String board_date = bookRelatedTO.getBoard_date().substring(0, 10);
			String board_seq = bookRelatedTO.getBoard_seq();
			String user_nickname = bookRelatedTO.getUser_nickname();
			
			board_related.append("<tr>");
			board_related.append("<td>"+board_title+"</td>");
			board_related.append("<td>"+board_date+"</td>");
			board_related.append("<td>"+user_nickname+"</td>");
			board_related.append("<td><input type='button' value='보러가기' id='modal-link"+i+"' data-bs-toggle='modal' data-bs-target='#view-modal' board_seq='"+board_seq+"'/>");
			board_related.append("</tr> \n");
			i += 1;
		}
	} else {
		board_related.append("<tr>");
		board_related.append("<td colspan='4'> 관련 게시글이 없습니다.</td>");
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

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<!-- <style>#content {position: absolute; left: 50%; transform: translateX(-50%);}</style>  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&family=Quicksand:wght@500&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>

<!-- 글쓰기 Summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap');
	#main{
		font-family: 'Noto Serif KR', serif;
	}
	#view-modal{
		font-family: 'Noto Serif KR', serif;
	}
   body {
 font-family: 'Noto Serif KR', serif;
  background: #white;
}	
.button1{
	float: right;
	margin-right:20px;
	width: 20px;
	font-size: 20px;

}
.button2{
	float: right;
	margin-right: 30px;
	width: 30px;
	font-size: 20px;
}
	.button3{
	margin-right: 0px;
	width: 30px;
	font-size: 20px;
}

	#table {
		border: 1px solid black;
		width : 80%;
		height : 50%;
	}
	#img {
		padding : 10px;
		align : center;
		width : 400px;
	}
	.vertical {
		width: 99%;
		overflow-y: scroll;
		height : 200px;
	}
	.wrap1 {
		float: left;
		width: 100%;
	}
	.wrapTable1 table {
		border : 1px;
	}
	.wrapTable tr:hover {
		background-color : ivory;
		font-color : black; 
	}
	.button1, .button2{
	width: 30px;
	font-size: 25px;

</style>

<script type="text/javascript">
$(document).ready(function(){
    for(var index=0; index<<%=lists.size()%>; index++){
       $("#modal-link"+index).click(function(){
          //console.log($(this).attr('id')); //  $("#modal-link"+index) 클릭은 잘 되는 중
          // 각 hidden의 value값을 읽어 오지 못하고 있다. --> hidden 말고 input 태그 내 attr을 임의로 생성해서 받아올 수 있음 
          var seq = $(this).attr('board_seq');
          //console.log(seq);
          $('.view-content').load("./view.do"+"?seq=" + seq);   
       });
    }
    
    $("#write_button").on('click', function(){
       <%if(userInfo!=null){%>
       console.log("123");
          $("#write-modal").modal("show");
          $('.write-content').load("./write.do");
       <%}else{%>
          var comfirm_login = confirm("로그인이 필요한 서비스입니다. \n'확인'버튼을 클릭 시, 로그인 창으로 이동합니다.");
          if(comfirm_login==true){
             location.href="./login.do";
          }
       <%}%>              
    });
 });
</script>

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
    
    <div id="content" style="padding-top : 100px;">
    <table id="table" align="center">
    	<tr>
    		<td colspan="3" align="right"><div ><input type="button" onclick="history.back()" value="뒤로 가기"></div></td>
   		</tr>
   		<tr>
   			<td width="25%" rowspan="6"><img src="<%=img_url %>" alt="이미지 없음" id = "img"/></td>
   			<td colspan="2"><div>책 제목 : <%=title %></div></td>
   		</tr>
   		<tr>
   			<td colspan="2"><div>저자 : <%=author %></div></td>
   		</tr>
   		<tr>
   			<td colspan="2"><div>출판사 : <%=publisher %></div></td>
   		</tr>
   		<tr>
   			<td colspan="2"><div>출판일 : <%=pub_date %></div></td>
   		</tr>
   		<tr>
   			<td colspan="2"><p>책 설명 : <%=description %></td>
   		</tr>
   		<tr>
   			<td colspan="2">
   				<div>
   					<div><h4>관련 게시글</h4></div>
   					<% if (lists.size() != 0){ %>
   					<div class="vertical">
   						<div class="wrap" width="100%">
					    	<table border=1 width="100%" class="table wrapTable" >
					    		<tr>
						    		<th style="width:60%">게시글 제목</th>
						    		<th style="width:15%">작성 일자</th>
						    		<th style="width:15%">작성자</th>
						    		<th style="width:10%"></th>    		
					    		</tr>
					    		<%= board_related%>
					    	</table>
				    	</div>
			    	</div>
			    	<% } else { %>
			    	<div height="200px">
   						<div class="wrap" style="width:100%">
					    	<table border=1 style="width:100%" class="table wrapTable"  >
					    		<tr>
						    		<th style="width:60%">게시글 제목</th>
						    		<th style="width:15%">작성 일자</th>
						    		<th style="width:15%">작성자</th>
						    		<th style="width:10%"></th>    		
					    		</tr>
					    		<%= board_related%>
					    	</table>
				    	</div>
			    	</div>
			    	<% } %>
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