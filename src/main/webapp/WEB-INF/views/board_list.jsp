<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.exam.boardlist.BoardDAO" %>
<%@ page import="com.exam.boardlist.BoardTO" %>
<%@ page import="com.exam.boardlist.BoardPagingTO" %>
<%@ page import="java.util.ArrayList" %>

<%
	//현재 세션 상태를 체크한다
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	}
	/*
	// BoardListTO = BoardPagingTO
	// listTO = pagingTO

	BoardPagingTO pagingTO = (BoardPagingTO)request.getAttribute( "pagingTO" );
	ArrayList<BoardTO> booklists = pagingTO.getBoardList();
	//pagingTO pagelistTO = (pagingTO)request.getAttribute("paginglist");
    //ArrayList<BookTO> booklists = pagelistTO.getBookList();
	
	int cpage = 1;	// cpage가 없으면 1
	
	//if(pagelistTO.getCpage()!= 0){
    //	cpage = pagelistTO.getCpage();
    //}
	if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")){	
		cpage = Integer.parseInt(request.getParameter("cpage"));
	}
	*/
	
	BoardPagingTO pagingTO = (BoardPagingTO)request.getAttribute( "pagingTO" );
	//BoardPagingTO pagingTO = new BoardPagingTO();
	//pagingTO.setCpage(cpage);
	int cpage = pagingTO.getCpage();
	
	//BoardDAO dao = new BoardDAO();
	//pagingTO = dao.boardList(pagingTO);

	int recordPerPage = pagingTO.getRecordPerPage();
	int totalRecode = pagingTO.getTotalRecord();
	
	int totalPage = pagingTO.getTotalPage();
	
	int blockPerPage = pagingTO.getBlockPerPage();
	
	int startBlock = pagingTO.getStartBlock();
	int endBlock = pagingTO.getEndBlock();
	
	ArrayList<BoardTO> lists = pagingTO.getBoardList();

	//ArrayList<BoardTO> lists = (ArrayList)request.getAttribute( "lists" );
	
	
	StringBuffer sbHtml = new StringBuffer();
	
	int cnt = 0;
	if(lists != null){
		for( BoardTO to : lists ) {
			cnt++;
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
			
			//System.out.println(filename);
			//System.out.printf("%s, %s, $s, $s, $s, $s",	recordPerPage, totalRecode, totalPage, blockPerPage, startBlock, endBlock);
			// 수정하기 ★★★
			if(cnt % blockPerPage == 1) {
				sbHtml.append("</tr>");
				sbHtml.append("<tr>");
			}
		
			/* 완성코드
			sbHtml.append("<td class='board'>");
			// 사진 크기 250 250
			sbHtml.append("	<div class='img'>");
			sbHtml.append("		<a href='view.do'><img src='./upload/"+filename+"' border='0' width=250px height=250px/></a>");
			sbHtml.append("	</div>");
			sbHtml.append("	<div class='text'>");
			//sbHtml.append("		<a href='board_view.jsp'><p>"+title+"</p></a>");
			sbHtml.append("		<a href='board_view.jsp'>"+title+"</a>");
			sbHtml.append("	</div>");
			sbHtml.append("</td>");
			*/
			
			if(filename == null) {
				sbHtml.append("<td class='board'  width=250px height=250px>");
				// 사진 크기 250 250
				sbHtml.append("	<div class='img'>");
				sbHtml.append("	</div>");
				sbHtml.append("	<div class='text'>");
				sbHtml.append("	</div>");
				sbHtml.append("</td>");


				//sbHtml.append("<td>"+filename+"</td>");
			} else {
				sbHtml.append("<td class='board board1' bseq='"+seq+"' data-bs-toggle='modal' data-bs-target='#modal'>");
				// 사진 크기 250 250
				sbHtml.append("	<div class='img'>");
				sbHtml.append("		<img src='./upload/"+filename+"' border='0' width=250px height=250px/>");
				sbHtml.append("	</div>");
				sbHtml.append("	<div class='text'>");
				//sbHtml.append("		<a href='board_view.jsp'><p>"+title+"</p></a>");
				sbHtml.append("		<a>"+title+"</a>");
				sbHtml.append("	</div>");
				sbHtml.append("</td>");
			}
				
			/* 완성된 코드 ★★★
			sbHtml.append("<td class='board'>");
			// 사진 크기 250 250
			sbHtml.append("					<a href='board_view.jsp'><img src='./upload/"+filename+"' border='0' width=250px height=250px/></a>");
			sbHtml.append("</td>");
			*/
			
			/*
			//sbHtml.append("<tr>");
			//sbHtml.append("<td width='20%' class='last2'>");
			//sbHtml.append("<td width=250px height=250px class='last2'>");
			sbHtml.append("<td class='last2'>");
			sbHtml.append("	<div class='board'>");
			sbHtml.append("		<table class='boardT'>");
			sbHtml.append("		<tr>");
			sbHtml.append("			<td class='boardThumbWrap'>");
			sbHtml.append("				<div class='boardThumb'>");
			
			//sbHtml.append("					<a href='board_view.jsp'><img src='./upload/"+filename+"' border='0' width='100%' /></a>");
			sbHtml.append("					<a href='board_view.jsp'><img src='./upload/"+filename+"' border='0' width=250px height=250px/></a>");
			
			//sbHtml.append("						<div class='transbox'>");
		  	//sbHtml.append("							<p>"+title+"</p>");
		  	//sbHtml.append("						</div>");
			
		  	sbHtml.append("				</div>");
			sbHtml.append("			</td>");
			sbHtml.append("		</tr>");
			sbHtml.append("		</table>");
			sbHtml.append("	</div>");
			sbHtml.append("</td>");
			//sbHtml.append("</tr>");
			*/
			
		}		
	}
	
	//System.out.println(totalRecode);
	/*
	int addcol = recordPerPage - (totalRecode % recordPerPage);
	System.out.println(addcol);
	if(totalRecode % recordPerPage != 0) {
		for(int add=1; add<=addcol; add++) {
			sbHtml.append("<td></td>");
		}
	}
	*/
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
	
	.board:hover .img {filter: brightness(60%);}
	.text {text-align: center; position: absolute; top: 50%; left: 50%; transform: translate( -50%, -50% ); color: white; opacity: 0;}
	.text a {text-decoration: none; color: white; font-weight: bold;}
	.board:hover .text {opacity: 1;}
	.board {position: relative;}
	.board_pagetab { text-align: center; } 
	.board_pagetab a { text-decoration: none; font: 15px verdana; color: #000; padding: 0 3px 0 3px; }
	.board_pagetab a:hover { text-decoration: underline; background-color:#f2f2f2; }
	.board {padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 10px;}
	#content {position: absolute; left: 50%; transform: translateX(-50%);}
	
</style>
<!--
class=board에 마우스 갖다대면 class=img를 filter 적용
class=text 사진 정가운데에 위치시키고, opacity(불투명도)를 0으로 줘서 안보이게 함
class=text의 a인 링크부분 밑줄에 파란글씨 아니고, 그냥 하얀 글자로 보이게. 그리고 굵게
class=board에 마우스 갖다대면 class-text opacity(불투명도)를 1로 줘서 보이게 함
이미지 위에 텍스트 갖다 놓으려면 이미지와 텍스트를 묶고있는 class에 position을 relative로 해야한다고 해서 함
class=board_pagetab 페이지탭 가운데 위치
class=board_pagetab의 a인 링크부분  링크지만 글자색 검은색
class=board_pagetab의 a 페이지탭에 마우스 갖다대면 밑줄 & 회색 배경
class=board 각 사진마다 padding 여백
id=content 본문 가운데 위치

## 다른 방법.
#content {padding-left: 350px;}
#content {position: absolute; left: 50%; transform: translateX(-50%);}

-->
<!-- ■■ /내가 추가한 부분 ■■ -->
<script>
$(document).ready(function(){	
	$('.board1').click(function(e){
		//alert($(this).attr('bseq')+"클릭");
		//console.log("./view.do?seq=" + $(this).attr('bseq'));
		$('.modal-content').load("./view.do?seq=" + $(this).attr('bseq'));
	});
})
</script>

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
			<a href="./mypage.do">My Page</a>
		<%}
	}%>
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
	        <% if(userInfo == null){ %>
	        <span><a href="./login.do">시작하기</a></span>
	        <% }else{ %>
	        <span><a href="./logout_ok.do">로그아웃</a></span>
	        <% } %>
			<span><a href="./search.do"><i class="fa fa-search" aria-hidden="true"></i></a></span>		
    	</p>
    </div>
    
    <div id="content">
        <!-- <h1>게시글 리스트</h1> -->
        	
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
<%
	// << 표시 설정
	//if(startBlock == 1) {
	if(cpage == 1) {
		out.println("<span class='off'><a>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
	} else {
		//out.println("<span class='off'><a href='./list.do?cpage="+(startBlock-blockPerPage)+"'>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
		out.println("<span class='off'><a href='./list.do?cpage="+1+"'>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
	}

	// < 표시 설정
	if (cpage == 1) {
		out.println("<span class='off'><a>&lt;이전&gt;</a>&nbsp;&nbsp;</span>");
	} else {
		out.println("<span class='off'><a href='./list.do?cpage="+(cpage-1)+"'>&lt;이전&gt;</a>&nbsp;&nbsp;</span>");
	}

	
	for(int i=startBlock; i<=endBlock; i++) {
		
		if(cpage == i) {
			// 현재 페이지
			out.println("<span class='on'><a>( "+i+" )</a></span>");
		} else {
			out.println("<span class='off'><a href='./list.do?cpage="+i+"'>"+i+"</a></span>");
		}
	}

	// > 표시 설정
	if (cpage == totalPage) {
		out.println("<span class='off'>&nbsp;&nbsp;<a>&lt;다음&gt;</a></span>");
	} else {
		out.println("<span class='off'>&nbsp;&nbsp;<a href='./list.do?cpage="+(cpage+1)+"'>&lt;다음&gt;</a></span>");
	}

	// >> 표시 설정
	//if(endBlock == totalPage) {
	if(cpage == totalPage) {
		out.println("<span class='off'>&nbsp;&nbsp;<a>&lt;끝&gt;</a></span>");
	} else {
		//out.println("<span class='off'>&nbsp;&nbsp;<a href='list.do?cpage="+(startBlock+blockPerPage)+"'>&lt;끝&gt;</a></span>");
		out.println("<span class='off'>&nbsp;&nbsp;<a href='list.do?cpage="+totalPage+"'>&lt;끝&gt;</a></span>");
	}
		
%>
				<!--  
				<span class="off"><a href="#">&lt;처음&gt;</a>&nbsp;</span>
				<span class="off"><a href="#">&lt;이전&gt;</a>&nbsp;</span>
				<span class="on"><a href="#">( 1 )</a></span>
				<span class="off"><a href="#"> 2 </a></span>
				<span class="off"><a href="#"> 3 </a></span>
				<span class="off"><a href="#"> 4 </a></span>
				<span class="off"><a href="#"> 5 </a></span>
				<span class="off">&nbsp;<a href="#">&lt;다음&gt;</a></span>
				<span class="off">&nbsp;<a href="#">&lt;끝&gt;</a></span>
				-->
			</div>
		</div>
		<!--//페이지넘버-->
		<!-- ■■ /내가 추가한 부분 ■■ -->
    </div>
</div>
<!-- 모달창 정보 -->
<div id="modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">               
		</div>
	</div>
</div>
</body>
</html>