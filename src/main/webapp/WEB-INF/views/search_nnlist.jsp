<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.exam.boardlist.BoardDAO" %>
<%@ page import="com.exam.boardlist.BoardTO" %>
<%@ page import="com.exam.boardlist.BoardPagingTO" %>
<%@ page import="com.exam.boardlist.JoinBLUTO" %>
<%@ page import="java.util.ArrayList" %>

<%
	//tpage처리하려고..
	BoardPagingTO slpagingTO = (BoardPagingTO)request.getAttribute( "slpagingTO" );
	int tpage = slpagingTO.getCpage();
	
	//ArrayList<BoardTO> lists = (ArrayList)request.getAttribute( "lists" );
	BoardPagingTO snnlpagingTO = (BoardPagingTO)request.getAttribute( "snnlpagingTO" );

	int npage = snnlpagingTO.getCpage();
	
	//BoardDAO dao = new BoardDAO();
	//pagingTO = dao.boardList(pagingTO);

	int nrecordPerPage = snnlpagingTO.getRecordPerPage();
	int ntotalRecode = snnlpagingTO.getTotalRecord();
	
	int ntotalPage = snnlpagingTO.getTotalPage();
	
	int nblockPerPage = snnlpagingTO.getBlockPerPage();
	
	int nstartBlock = snnlpagingTO.getStartBlock();
	int nendBlock = snnlpagingTO.getEndBlock();
	
	ArrayList<JoinBLUTO> lists = snnlpagingTO.getJoinbluList();

	
	String searchword = (String)request.getAttribute("searchword");
	
	StringBuffer sbHtml = new StringBuffer();
	
	// keywords가 null인 경우도 있으니 kwdarray 선언 먼저 해줘야 빈 리스트 레이아웃 출력시 에러 안 나.
	String[] kwdarray = new String[3];
	
	int cnt = 0;
	if(lists != null){
		for( JoinBLUTO to : lists ) {
			// useq, id, nickname, mail, keywords, introduction, profile_filename, sum(Lcount) Lcount, count(bnltable.useq) Bcount 가져오기.
			cnt++;
			String useq = to.getUseq();
			String id = to.getId();
			String nickname = to.getNickname();
			String mail = to.getMail();
			String keywords = to.getKeywords();
			if (keywords != null) {
				kwdarray = keywords.split("//");
			}
			// introduction이 길수도 있으니 잘라야할듯 ★★★
			String introduction = to.getIntroduction();
			String profile_filename = to.getProfile_filename();
			String Lcount = to.getLcount();
			if(Lcount == null) {
				Lcount = "0";
			}
			String Bcount = to.getBcount();
			
			// 한 줄에 나오는 수 변경
			if(cnt % 2 == 1) {
				sbHtml.append("</tr>");
				sbHtml.append("<tr>");
			}
		
			// 수정하기 ★★★
			if(nickname == null) {
			//if(keywords == null) {
				sbHtml.append("<td class='userboard'>");
				sbHtml.append("	<div class='userprofile0'>");
				sbHtml.append("		<div class='user_img'></div>");
				sbHtml.append("		<div class='user_nickname'></div>");
				sbHtml.append("		<div class='user_keywords'></div>");
				sbHtml.append("		<div class='user_intro'></div>");	
				sbHtml.append("		<div class='user_count'></div>");				
				sbHtml.append("	</div>");
				sbHtml.append("</td>");

				
			} else {
				// nickname에 맞는 페이지로 이동하게 td에 링크 걸기! 수정하기 ★★
				sbHtml.append("<td class='userboard' useq="+useq+">");
				sbHtml.append("	<table class='userprofile'>");
				sbHtml.append("		<tr>");
				sbHtml.append("			<td rowspan='4' width=150px>");
				sbHtml.append("				<div class='user_img' align='center'>");
				sbHtml.append("					<a><img src='./profile/"+profile_filename+"' border='0' width=80px height=80px/></a>");
				sbHtml.append("				</div>");				
				sbHtml.append("			</td>");
				sbHtml.append("			<td>");
				//sbHtml.append("				<div class='user_nickname' align='center'>");
				sbHtml.append("				<div class='user_nickname'>");
				sbHtml.append("					<a>"+nickname+"</a>");
				sbHtml.append("				</div>");				
				sbHtml.append("			</td>");				
				sbHtml.append("		</tr>");				
				sbHtml.append("		<tr>");
				sbHtml.append("			<td>");
				// keywords
				sbHtml.append("				<div class='user_keywords'>");
				sbHtml.append("					<span class='user_keyword'>"+kwdarray[0]+"</span>");
				if (kwdarray[0].equals("과학") || kwdarray[0].equals("사진") || kwdarray[0].equals("소설") || kwdarray[0].equals("여행") || kwdarray[0].equals("자기 개발") || kwdarray[0].equals("패션")) {
				   sbHtml.append("               <span id='kwdconnect'>을 좋아하는 </span>");
				} else {
				   sbHtml.append("               <span id='kwdconnect'>를 좋아하는 </span>");
				}
				sbHtml.append("					<span class='user_keyword'>"+kwdarray[1]+"</span>");
				sbHtml.append("					<span class='user_keyword'>"+kwdarray[2]+"</span>");
				sbHtml.append("				</div>");				
				sbHtml.append("			</td>");				
				sbHtml.append("		</tr>");				
				sbHtml.append("		<tr>");
				sbHtml.append("			<td>");
				//sbHtml.append("				<div class='user_intro' align='center'>");
				// 소개 부분 div 사이즈 고정 
				sbHtml.append("				<div class='user_intro' style='width:490px; height:47px; overflow-x:hidden; overflow-y:hidden;'>");
				//sbHtml.append("					<a>"+introduction+"</a>");
				sbHtml.append(					introduction);
				sbHtml.append("				</div>");						
				sbHtml.append("			</td>");				
				sbHtml.append("		</tr>");	
				sbHtml.append("		<tr>");
				sbHtml.append("			<td>");
				//sbHtml.append("				<div class='user_count' align='center'>");
				sbHtml.append("				<div class='user_count'>");
				sbHtml.append("					<span> 글 수 "+Bcount+" | 좋아요 수 "+Lcount+" </span>");
				sbHtml.append("				</div>");				
				sbHtml.append("			</td>");				
				sbHtml.append("		</tr>");					
				sbHtml.append("	</table>");
				sbHtml.append("</td>");				
			}		
		}
		//System.out.println(lists==null);
		if(lists.size()==0) {
			//sbHtml.append("<h1>검색결과없음</h1>");
			sbHtml.append("<td align='center'><img src='./images/no_result.jpg' width=1348px/></td>");
		}
	}
	
