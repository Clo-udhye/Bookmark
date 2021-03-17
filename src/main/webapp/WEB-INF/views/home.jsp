<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 현재 세션 상태를 체크한다
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
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
<link rel="stylesheet" type="text/css" href="./css/home.css">
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
	        <% if(userID == null){ %>
	        <span><a href="./login.do">시작하기</a></span>
	        <% }else{ %>
	        <span><a href="./logout_ok.do">로그아웃</a></span>
	        <% } %>
			<span><a href="./search.do"><i class="fa fa-search" aria-hidden="true"></i></a></span>		
    	</p>
    </div>

		<div id="content">
			<div class="intro_brunch">
				<h3 class="tit_brunch" style="padding-left : 30px">글이 작품이 되는 공간, 브런치
						<span class="ico_brunch ico_logo"></span>
					</h3>
					<p class="desc_brunch" style="padding-left : 30px">
						<span class="part">브런치에 담긴 아름다운 작품을 감상해 보세요.<br></span>
						<span class="part">그리고 다시 꺼내 보세요.<br></span>
						<span class="part">
							<span class="txt_brunch">서랍 속 간직하고 있는 글과 감성을.</span>
						</span>
					</p>

				<div class="editor_pic">
					<div class="wrap_slide">
						<ul class="list_slide">
							<li>
								<div class="wrap_pic PC_DISCOVER_BRUNCHBOOK  ">
									<div class="item_pic item_pic_type1 #home_discover_brunchbook">
										<a href="/brunchbook/notinpmbok" class="link_item #new"
											target="_blank" data-tiara-action-name="TOP > 추천 콘텐츠 영역 클릭"
											data-tiara-action-kind="ClickContent"
											data-tiara-layer="recommended_article"
											data-tiara-click_url="/brunchbook/notinpmbok"
											data-tiara-setnum="1" data-tiara-copy="PMBOK에 안 나오는 PM이야기">
											<span class="fade_cover1"></span> <span class="book_cover"
											style="background-image: url('//img1.daumcdn.net/thumb/C460x648.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/bsgr/image/auzhIMfeSCpDg-kGZ-G8_XHs8FI.bmp')">
												<!-- 위치조정시 left 값으로 조절 -->
												<div class="cont_cover">
													<strong class="tit_cover">PMBOK에<br>안 나오는<br>PM이야기<br></strong>
													<span class="txt_writer">김진서</span>
												</div> <span class="dimmed_book_type1"></span> <span
												class="txt_publisher">brunch book</span> <span
												class="dimmed_cover"></span>
										</span> <span class="info_release"> <span class="inner-info">
													<span class="txt_g">First Edition</span> <span
													class="txt_g">Released date.Mar.10.2021</span>
											</span>
										</span>
										</a>
									</div>

									<div class="item_pic item_pic_type4 ">

										<a href="/@@beV7/151" class="link_item #home_discover"
											target="_blank" data-tiara-action-name="TOP > 추천 콘텐츠 영역 클릭"
											data-tiara-action-kind="ClickContent"
											data-tiara-layer="recommended_article"
											data-tiara-click_url="/@@beV7/151" data-tiara-setnum="4"
											data-tiara-copy="오늘 아들이 '좋아 죽겠는' 일"> <img
											src="//img1.daumcdn.net/thumb/C320x520.fjpg/?fname=https://t1.daumcdn.net/section/oc/065573462a4c47c293c8a388f8aca76c"
											class="img_pic" alt="오늘 아들이 '좋아<br>죽겠는' 일<br>">

											<div class="append_info">
												<div class="info_g">
													<div class="inner_g">
														<em class="cate_pic"></em> <strong class="tit_pic">오늘
															아들이 '좋아<br>죽겠는' 일<br>
														</strong> <span class="txt_pic">&quot;엄마, 너무 기대돼!&quot; 좀처럼<br>감정을
															숨길 줄 모르는 아들 녀...
														</span> <span class="info_by"><span class="ico_by">by</span>
															그루잠</span>
													</div>
												</div>
												<div class="align_g"></div>
											</div>
											<div class="mask"></div>
										</a>
									</div>

									<div class="item_pic item_pic_type2">
										<a href="/@@bFF5/99" class="link_item #home_discover"
											target="_blank" data-tiara-action-name="TOP > 추천 콘텐츠 영역 클릭"
											data-tiara-action-kind="ClickContent"
											data-tiara-layer="recommended_article"
											data-tiara-click_url="/@@bFF5/99" data-tiara-setnum="2"
											data-tiara-copy="내던져진 양말에서 사랑을 느끼다."> <img
											src="//img1.daumcdn.net/thumb/C480x260.fjpg/?fname=https://t1.daumcdn.net/section/oc/9c91885e50e34f9c83c4d21a0899a623"
											class="img_pic" alt="내던져진 양말에서<br>사랑을 느끼다.<br>">

											<div class="append_info">
												<div class="info_g">
													<div class="inner_g">
														<em class="cate_pic"></em> <strong class="tit_pic">내던져진
															양말에서<br>사랑을 느끼다.<br>
														</strong> <span class="txt_pic"></span> <span class="info_by"><span
															class="ico_brunch ico_by">by</span> 강하영</span>
													</div>
												</div>
												<div class="align_g"></div>
											</div>

											<div class="mask"></div>
										</a>
									</div>

									<div class="item_pic item_pic_type3">
										<a href="/@@7PKh/451" class="link_item #home_discover"
											target="_blank" data-tiara-action-name="TOP > 추천 콘텐츠 영역 클릭"
											data-tiara-action-kind="ClickContent"
											data-tiara-layer="recommended_article"
											data-tiara-click_url="/@@7PKh/451" data-tiara-setnum="3"
											data-tiara-copy="나는 파이어족을 꿈꾸지 않는다"> <img
											src="//img1.daumcdn.net/thumb/C480x260.fjpg/?fname=https://t1.daumcdn.net/section/oc/91ba1c2acffd47ee88a0b9ea1a1a2d58"
											class="img_pic" alt="나는 파이어족을<br>꿈꾸지 않는다<br>">

											<div class="append_info">
												<div class="info_g">
													<div class="inner_g">
														<em class="cate_pic"></em> <strong class="tit_pic">나는
															파이어족을<br>꿈꾸지 않는다<br>
														</strong> <span class="txt_pic"></span> <span class="info_by"><span
															class="ico_brunch ico_by">by</span> 물고기자리</span>
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
				<h3 class="txt_brunch tit_brunch">B R U N C H &nbsp; W R I T E
					R S</h3>
				<p class="desc_brunch">
					<span class="txt_brunch">브런치 추천 작가</span>
				</p>
				<div class="wrap_writers">
					<ul class="list_writers list_writers_group writer_52">
						<li><a href="/@adelahan" target="_blank"
							class="link_writers #home_writers "> 
							<img
								src="//img1.daumcdn.net/thumb/C120x120.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/3sM2/image/aonbqXyog3Mmb141qCHug9yZpIs.jpg"
								width="80" height="80" class="img_brunch thumb_img"
								alt="Adela"> <strong
								class="tit_wirter">정예찬</strong> 
								<span class="team_writer">KIC</span>
								<span class="txt_wirter">정예찬 입니다.</span>
						</a>
							<div class="writer_keyword_wrap keyword_inside_wrap">
								<button type="button"
									class="keyword_item brunch_keyword_item_button #home_writers_keywords"
									data-keyword="직장">직장</button>
								<button type="button"
									class="keyword_item brunch_keyword_item_button #home_writers_keywords"
									data-keyword="재테크">재테크</button>
								<button type="button"
									class="ico_brunch ico_more keyword_item brunch_keyword_item_more_button #home_writers_keywords"
									data-url="/@adelahan">더보기</button>
							</div>
						</li>
						<li><a href="/@adelahan" target="_blank"
							class="link_writers #home_writers "> 
							<img
								src="//img1.daumcdn.net/thumb/C120x120.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/3sM2/image/aonbqXyog3Mmb141qCHug9yZpIs.jpg"
								width="80" height="80" class="img_brunch thumb_img"
								alt="Adela"> <strong
								class="tit_wirter">정예찬</strong> 
								<span class="team_writer">KIC</span>
								<span class="txt_wirter">정예찬 입니다.</span>
						</a>
							<div class="writer_keyword_wrap keyword_inside_wrap">
								<button type="button"
									class="keyword_item brunch_keyword_item_button #home_writers_keywords"
									data-keyword="직장">직장</button>
								<button type="button"
									class="keyword_item brunch_keyword_item_button #home_writers_keywords"
									data-keyword="재테크">재테크</button>
								<button type="button"
									class="ico_brunch ico_more keyword_item brunch_keyword_item_more_button #home_writers_keywords"
									data-url="/@adelahan">더보기</button>
							</div>
						</li>
						<li><a href="/@adelahan" target="_blank"
							class="link_writers #home_writers "> 
							<img
								src="//img1.daumcdn.net/thumb/C120x120.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/3sM2/image/aonbqXyog3Mmb141qCHug9yZpIs.jpg"
								width="80" height="80" class="img_brunch thumb_img"
								alt="Adela"> <strong
								class="tit_wirter">정예찬</strong> 
								<span class="team_writer">KIC</span>
								<span class="txt_wirter">정예찬 입니다.</span>
						</a>
							<div class="writer_keyword_wrap keyword_inside_wrap">
								<button type="button"
									class="keyword_item brunch_keyword_item_button #home_writers_keywords"
									data-keyword="직장">직장</button>
								<button type="button"
									class="keyword_item brunch_keyword_item_button #home_writers_keywords"
									data-keyword="재테크">재테크</button>
								<button type="button"
									class="ico_brunch ico_more keyword_item brunch_keyword_item_more_button #home_writers_keywords"
									data-url="/@adelahan">더보기</button>
							</div>
						</li>
						<li  style="padding-left:15px"><a href="/@adelahan" target="_blank"
							class="link_writers #home_writers "> 
							<img
								src="//img1.daumcdn.net/thumb/C120x120.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/3sM2/image/aonbqXyog3Mmb141qCHug9yZpIs.jpg"
								width="80" height="80" class="img_brunch thumb_img"
								alt="Adela"> <strong
								class="tit_wirter">정예찬</strong> 
								<span class="team_writer">KIC</span>
								<span class="txt_wirter">정예찬 입니다.</span>
						</a>
							<div class="writer_keyword_wrap keyword_inside_wrap">
								<button type="button"
									class="keyword_item brunch_keyword_item_button #home_writers_keywords"
									data-keyword="직장">직장</button>
								<button type="button"
									class="keyword_item brunch_keyword_item_button #home_writers_keywords"
									data-keyword="재테크">재테크</button>
								<button type="button"
									class="ico_brunch ico_more keyword_item brunch_keyword_item_more_button #home_writers_keywords"
									data-url="/@adelahan">더보기</button>
							</div>
						</li>
						
					</ul>
				</div>
			</div>

		</div>
	</div>	
</body>


</body>
</html>