<%@page import="com.exam.user.UserTO"%>
<%@page import="com.exam.theseMonthBoard.Home_BoardTO"%>
<%@page import="com.exam.boardlist.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 현재 세션 상태를 체크한다
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	}
	

	ArrayList<Home_BoardTO> theseBoards = (ArrayList)request.getAttribute("lists");
	
	Home_BoardTO to1 = theseBoards.get(0);
	String seq1 = to1.getSeq();
	String title1 = to1.getTitle();
	String date1 = to1.getDate();
	String bseq1 = to1.getBseq();
	String nickname1 = to1.getNickname();
	String filename1 = to1.getFilename();
	
	Home_BoardTO to2 = theseBoards.get(1);
	String seq2 = to2.getSeq();
	String title2 = to2.getTitle();
	String date2 = to2.getDate();
	String bseq2 = to2.getBseq();
	String nickname2 = to2.getNickname();
	String filename2 = to2.getFilename();
	
	Home_BoardTO to3 = theseBoards.get(2);
	String seq3 = to3.getSeq();
	String title3 = to3.getTitle();
	String date3 = to3.getDate();
	String bseq3 = to3.getBseq();
	String nickname3 = to3.getNickname();
	String filename3 = to3.getFilename();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책갈피</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<!-- <style>#content {position: absolute; left: 50%; transform: translateX(-50%);}</style>  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<!-- sidebar -->

<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>
<!-- home -->
<link rel="stylesheet" type="text/css" href="./css/home.css">

