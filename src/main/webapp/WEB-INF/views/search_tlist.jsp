<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.exam.boardlist.BoardDAO" %>
<%@ page import="com.exam.boardlist.JoinBULCTO" %>
<%@ page import="com.exam.boardlist.BoardPagingTO" %>
<%@ page import="java.util.ArrayList" %>

<%

	
	//npage처리하려고..
	BoardPagingTO snlpagingTO = (BoardPagingTO)request.getAttribute( "snnlpagingTO" );
	int npage = snlpagingTO.getCpage();

	
	//ArrayList<BoardTO> lists = (ArrayList)request.getAttribute( "lists" );
	BoardPagingTO slpagingTO = (BoardPagingTO)request.getAttribute( "slpagingTO" );

	int tpage = slpagingTO.getCpage();
	
	//BoardDAO dao = new BoardDAO();
	//pagingTO = dao.boardList(pagingTO);

	int recordPerPage = slpagingTO.getRecordPerPage();
	int totalRecode = slpagingTO.getTotalRecord();
	
	int totalPage = slpagingTO.getTotalPage();
	
	int blockPerPage = slpagingTO.getBlockPerPage();
	
	int startBlock = slpagingTO.getStartBlock();
	int endBlock = slpagingTO.getEndBlock();
	
	ArrayList<JoinBULCTO> lists = slpagingTO.getJoinbulcList();
	//ArrayList<BoardTO> lists = slpagingTO.getBoardList();

	
	String searchword = (String)request.getAttribute("searchword");
	

	StringBuffer sbHtml = new StringBuffer();
	
	//seq, date, filename, title, useq, nickname, Lcount, Ccount 
	int cnt = 0;
	if(lists != null){
		for( JoinBULCTO to : lists ) {
			cnt++;
			String seq = to.getSeq();
			String date = to.getDate();
			String filename = to.getFilename();
			String title = to.getTitle();
			// title 처리랑, css에 text width 설정함.
			if (title != null && title.length() > 25) {
				title = title.substring(0, 24)+"...";
			}
			String useq = to.getUseq();
			String nickname = to.getNickname();
			String Lcount = to.getLcount();
			String Ccount = to.getCcount();
			
			if(cnt % 5 == 1) {
				sbHtml.append("</tr>");
				sbHtml.append("<tr>");
			}
		
			/* 완성코드
			sbHtml.append("<td class='board'>");
			// 사진 크기 250 250
			sbHtml.append("	<div class='img'>");
			sbHtml.append("		<a href='board_view.do'><img src='./upload/"+filename+"' border='0' width=250px height=250px/></a>");
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

			} else {
				sbHtml.append("<td class='board board1' bseq='"+seq+"' data-bs-toggle='modal' data-bs-target='#view-modal'>");
				// 사진 크기 250 250
				sbHtml.append("	<div class='img'>");
				sbHtml.append("		<a><img src='./upload/"+filename+"' border='0' width=250px height=250px/></a>");
				sbHtml.append("	</div>");
				sbHtml.append("	<div class='text'>");

				//sbHtml.append("		<a href='board_view.jsp'><p>"+title+"</p></a>");
				sbHtml.append("		<div id='text_title'><p>"+title+"</p></div>");
				sbHtml.append("		<div id='text_nickname'><p>by "+nickname+"</p></div>");
				sbHtml.append("		</br>");
				//sbHtml.append("		<span id='text_likey'><i class='fas fa-heart'></i>"+Lcount+"</span>");
				sbHtml.append("		<div id='text_count' align='right'>");
				sbHtml.append("			<span id='text_likey'><i class='fas fa-heart'></i>&nbsp;"+Lcount+"</span>");
				sbHtml.append("			&nbsp;");
				sbHtml.append("			<span id='text_comment'><i class='fas fa-comment-dots'></i>&nbsp;"+Ccount+"</span>");
				sbHtml.append("		</div>");
				
				
				sbHtml.append("	</div>");
				sbHtml.append("</td>");
			}
				
			/* 완성된 코드 ★★★
			sbHtml.append("<td class='board'>");
			// 사진 크기 250 250
			sbHtml.append("					<a href='board_view.jsp'><img src='./upload/"+filename+"' border='0' width=250px height=250px/></a>");
			sbHtml.append("</td>");
			*/
						
			
		
		}	
		//System.out.println(lists==null);
		if(lists.size()==0) {
			//sbHtml.append("<h1>검색결과없음</h1>");
			sbHtml.append("<td align='center'><img src='./images/no_result.jpg' width=1348px/></td>");
		}
	}
%>

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
				if(tpage == 1) {
					out.println("<span class='off'><a>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
				} else {
					//out.println("<span class='off'><a href='./list.do?cpage="+(startBlock-blockPerPage)+"'>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
					out.println("<span class='off'><a href='./search_list.do?active=tab1&searchword="+searchword+"&tpage="+1+"&npage="+npage+"'>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
				}
			
				// < 표시 설정
				if (tpage == 1) {
					out.println("<span class='off'><a>&lt;이전&gt;</a>&nbsp;&nbsp;</span>");
				} else {
					out.println("<span class='off'><a href='./search_list.do?active=tab1&searchword="+searchword+"&tpage="+(tpage-1)+"&npage="+npage+"'>&lt;이전&gt;</a>&nbsp;&nbsp;</span>");
				}
			
				
				for(int i=startBlock; i<=endBlock; i++) {
					
					if(tpage == i) {
						// 현재 페이지
						out.println("<span class='on'><a>( "+i+" )</a></span>");
					} else {
						out.println("<span class='off'><a href='./search_list.do?active=tab1&searchword="+searchword+"&tpage="+i+"&npage="+npage+"'>"+i+"</a></span>");
					}
				}
			
				// > 표시 설정
				if (tpage == totalPage) {
					out.println("<span class='off'>&nbsp;&nbsp;<a>&lt;다음&gt;</a></span>");
				} else {
					out.println("<span class='off'>&nbsp;&nbsp;<a href='./search_list.do?active=tab1&searchword="+searchword+"&tpage="+(tpage+1)+"&npage="+npage+"'>&lt;다음&gt;</a></span>");
				}
			
				// >> 표시 설정
				//if(endBlock == totalPage) {
				if(tpage == totalPage) {
					out.println("<span class='off'>&nbsp;&nbsp;<a>&lt;끝&gt;</a></span>");
				} else {
					//out.println("<span class='off'>&nbsp;&nbsp;<a href='list.do?cpage="+(startBlock+blockPerPage)+"'>&lt;끝&gt;</a></span>");
					out.println("<span class='off'>&nbsp;&nbsp;<a href='search_list.do?active=tab1&searchword="+searchword+"&tpage="+totalPage+"&npage="+npage+"'>&lt;끝&gt;</a></span>");
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
		