%>
<script type="text/javascript">
$(document).ready(function (e){
	$(".userboard").on("click", function(e){
		location.href='mypage.do?useq='+$(this).attr("useq");
	});
	
});
</script>

<style type="text/css">
	.userboard {padding-top: 10px; padding-right: 10px; padding-bottom: 10px; padding-left: 10px;}
	.userprofile {background-color: white; width: 655px; height: 180px;}
	.userprofile0 {width: 655px; height: 180px;}
	.userprofile a {text-decoration: none;}
	.user_img img {border-radius: 50%;}
	.user_img {padding-top: 15px; padding-bottom: 5px;}
	.user_nickname a {font: 18px verdana; color: #000;}
	.user_nickname {padding-top: 2px; padding-bottom: 0px;}
	.user_intro a {color: #000;}
	.user_intro {padding-bottom: 5px;}
	.user_count {font: 14px verdana; color: gray;}
	.user_keywords {padding-bottom: 10px;}
	.user_keyword {border: 1px solid gray; border-radius: 20px; padding: 3px 3px 3px 3px; font: 13px verdana;}
	#kwdconnect {font: 11px verdana; color: gray;}
</style>

<!-- 키워드
사용자profile마다 padding 여백
profile부분 회색 배경하고 사이즈 조절
profile부분 nickname이 null이면 회색배경이 아니라 그냥 흰배경의 td들이 나머지 칸에 채워져야해서 따로 처리함
profile의 모든 링크는 데코없이.
img 원형으로 나오게 처리
img 위치 조절
nickname에 링크 걸어놓은 a부분 밑줄파란색 없게 처리하고 글씨 크기 조절
nickname 위치 조절
intro 글자색 검은색
intro 위치 조절
count 글자색 회색
keyword 위치 조절
각 keyword마다 동그라미
keyword 연결하는 문구 글자 크기, 글자색 
-->

        <!-- ■■ 내가 추가한 부분 ■■ -->
        <!-- 게시판 -->
	    <table class="board_list">
			<tr>
				<%= sbHtml %>
			</tr>
		</table>
		<!--//게시판-->
		
		<!-- 작가 리스트 레이아웃 -->
		<!--  
		<table>
			<tr>
				<td class='userboard'>
					<table class='userprofile'>
						<tr >
							<td rowspan="4">
								<div class='user_img' align="center">
									<a href='list.do'><img src='./profile/profile11.JPG' border='0' width=80px height=80px/></a>
								</div>								
							</td>
							<td>
								<div class='user_nickname' align="center">
									<a href='list.do'>사용자1</a>
								</div>							
							</td>
						</tr>
						<tr>
							<td>
								<div class='user_intro' align="center">
									<a href='list.do'>안녕하세요. 반갑습니다^^</a>
								</div>							
							</td>
						</tr>
						<tr>
							<td>
								<div class='user_count' align="center">
									<span>글 수 1 | 좋아요 수 0 </span>
								</div>							
							</td>
						</tr>
						<tr>
							<td>
								<div class='user_keywords' align="center">
									<span>키워드</span>&nbsp;
									<span>입력해</span>&nbsp;
									<span>주세요</span>&nbsp;
								</div>							
							</td>
						</tr>
																								
					</table>
				</td>			
				<td class='userboard'>
					<div class='userprofile'>
						<div class='user_img' align="center">
							<a href='list.do'><img src='./profile/profile11.JPG' border='0' width=80px height=80px/></a>
						</div>
						<div class='user_nickname' align="center">
							<a href='list.do'>사용자1</a>
						</div>
						<div class='user_intro' align="center">
							<a href='list.do'>안녕하세요. 반갑습니다^^</a>
						</div>
						<div class='user_count' align="center">
							<span>글 수 1 | 좋아요 수 0 </span>
						</div>
						<div class='user_keywords' align="center">
							<span>키워드</span>&nbsp;
							<span>입력해</span>&nbsp;
							<span>주세요</span>&nbsp;
						</div>
					</div>
				</td>
				<td class='userboard'>
					<div class='userprofile'>
						<div class='user_img' align="center">

							<a href='list.do'><img src='./profile/profile11.JPG' border='0' width=80px height=80px/></a>
						</div>
						<div class='user_nickname' align="center">
							<a href='list.do'>사용자1</a>
						</div>
						<div class='user_keywords' align="center">
							<span>키워드</span>&nbsp;
							<span>입력해</span>&nbsp;
							<span>주세요</span>&nbsp;
						</div>
					</div>
				</td>
			</tr>
		</table>
		-->
		
        <!--페이지넘버-->
		<div class="paginate_regular">
			<div class="board_pagetab">
<%
	// << 표시 설정
	//if(startBlock == 1) {
	if(npage == 1) {
		out.println("<span class='off'><a style='color:gray;'>처음</a>&nbsp;&nbsp;</span>");
	} else {
		//out.println("<span class='off'><a href='./list.do?cpage="+(startBlock-blockPerPage)+"'>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
		out.println("<span class='off'><a href='./search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+1+"'>처음</a>&nbsp;&nbsp;</span>");
	}

	// < 표시 설정
	if (npage == 1) {
		out.println("<span class='off'><a style='color:gray;'>이전</a>&nbsp;&nbsp;</span>");
	} else {
		out.println("<span class='off'><a href='./search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+(npage-1)+"' >이전</a>&nbsp;&nbsp;</span>");
	}

	
	for(int i=nstartBlock; i<=nendBlock; i++) {
		
		if(npage == i) {
			// 현재 페이지
			out.println("<span class='on'><a style='color:black;'>[ "+i+" ]</a></span>");
		} else {
			out.println("<span class='off'><a href='./search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+i+"'>"+i+"</a></span>");
		}
	}

	// > 표시 설정
	if (npage == ntotalPage) {
		out.println("<span class='off'>&nbsp;&nbsp;<a style='color:gray;'>다음</a></span>");
	} else {
		out.println("<span class='off'>&nbsp;&nbsp;<a href='./search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+(npage+1)+"''>다음</a></span>");
	}

	// >> 표시 설정
	//if(endBlock == totalPage) {
	if(npage == ntotalPage) {
		out.println("<span class='off'>&nbsp;&nbsp;<a style='color:gray;'>끝</a></span>");
	} else {
		//out.println("<span class='off'>&nbsp;&nbsp;<a href='list.do?cpage="+(startBlock+blockPerPage)+"'>&lt;끝&gt;</a></span>");
		out.println("<span class='off'>&nbsp;&nbsp;<a href='search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+ntotalPage+"'>끝</a></span>");
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
		