<script type="text/javascript">
	$(document).ready(function(){
		for ( let i = 1; i <=3; i++){
		    $("#modal-link"+i).click(function(){
		        var seq = $("#modal-link"+i+" #board_seq").val().split("/");
		        $('.modal-content').load("./view.do" + "?seq=" + seq[0]);   
		    });
		}
    });
	
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
	        <span><a class="navbar-brand" href="./home.do"> <img src="./images/logo.png" alt="logo" style="width: 200px;"></a></span>
	        <% if(userInfo == null){ %>
	        <span><a href="./login.do">시작하기</a></span>
	        <% }else{ %>
	        <span><a href="./logout_ok.do">로그아웃</a></span>
	        <% } %>
			<span><a href="./search.do"><i class="fa fa-search" aria-hidden="true"></i></a></span>		
    	</p>
    </div>

	<div id="content">
		<div class="intro_brunch">
			<h3 class="tit_brunch" style="padding-left : 30px">생각을 보고, 나눔에 감동하다. 책갈피
					<span class="ico_brunch ico_logo"></span>
			</h3>
			<br>
			<p class="desc_brunch" style="padding-left : 30px">
				<span class="part">책에 대한 감성과 느낌을 담아<br></span>
				<span class="part">책갈피에 넣어두세요.<br></span>
				<span class="part">
					<span class="txt_brunch">나눔 속 당신의 마음을 울림을 위한, 당신의 책갈피. </span>
				</span>
			</p>

			<div class="editor_pic">
				<div class="wrap_slide">
					<ul class="list_slide">
						<li>
							<div class="wrap_pic PC_DISCOVER_BRUNCHBOOK  ">
								<div class="item_pic item_pic_type1 #home_discover_brunchbook">
									<a>
										<span class="fade_cover1"></span> 
										<span class="book_cover" >
											<!-- 위치조정시 left 값으로 조절 -->
											<div class="cont_cover" style="background-color:rgba(255,255,255,0); color:white">
												<strong class="tit_cover">당신을 위한<br>이 달의<br>게시글<br></strong>
												<span class="txt_writer">bookmark 개발 일동</span>
											</div> 
							
											<span class="dimmed_cover"></span>
									</span> <span class="info_release"> <span class="inner-info">
												<span class="txt_g">for bookmarker</span> <span
												class="txt_g">Released date.Mar.10.2021</span>
										</span>
									</span>
									</a>
								</div>

								<div class="item_pic item_pic_type4 ">														
									<a id="modal-link1" data-bs-toggle="modal" data-bs-target="#modal" class="link_item #home_discover" > 
										<input type="hidden" id="board_seq" value=<%=seq1 %>/>
										<!--  hover동작 class(위에 link_item #home_discover)  -->
										<img
										src="./upload/<%= filename1%>"
										class="img_pic" alt="<%= title1%>">
										<div class="append_info">
											<div class="info_g">
												<div class="inner_g" style="padding-left : 10px;padding-right : 10px; padding-top : 180px;">
													<em class="cate_pic"></em> 
													<strong class="tit_pic"><%= title1%></strong> 
													<span class="txt_pic">&quot;</span> 
														<span class="info_by"><span class="ico_by">by</span>&nbsp;<%= nickname1 %></span>
												</div>
											</div>
											<div class="align_g"></div>
										</div>
										<div class="mask"></div>
									</a>
								</div>

								<div class="item_pic item_pic_type2">
									<a id="modal-link2" data-bs-toggle="modal" data-bs-target="#modal" class="link_item #home_discover">
									<input type="hidden" id="board_seq" value=<%=seq2 %>/>
									<img src="./upload/<%=filename2 %>"
										class="img_pic" alt="<%=title2%>" >
										
										<div class="append_info">
											<div class="info_g">
												<div class="inner_g">
													<em class="cate_pic"></em> <strong class="tit_pic" style="padding-left : 20px ;padding-right : 20px;"><%=title2%></strong> 
													<span class="txt_pic"></span> <span class="info_by"><span
														class="ico_brunch ico_by">by</span> <%= nickname2 %></span>
												</div>
											</div>
											<div class="align_g"></div>
										</div>

										<div class="mask"></div>
									</a>
								</div>

								<div class="item_pic item_pic_type3">
									<a id="modal-link3" data-bs-toggle="modal" data-bs-target="#modal" class="link_item #home_discover" > 
									<input type="hidden" id="board_seq" value=<%=seq3 %>/>
									<img
										src="./upload/<%=filename3 %>"
										class="img_pic" alt="">

										<div class="append_info">
											<div class="info_g">
												<div class="inner_g">
													<em class="cate_pic"></em> <strong class="tit_pic" style="padding-left : 20px ;padding-right : 20px;"><%=title3%></strong> 
													<span class="txt_pic"></span> <span class="info_by"><span
														class="ico_brunch ico_by">by</span> <%= nickname3 %></span>
												</div>
											</div>
											<div class="align_g"></div>
										</div>
										<div class="mask"></div>
									</a>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="brunch_writers">
			<h3 align='center'>Developer &nbsp;for BOOK MARK </h3><!-- class="txt_brunch" -->
			<p>
				<span ><h5 align='center'>책갈피 개발자들</h5></span> <!-- class="txt_brunch" -->
			</p>
			<div class="wrap_writers">
				<ul class="list_writers list_writers_group writer_52">
					<li><a class="link_writers #home_writers "> 
						<img
							src="./images/profile_Yechan.png"
							width="80" height="80" class="img_brunch thumb_img"
							alt="Adela"> <strong
							class="tit_wirter">정예찬</strong> 
							<span class="team_writer">코딩하는 기획자</span>
							<span class="txt_wirter">이래 봬도 팀장</span>
					</a>
						<div class="writer_keyword_wrap keyword_inside_wrap">
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								>코딩</button>
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="재테크">PM</button>
							<button type="button"
							class="keyword_item brunch_keyword_item_button #home_writers_keywords"
							data-keyword="재테크">독서</button>
							
						</div>
					</li>
					<li><a class="link_writers #home_writers "> 
						<img
							src="./images/profile_Dahye.jpg"
							width="80" height="80" class="img_brunch thumb_img"
							alt="Adela"> <strong
							class="tit_wirter">박다혜</strong> 
							<span class="team_writer">외모만큼 뇌도 섹시한 개발자</span>
							<span class="txt_wirter">그게 나! 박.다.혜</span>
					</a>
						<div class="writer_keyword_wrap keyword_inside_wrap">
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="직장">개발</button>
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="재테크">IT</button>
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="재테크">Java</button>
						</div>
					</li>
					<li><a class="link_writers #home_writers "> 
						<img
							src="./images/profile_JIwon.jpg"
							width="80" height="80" class="img_brunch thumb_img"
							alt="Adela"> <strong
							class="tit_wirter">박지원</strong> 
							<span class="team_writer">꿈꾸는 개발자</span>
							<span class="txt_wirter">성악하는 애독가</span>
					</a>
						<div class="writer_keyword_wrap keyword_inside_wrap">
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="직장">코딩</button>
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="재테크">성악</button>
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="재테크">독서</button>
						</div>
					</li>
					<li  style="padding-left:15px"><a class="link_writers #home_writers "> 
						<img
							src="./images/profile_Minji.jpg"
							width="80" height="80" class="img_brunch thumb_img"
							alt="Adela"> <strong
							class="tit_wirter">손민지</strong> 
							<span class="team_writer">꼬북좌? 으으응~~</span>
							<span class="txt_wirter">민지띠가 더 귀엽띠? </span>
					</a>
						<div class="writer_keyword_wrap keyword_inside_wrap">
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="직장">코딩</button>
							<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="재테크">Analysis</button>
								<button type="button"
								class="keyword_item brunch_keyword_item_button #home_writers_keywords"
								data-keyword="재테크">IT</button>
							
						</div>
					</li>
					
				</ul>
			</div>
   			<!-- 모달창 정보 -->
             <div id="modal" class="modal fade" tabindex="-1">
                <div class="modal-dialog modal-dialog modal-xl modal-dialog-centered">
                   <div class="modal-content">
                   
                   </div>
                </div>
             </div>
		</div>
	</div>	
</div>
</body>
</html>