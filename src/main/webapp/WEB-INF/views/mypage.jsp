<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Collections"%>
<%@page import="com.exam.MyPage.WeekTO"%>
<%@page import="java.awt.List"%>
<%@page import="com.exam.MyPage.TodayTO"%>
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
	// keywords 분리
	String[] kwdarray = visit_keywords.split("//");
	
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
	if(myboard_lists.size()==0){
		sbHtml.append("<td> <div style='padding-top:80px;'>");
		if(mypage_flag==0){
		sbHtml.append("<h4>아직 책을 읽고 있는 중이에요! 다음에 또 방문해 주세요.</h4>");
		} else if(mypage_flag == 1){
			sbHtml.append("<h4>등록 되어있는 게시글이 없습니다.</h4>");
			sbHtml.append("<h3>새로운 게시글을 작성 하시겠습니까?</h3>");
			sbHtml.append("<button id='new_article' class='btn btn-dark write_button' >새로운 글 작성하기</button>");
		}
		sbHtml.append("</div></td>");
	} else{
		for (MyPageTO myboard_list : myboard_lists){
			changeRow++;
			String bseq = myboard_list.getSeq();
			String title = myboard_list.getTitle();
			/*
			if(title.length() > 20){
				title = myboard_list.getTitle().substring(0, 20) + "...";
			}
			*/
			String filename = myboard_list.getFilename().split("//")[0];
			int likey = myboard_list.getLike();
			int comment = myboard_list.getComment();
			
			if(changeRow%3 == 1 && changeRow>3){
			       sbHtml.append("   </tr><tr>");
			    }	
			sbHtml.append("<td class='board board1' bseq='"+bseq+"' data-bs-toggle='modal' data-bs-target='#view-modal'>");
		    // 사진 크기 250 250
		    sbHtml.append("   <div class='img'>");
		    sbHtml.append("      <img src='./upload/"+filename+"' border='0' width=200px height=200px/>");
		    sbHtml.append("   </div>");
		    sbHtml.append("   <div class='text' style='width:140px;'>");
		    //sbHtml.append("      <div id='text_title'><p>"+title+"</p></div>");
		    sbHtml.append("		<div id='text_title' style='height:48px; overflow-x:hidden; overflow-y:hidden; margin-bottom: 16px;'><p>"+title+"</p></div>");
		    sbHtml.append("      <div id='text_nickname'><p>by "+visit_nickname+"</p></div>");
		    sbHtml.append("      </br>");
		    sbHtml.append("      <div id='text_count' align='right'>"); //onclick='event.cancelBubble=true' --> 특정 영역 이벤트 방지
		    if(mypage_flag==1){
		       sbHtml.append("         <span id='insight-modal"+Integer.toString(changeRow)+"' bseq='"+bseq+"' data-bs-toggle='modal' data-bs-target='#insightmodal' onclick='event.cancelBubble=true'><i class='fas fa-search-plus'></i>&nbsp;&nbsp;&nbsp;</span>");
		    }
		    sbHtml.append("         <span id='text_likey'><i class='fas fa-heart'></i>&nbsp;"+likey+"</span>");
		    sbHtml.append("         &nbsp;");
		    sbHtml.append("         <span id='text_comment'><i class='fas fa-comment-dots'></i>&nbsp;"+comment+"</span>");
		    sbHtml.append("      </div>");  
		    sbHtml.append("   </div>");
		    sbHtml.append("</td>");
		}
		
	}
	if(myboard_lists.size()%3!=0){
	   	//System.out.println("myboard_lists.size() :" + myboard_lists.size());
	   	if(myboard_lists.size()<3){
	   		for(int i = 1; i<=(3-myboard_lists.size()); i++ ){
				//System.out.println("<td></td>");
				sbHtml.append("<td width=200 height=200></td>");
			}
	   	}else {
	   		for(int i = 1; i<=(3-(myboard_lists.size()%3)); i++ ){
				//System.out.println("<td></td>");
				sbHtml.append("<td width=200></td>");
			}
	   	}	
	}
	int insight_flag = 0;
	
	
   // 24시간동안 데이터 받기 TodayCounts
	   ArrayList<TodayTO> today_counts = (ArrayList)request.getAttribute("today_count");
	   //게시글 데이터 count check
	   if(today_counts.size()==0){
		   insight_flag =1;
	   } else {
		 	//null값 정리
			if(today_counts.get(0).getTime() == 0){
				today_counts.remove(0);
			}
	   }
   //weekcount ArrayList로 받아오기
	   ArrayList<WeekTO> week_counts = (ArrayList)request.getAttribute("week_count");
	   //게시글 데이터 count check
	   if(week_counts.size()==0){
		   insight_flag =1;
	   } else {
		// null값 정리
		   if(week_counts.get(0).getTime()==0){
		      week_counts.remove(0);
		   }
	   }
   //기준 Arraylist 생성 --> today
	   ArrayList<TodayTO> blank_count_today = new ArrayList();
	   for (int i = 1; i<=8; i++){
	      TodayTO to = new TodayTO();
	      to.setAction_count(0);
	      to.setComment_count(0);
	      to.setHit_count(0);
	      if(i==7 || i ==8){
	         to.setTime(3*i);
	         blank_count_today.add(to);
	      } else {
	         to.setTime((3*i) -1); 
	         blank_count_today.add(to);
	      }
	   }
   // 기존 Arraylist 만들기 week
	   ArrayList<WeekTO> blank_count_week = new ArrayList();
	   for(int i=1; i<=7;i++){
	      WeekTO to1 = new WeekTO();
	      to1.setComment_count(0);
	      to1.setHit_count(0);
	      to1.setLike_count(0);
	      to1.setTime(i);
	      blank_count_week.add(to1);
	   }
	   
	   
   if(myboard_lists.size()!=0){
	   // 받아온 데이터 수정 --> today
	   for (int i = 0; i<=7; i++){
	      //System.out.println(blank_count_today.get(0).getTime()+" : " +blank_count_today.get(1).getTime()+" : " +blank_count_today.get(2).getTime()+" : " +blank_count_today.get(3).getTime()+" : " +blank_count_today.get(4).getTime()+" : " +blank_count_today.get(5).getTime()+" : " +blank_count_today.get(6).getTime());
	      for(TodayTO to : today_counts){
	         if(i == 6 || i==7){
	            if(to.getTime() == (3*i +3)){
	               blank_count_today.remove(i);
	               blank_count_today.add(i,to);
	               //System.out.println("index :"+i+"|| to.getTime() :"+ (3*i +3));
	               break;
	            }
	         	}else {
	            	if(to.getTime()== (3*i+2)){
	               		blank_count_today.remove(i);
	               		blank_count_today.add(i,to);
	               		//System.out.println("index :"+i+"|| to.getTime() :"+ ((3*i)+2));
	               		break;
	            	}
	         	}
	   		}
		}
		// 받아온 데이터 교체해주기 --> week
		for (int i =0; i<7; i++){
			for(WeekTO to : week_counts){
	            if(to.getTime()==i+1){
					blank_count_week.remove(i);
	               	blank_count_week.add(i,to);
	               	//System.out.println(to.getHit_count() + "시작" + i);
					break;
	            }
			}      
		}
	}
   
   // 순서 바꿈
   Collections.reverse(blank_count_today);
   //highchart양식 준비
   ArrayList<Integer> today_action = new ArrayList();
   ArrayList<Integer> today_hit = new ArrayList();
   ArrayList<Integer> today_comment = new ArrayList();
   ArrayList<Integer> today_like = new ArrayList();
   ArrayList<String> today_time = new ArrayList();
   for(TodayTO to : blank_count_today){
      today_hit.add(to.getHit_count());
      today_like.add(to.getLike_count());
      today_comment.add(to.getComment_count());
      today_time.add("\""+to.getTime() + "시간 전("+(LocalDateTime.now().minusHours(to.getTime())).toString().substring(11,16)+")\"");
      today_action.add(to.getHit_count() + to.getComment_count() + to.getLike_count());
   }
         
	      
   
   
   // 출력 될 list 생성
   ArrayList<Integer> week_action = new ArrayList();
   ArrayList<Integer> week_hit = new ArrayList();
   ArrayList<Integer> week_comment = new ArrayList();
   ArrayList<Integer> week_like = new ArrayList();
   ArrayList<String> week_time = new ArrayList();
   
   
   // 순서 바꿈
   Collections.reverse(blank_count_week);
   // 각각의 Arraylist에 입력
   for (WeekTO to1 : blank_count_week){
      week_hit.add(to1.getHit_count());
      week_comment.add(to1.getComment_count());
      week_like.add(to1.getLike_count());
	  week_action.add(to1.getHit_count()+ to1.getComment_count()+to1.getLike_count());
	  week_time.add("\""+Integer.toString(to1.getTime())+ "일 전 ("+(LocalDateTime.now().minusDays(to1.getTime())).toString().substring(5,10)+")\"" );
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
<script src="http://code.highcharts.com/highcharts.js"></script>

<!-- 드롭다운 리스트 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>

<!-- 글쓰기 Summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<style>
.button1{
	float: right;
	margin-right: 0px;
	width: 30px;
	font-size: 20px;

}
.button2{
	float: right;
	margin-right: 30px;
	width: 30px;
	font-size: 20px;
}
.button3{
	float: right;
	width: 30px;
	font-size: 20px;
}

.box {
    width: 250px;
    height: 250px; 
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

#wrapTable3 {
	height :150px;
	width : 650px;
	
}
#vertical3 {
		width: max-content;
		overflow-y: auto;
		height : 300px;
}
.mypage{
	padding-left: 50px;
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

#modifymodal1 {width: 650px;}
	
.filebox label { display: inline-block; padding: .5em .75em; color: #999; font-size: inherit; line-height: normal; vertical-align: middle; background-color: #fdfdfd; cursor: pointer; border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; }
.filebox input[type="file"] { /* 파일 필드 숨기기 */ position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; }

.insight-modal {
   z-index : 13;
}
.insight-modal:hover {
   opacity: 0.5;
}
</style>

<script>
	$(document).ready(function(){	
		$('.board1').click(function(e){
			$('.view-content').load("./view.do?seq=" + $(this).attr('bseq'));
		});
		
		$(".write_button").on('click', function(){
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
		
		$("#modify_userInfo").click(function(){
		  	// seq=뒤에 1 대신 받아온 값 넣어야 함.
			$('.modify-content').load("./mypage_modify.do?seq="+<%=visit_seq%>);

		});
		
		for(var i = 0; i <=<%=changeRow%>; i++){
			$('#insight-modal'+i).click(function(e){
				$('.insight-content').load("./insight.do?bseq=" + $(this).attr('bseq')+"&changeRow="+i);
			});
		}
		
		$('#insightmodal').on('hidden.bs.modal', function(){
			location.reload();
		});
});
</script>
<style type="text/css">	
	#main{
		font-family: 'Noto Serif KR', serif;
	}
	#view-modal{
		font-family: 'Noto Serif KR', serif;
	}
	
	#modifymodal1 {width: 650px;}
	
	.filebox label { display: inline-block; padding: .5em .75em; color: #999; font-size: inherit; line-height: normal; vertical-align: middle; background-color: #fdfdfd; cursor: pointer; border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; }
	.filebox input[type="file"] { /* 파일 필드 숨기기 */ position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; }

	.user_keyword {background-color:black; color:white; border-radius: 20px; padding: 3px 5px 3px 5px; backgroud-color:}
</style>

</head>
<body style="overflow-y:scroll;">

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
			<button style="width:100%" id="write_button" type="button" class="btn btn-outline-light write_button">글쓰기</button>
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
		
	    <div id="content"  style="padding-top : 100px;" align="center">
		    <div style="width:90%; height:450px; border-radius: 60px; background-color:#EAEAEA;" ><!-- #FFFAFA; -->
		    <table style="padding : 10px;" >
			    <tr height="50">
			    	<td align="right">
			    	<div style="padding-top:25px;">
			    		<span>
			    		<%if (mypage_flag == 1) { %>
			    			<button id="modify_userInfo" data-bs-toggle="modal" data-bs-target="#modifymodal" type="button" class="btn btn-dark" >수정하기</button>
		    			<%} else{%>
		    				<button style="visibility:hidden;">수정하기</button>
		    			<%}%>
		    			</span>
		    		</div>
			    	</td>
			    </tr>
			    <tr height="350px">
			    	<td colspan="2">
			    	<div style="width:1400px">
			    		<table align="center">
			    			<tr >
			    				<td width=18%>
				    				<div class="box">
				    					<img class="profile" alt="프로필 없음" src="./profile/<%=visit_profile_filename%>">
				    				</div>
			    				</td>
			    				<td width=42%>
			    					<div class="profile_info"> 별명 : <b><%=visit_nickname %></b></div>
			    					<div class="profile_info" style="height:100px; overflow-y:auto;"> 소개 : <b><%=visit_introduction %></b></div>
			    					<!-- <div class="profile_info"> 태그 : <%= visit_keywords %></div> -->
			    					<!-- <div class="profile_info"> 태그 : <%=kwdarray[0] %>을(를) 좋아하는 <%=kwdarray[1] %> <%=kwdarray[2] %></div> -->
			    					<div class="profile_info">
			    						 태그 : 
			    						<span class="user_keyword"><%=kwdarray[0] %></span>
										<%if (kwdarray[0].equals("과학") || kwdarray[0].equals("사진") || kwdarray[0].equals("소설") || kwdarray[0].equals("여행") || kwdarray[0].equals("자기 개발") || kwdarray[0].equals("패션")) {%>
										   <span id="kwdconnect">을 좋아하는 </span>
										<%} else {%>
										   <span id="kwdconnect">를 좋아하는 </span>
										<%}%>
			    						<span class="user_keyword"><%=kwdarray[1] %></span>
			    						<span class="user_keyword"><%=kwdarray[2] %></span>
			    					</div>
			    					<div class="profile_info"> 총 게시글 : <%=request.getAttribute("board_counts") %>개</div>
			    				</td>
			    				<td width=40%>
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
			    		</div>
			    	</td>
			    </tr>
	        	
	        </table>
            </div>
<br><hr><br>
           <div style="width:85%">
         <%if (mypage_flag == 1) { %>
         <div id='chart-so-high'>
            <div style="margin-bottom:50px;" align="left">
               <h2>전체 게시글 인사이트</h2>
            </div>
            <div>
               <div class="d-inline-block" align="left" style="padding-right:630px;">
                  <div class="btn-group">
                    <button type="button" class="btn btn-outline-secondary catalogue" value="action">액션</button>
                    <button type="button" class="btn btn-outline-secondary catalogue" value="hit">조회수</button>
                    <button type="button" class="btn btn-outline-secondary catalogue" value="like">좋아요</button>
                    <button type="button" class="btn btn-outline-secondary catalogue" value="comment">댓글</button>
                  </div>
               </div>
               <div class="d-inline-block" align="right" style="padding-left:500px;">
                    <select class="form-select btn-outline-secondary"  aria-label="Default select example">
					<option value="day">일주일 조회</option>
					<option value="time">하루 조회(24시간)</option>
					</select>
              </div>
            </div>
            <div align="left" style="padding:10px 0px 0px 35px">
               <h6 style="color:gray; font-size:10px;">액션은 '조회수','좋아요','댓글'를 합친 횟수입니다.</h6>
            </div>
             <div align="center">
                <div id="container1" style="width: 100%; height: 600px; margin: 0 auto;" align="center";></div>
             </div>
          </div>
          <br><br><hr><br><br>
<script>

   let catalogue = "action";
   let timecontrol = "day";

   // 하이차트 실행 함수
   function highChartFunc() {
      
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
   
      if(timecontrol== "time"){
         xAxis = {categories: <%=today_time%>};
         if(catalogue == "action"){
            title = {text: "액션 별 모아보기"};
            series =  [
                {
                   name: '"액션" for 24h',
                   data: <%=today_action%>
                }
             ];
         } else if (catalogue == "hit"){
            title = {text: "조회수 별 모아보기"};
            series =  [
                {
                   name: '"조회수" for 24h',
                   data: <%=today_hit%>
                }
             ];
         } else if (catalogue == "like"){
            title = {text: "좋아요 별 모아보기"};
            series =  [
                {
                   name: '"좋아요" for 24h',
                   data: <%=today_like%>
                }
             ];
         } else if(catalogue == "comment"){
            title = {text: "댓글 별 모아보기"};
            series =  [
                {
                   name: '"댓글" for 24h',
                   data: <%=today_comment%>
                }
             ];
         }
      } else {
         xAxis = {categories: <%=week_time%>};
         if(catalogue == "action"){
            title = {text: "액션 별 모아보기"};
            series =  [
                {
                   name: '"액션" for a week',
                   data: <%=week_action%>
                }
             ];
         } else if (catalogue == "hit"){
            title = {text: "조회수 별 모아보기"};
            series =  [
                {
                   name: '"조회수" for a week',
                   data: <%=week_hit%>
                }
             ];
         } else if (catalogue == "like"){
            title = {text: "좋아요 별 모아보기"};
            series =  [
                {
                   name: '"좋아요" for a week',
                   data: <%=week_like%>
                }
             ];
         } else if(catalogue == "comment"){
            title = {text: "댓글 별 모아보기"};
            series =  [
                {
                   name: '"댓글" for a week',
                   data: <%=week_comment%>
                }
             ];
         }
      }
         
      json.title = title;
      json.subtitle = subtitle;
      json.xAxis = xAxis;
      json.yAxis = yAxis;
      json.tooltip = tooltip;
      json.legend = legend;
      json.series = series;
      
      $('#container1').highcharts(json);
   }
     
// 마이페지이 로드 시, 차트 로딩
$(document).ready(function() {
   highChartFunc();
});

//액션,조회수,좋아요,댓글 클릭 시
$(function() {
   $(document).on("click",".catalogue",function(){
      catalogue = $(this).attr("value");
      highChartFunc();
   });
});
// 시간 구분 클릭 시, default 
$(function() {
   $(document).on("change",".form-select",function(){
               timecontrol =$(this).val();
               highChartFunc();
            });
         });
</script>
          <%} %>    
	        
	        </div>
	    </div>
	</div>

<!-- 모달창 정보 -->
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
<div id="insightmodal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog modal-xl modal-dialog-centered">
	<div class="modal-content insight-content"></div>
</div>
</div>

</body>
</html>