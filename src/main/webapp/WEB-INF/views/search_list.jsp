<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.exam.boardlist.BoardDAO" %>
<%@ page import="com.exam.boardlist.BoardTO" %>
<%@ page import="com.exam.user.UserTO" %>
<%@ page import="com.exam.boardlist.BoardPagingTO" %>

<%
	//현재 세션 상태를 체크한다
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	}

	//tlist 검색 결과 개수 처리
	BoardPagingTO slpagingTO = (BoardPagingTO)request.getAttribute( "slpagingTO" );
	int tTotalRecord = slpagingTO.getTotalRecord();
	
	//nlist 검색 결과 개수 처리
	//BoardPagingTO snlpagingTO = (BoardPagingTO)request.getAttribute( "snlpagingTO" );
	//int nTotalRecord = snlpagingTO.getTotalRecord();
	
	//nnlist 검색 결과 개수 처리
	BoardPagingTO snnlpagingTO = (BoardPagingTO)request.getAttribute( "snnlpagingTO" );
	int nTotalRecord = snnlpagingTO.getTotalRecord();

	//System.out.println(tTotalRecord);
	//System.out.println(nTotalRecord);
	
	String searchword = (String)request.getAttribute("searchword");
	
    StringBuffer SearchResult = new StringBuffer();
    if (searchword != null){
    	SearchResult.append("<div><h2><span id='result'>"+searchword+"</span> (으)로 검색한 결과</h2></div>");
    	SearchResult.append("<div><h4>총 "+(tTotalRecord+nTotalRecord)+"건("+"게시글 "+tTotalRecord+" / 작가 "+nTotalRecord+")</h4></div>");
    	//System.out.println(searchword);
    	//System.out.println(searchword.length());
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
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>

<!-- searchresult_tab -->

<script type="text/javascript">
window.onload = function(){
	var active = "<%= request.getParameter("active")%>";
	
	document.getElementById(active).style.display = "block";
	document.getElementById(active+"_btn").className += " active";
}
	
function openTab(evt, tabName) {
	var i, tabcontent, tablinks;
	tabcontent = document.getElementsByClassName("tabcontent"); // 컨텐츠를 불러옵니다.
	for (i = 0; i < tabcontent.length; i++) {
		tabcontent[i].style.display = "none"; //컨텐츠를 모두 숨깁니다.
	}
	tablinks = document.getElementsByClassName("tablinks"); //탭을 불러옵니다.
	for (i = 0; i < tablinks.length; i++) {
		tablinks[i].className = tablinks[i].className.replace(" active", ""); //탭을 초기화시킵니다.
	}
	
	document.getElementById(tabName).style.display = "block"; //해당되는 컨텐츠만 보여줍니다.
	evt.currentTarget.className += " active"; //클릭한 탭을 활성화시킵니다.

	//console.log("tabName : "+ tabName);
	var tpage = 1;
	<% if(request.getParameter("tpage")!=null) {%>
		tpage = <%= request.getParameter("tpage")%>;
	<%}%>;
	
	var npage = 1;
	<% if(request.getParameter("npage")!=null) {%>
		npage = <%= request.getParameter("npage")%>;
	<%}%>;
	
	let searchword = "";
	searchword = "<%= request.getParameter("searchword")%>";

	//console.log(searchword);
	location.href="search_list.do?active="+tabName+"&searchword="+searchword+"&tpage="+tpage+"&npage="+npage;
}

</script>

<script>
$(document).ready(function(){	
	$('.board1').click(function(e){
		//alert($(this).attr('bseq')+"클릭");
		//console.log("./view.do?seq=" + $(this).attr('bseq'));
		$('.modal-content').load("./view.do?seq=" + $(this).attr('bseq'));
	});
})
</script>

<!-- ■■ 내가 추가한 부분 ■■ -->
<style type="text/css">
	.button1{
	float: right;
	margin-right: 0px;
	
	font-size: 30px;

}
	.button2{
	float: right;
	margin-right: 15px;
	width: 30px;
	font-size: 20px;
}
	.button3{
	float: right;	
	width: 30px;
	font-size: 20px;
}
	.board:hover .img {filter: brightness(60%);}
	.text {text-align: center; position: absolute; top: 50%; left: 50%; transform: translate( -50%, -50% ); color: white; opacity: 0;}
	.text {width: 180px;}
	#text_title p {font-size: 16px;}
	#text_nickname p {font-size: 12px;}
	#text_count span {font-size: 12px;}
	.board:hover .text {opacity: 1;}
	.board {position: relative;}
	.board_pagetab { text-align: center; } 
	.board_pagetab a { text-decoration: none; font: 15px verdana; color: #000; padding: 0 3px 0 3px; }
	.board_pagetab a:hover { text-decoration: underline; background-color:#f2f2f2; }
	.board {padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 10px;}
	#content {position: absolute; left: 50%; transform: translateX(-50%);}
	
	.tabcontent {background-color: rgb(250, 250, 250); border: 3px solid #a6a6a6;}
	.tab { width: 1356px; height: 50px; }
	.tablinks {float: left; width: 50%; height: 100%; border: none; outline: none; font-size: 16px; font-weight: bold; color: #000; background-color: #fff;}
	.tablinks.active {color: #fff; background-color: #a6a6a6;}
	
</style>
<!--

class=board에 마우스 갖다대면 class=img를 filter 적용
class=text 사진 정가운데에 위치시키고, opacity(불투명도)를 0으로 줘서 안보이게 함
text부분 길이 조절
class=board에 마우스 갖다대면 class-text opacity(불투명도)를 1로 줘서 보이게 함
이미지 위에 텍스트 갖다 놓으려면 이미지와 텍스트를 묶고있는 class에 position을 relative로 해야한다고 해서 함
class=board_pagetab 페이지탭 가운데 위치
class=board_pagetab의 a인 링크부분  링크지만 글자색 검은색
class=board_pagetab의 a 페이지탭에 마우스 갖다대면 밑줄 & 회색 배경
class=board 각 사진마다 padding 여백
id=content 본문 가운데 위치

tab내용부분 회색배경, 테두리
tab메뉴 전체 크기 조절
tab하나 처리
클릭한tab의 색 처리
-->
<!-- ■■ /내가 추가한 부분 ■■ -->

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
    <div id="content">
        <!-- <h1>검색 결과 페이지</h1> -->
		<%=SearchResult %>
        
		<div class="tab">
			<button class="tablinks" id="tab1_btn" onclick="openTab(event, 'tab1')">게시글</button> <!-- 처음 보여줄 탭 -->
			<button class="tablinks" id="tab2_btn" onclick="openTab(event, 'tab2')">작가</button>
		</div>

		
		<div id="tab1" class="tabcontent" style="display: none;"><!-- 처음 보여줄 컨텐츠 -->
		<!-- 탭 1 내용 search_tlist.jsp -->
		<jsp:include page="search_tlist.jsp" />
		</div> 
		 
		<div id="tab2" class="tabcontent" style="display: none;">
		<!-- 탭2 내용 search_nnlist.jsp -->
		<jsp:include page="search_nnlist.jsp" />
		</div>
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