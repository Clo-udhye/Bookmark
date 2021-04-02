<%@page import="com.exam.boardlist.MyPageTO"%>
<%@page import="com.exam.boardlist.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 입력된 useq에 해당하는 유저의 정보 
	UserTO visit_TO = (UserTO)request.getAttribute("visiterTO");
	String visit_seq = visit_TO.getSeq();
	String visit_id = visit_TO.getId();
	String visit_nickname = visit_TO.getNickname();
	String visit_mail = visit_TO.getMail();
	String visit_address = visit_TO.getAddress();
	String visit_addresses = visit_TO.getAddresses();
	String visit_introduction = visit_TO.getIntroduction();
	String visit_profile_filename = visit_TO.getProfile_filename();
	String visit_keywords = visit_TO.getKeywords();

	// 나의 페이지인지, 다른 사람의 마이페이지인지 구분하는 flag
	int mypage_flag = 0;
	
	//현재 세션 상태를 체크 및 입장한 user check
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		String user_seq = userInfo.getSeq();
		String user_id = userInfo.getId();
		
		if (user_seq.equals(visit_seq)){ // 나의 마이페이지 일때,
			mypage_flag = 1;
		}
	}
	
	// myboardlist
	int changeRow = 0;
	StringBuffer sbHtml = new StringBuffer();
	ArrayList<MyPageTO> myboard_lists = (ArrayList)request.getAttribute("myboard_list");
	for (MyPageTO myboard_list : myboard_lists){
		changeRow++;
		String bseq = myboard_list.getSeq();
		String title = myboard_list.getTitle();
		if(title.length() > 20){
			title = myboard_list.getTitle().substring(0, 20) + "...";
		}
		String filename = myboard_list.getFilename();
		int likey = myboard_list.getLike();
		int comment = myboard_list.getComment();
		
		sbHtml.append("<td class='board board1' bseq='"+bseq+"' data-bs-toggle='modal' data-bs-target='#modal'>");
		// 사진 크기 250 250
		sbHtml.append("	<div class='img'>");
		sbHtml.append("		<img src='./upload/"+filename+"' border='0' width=200px height=200px/>");
		sbHtml.append("	</div>");
		sbHtml.append("	<div class='text'>");
		sbHtml.append("      <div id='text_title'><p>"+title+"</p></div>");
		sbHtml.append("      <div id='text_nickname'><p>by "+visit_nickname+"</p></div>");
		sbHtml.append("      </br>");
		sbHtml.append("      <div id='text_count' align='right'>");
		sbHtml.append("         <span id='text_likey'><i class='fas fa-heart'></i>&nbsp;"+likey+"</span>");
		sbHtml.append("         &nbsp;");
		sbHtml.append("         <span id='text_comment'><i class='fas fa-comment-dots'></i>&nbsp;"+comment+"</span>");
		sbHtml.append("      </div>");   

		sbHtml.append("	</div>");
		sbHtml.append("</td>");
		if(changeRow%3 == 1 && changeRow>3){
			sbHtml.append("	</tr><tr>");
		}
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
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

<!-- high charts -->
<script src="http://cdn.static.w3big.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>

<!-- 드롭다운 리스트 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>
<style>

.button1{
	float: right;
	margin-right:50px;
	width: 30px;
	font-size: 20px;
}
.button2{
	float: right;
	margin-right: 70px;
	width: 30px;
	font-size: 20px;
}
.button3{
	align: right;
	width: 30px;
	font-size: 20px;
}

.box {
    width: 300px;
    height: 300px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.profile_info {
	margin : 15px;
}

.wrap3 {
	float: left;
}

.wrapTable3 tr,th,td {
	padding : 5px;
	margin : 5px;
}

#wrapTable3 {
	height :300px;
	width : 100%;
	border : 1px solid #F5F5DC;
	
}
#vertical3 {
		width: max-content;
		overflow-y: scroll;
		height : 300px;
}
.board:hover .img {filter: brightness(60%);}
.text {text-align: center; position: absolute; top: 50%; left: 50%; transform: translate( -50%, -50% ); color: white; opacity: 0;}
.text #a1 {text-decoration: none; color: white; font-weight: bold;}
.board:hover .text {opacity: 1;}
.board {position: relative;}
.board_pagetab { text-align: center; } 
.board_pagetab a { text-decoration: none; font: 15px verdana; color: #000; padding: 0 3px 0 3px; }
.board_pagetab a:hover { text-decoration: underline; background-color:#f2f2f2; }
.board {padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 10px;}

#text_title p {font-size: 16px;}
#text_nickname p {font-size: 12px;}
#text_count span {font-size: 12px;}


</style>

<script>
$(document).ready(function(){	
	$('.board1').click(function(e){
		$('.modal-content').load("./view.do?seq=" + $(this).attr('bseq'));
	});
})
</script>

<script type="text/javascript">
	$(document).ready(function(){
		$("#modify_userInfo").click(function(){
		  	// seq=뒤에 1 대신 받아온 값 넣어야 함.
			$('.modify-content').load("./mypage_modify.do?seq="+<%=visit_seq%>);

		});

	});
</script>
<style type="text/css">
	
	#modifymodal1 {width: 650px;}
	
	.filebox label { display: inline-block; padding: .5em .75em; color: #999; font-size: inherit; line-height: normal; vertical-align: middle; background-color: #fdfdfd; cursor: pointer; border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; }
	.filebox input[type="file"] { /* 파일 필드 숨기기 */ position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; }

</style>

</head>
<body style="overflow-y:scroll;">

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
		
	    <div id="content"  style="padding-top : 100px;">
		    <%if (mypage_flag == 1) { %>
		    	<div><h1>MY PAGE</h1></div>
		    <%} %>
		    <div>
		    <table width=90% height="500" style="padding : 10px; background-color:#FFFAFA;" align="center">
			    <tr height="50">
			    	<td>
			    		<span style="padding-top:20px;"><h2><%= visit_nickname %>님의 프로필</h2></span>
			    	</td>
			    	<td align="right" style="padding-right : 5%;">
			    		<span>
			    		<%if (mypage_flag == 1) { %>
			    			<button id="modify_userInfo" data-bs-toggle="modal" data-bs-target="#modifymodal" type="button" class="btn btn-dark" >수정하기</button>
		    			<%} %>
		    			</span>
			    	</td>
			    </tr>
			    <tr height="400">
			    	<td colspan="2">
			    		<table width=90% height="500" align="center">
			    			<tr >
			    				<td width=20%>
				    				<div class="box">
				    					<img class="profile" alt="프로필 없음" src="./profile/<%=visit_profile_filename%>">
				    				</div>
			    				</td>
			    				<td width=30%>
			    					<div class="profile_info"> 별명 : <%=visit_nickname %></div>
			    					<div class="profile_info"> 소개 : <%=visit_introduction %></div>
			    					<div class="profile_info"> 태그 : <%= visit_keywords %></div>
			    					<div class="profile_info"> 총 게시글 : <%=request.getAttribute("board_counts") %>개</div>
			    				</td>
			    				<td width=50%>
				    				<div id="vertical3">
		       							<div class="wrap3">
		       								<table  id="wrapTable3" >
				    						<tr>
				    							<%=sbHtml %>
				    						</tr>
				    					</table>
				    					</div>	
			    					</div>
			    				</td>
			    			</tr>
			    		
			    		</table>
			    	</td>
			    </tr>
	        	
	        </table>
	        <br><hr><br>
	        <div>
			<%if (mypage_flag == 1) { %>
			<div>
				<div style="padding-left:5%; margin-bottom:50px;">
					<h2>전체 게시글 인사이트</h2>
				</div>
				<div>
					<div style="float: left; width: 50%; padding-left:5%">
						<div class="btn-group" style="padding-left:10%;" >
						  <button type="button" class="btn btn-dark catalogue" value="action">액션</button>
						  <button type="button" class="btn btn-dark catalogue" value="hit">조회수</button>
						  <button type="button" class="btn btn-dark catalogue" value="like">좋아요</button>
						  <button type="button" class="btn btn-dark catalogue" value="comment">댓글</button>
						</div>
					</div>
					<div style="float: left; width: 50%; padding-left:25%">
						<div class="dropdown">
						  <button type="button" class="btn btn-dark dropdown-toggle" data-toggle="dropdown">
						    시간 구분
						  </button>
						  <div class="dropdown-menu">
						    <a class="dropdown-item" value="day">요일 별 평균</a>
						    <a class="dropdown-item" value="time">시간대 별 평균</a>
						  </div>
						</div>
					</div>
				</div>
				<div style="padding-left:10%; padding-top:3%">
					<h6 style="color:gray; font-size:10px;">액션은 '조회수','좋아요','댓글'를 합친 횟수입니다.</h6>
				</div>
		    	<div align="center">
		    		<div id="container" style="width: 80%; height: 600px; margin: 0 auto;" align="center";></div>
		    	</div>
	    	</div>
	    	<br><br><hr><br><br>
<script>
	let catalogue = "action";
	let timecontrol = "day";
	var title = {text: "액션 별 모아보기"};
	var xAxis = {categories: ['일','월','화','수','목','금','토']};
	var series =  [
	    {
	       name: 'Tokyo',
	       data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2]
	    }
 	];
	
function highChartFunc(title, xAxis, series) {
   var subtitle = {
        text: 'by BOOKMARK'
   };
   var yAxis = {
      title: {
         text: '발생 횟 수'
      },
      plotLines: [{
         value: 0,
         width: 1,
         color: '#808080'
      }]
   };   
   var tooltip = {
      valueSuffix: '회'
   }
   var legend = {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle',
      borderWidth: 0
   };
   var json = {};

   json.title = title;
   json.subtitle = subtitle;
   json.xAxis = xAxis;
   json.yAxis = yAxis;
   json.tooltip = tooltip;
   json.legend = legend;
   json.series = series;

   $('#container').highcharts(json);
}
  	
// 마이페지이 로드 시, 차트 로딩
$(document).ready(function() {
	highChartFunc(title, xAxis, series);
});

//액션,조회수,좋아요,댓글 클릭 시
$(function() {
	$(document).on("click",".catalogue",function(){
		catalogue = $(this).attr("value");
		if(catalogue == "action"){
			title = {text: "액션 별 모아보기"};
		} else if (catalogue == "hit"){
			title = {text: "조회수 별 모아보기"};
		}else if (catalogue == "like"){
			title = {text: "좋아요 별 모아보기"};
		} else if(catalogue == "comment"){
			title = {text: "댓글 별 모아보기"};
		}
		highChartFunc(title, xAxis, series);
	});
});
// 시간 구분 클릭 시, default 
$(function() {
	$(document).on("click",".dropdown-item",function(){
					timecontrol = $(this).attr("value");
					if(timecontrol=="day"){
						xAxis = {categories: ['일','월','화','수','목','금','토']};
					} else if(timecontrol == "time"){
						xAxis = {categories: ['03-04','05-06','07-08','09-10','11-12','13-14','15-16','17-18', '19-20', '21-22','23-24', '01-02']};
					}
					highChartFunc(title, xAxis, series);
				});
			});
</script>
		    <%} %> 	
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
	</div>

<div id="modifymodal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content modify-content" id="modifymodal1"></div>
	</div>
</div>

<div id="zipsearchmodal" class="modal fade" tabindex="-1" role="dialog" data-bs-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content address-content"></div>
	</div>
</div>

</body>
</html>