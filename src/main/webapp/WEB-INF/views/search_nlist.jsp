<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.exam.boardlist.BoardDAO" %>
<%@ page import="com.exam.boardlist.BoardTO" %>
<%@ page import="com.exam.boardlist.BoardPagingTO" %>
<%@ page import="java.util.ArrayList" %>

<%
	//tpage처리하려고..
	BoardPagingTO slpagingTO = (BoardPagingTO)request.getAttribute( "slpagingTO" );
	int tpage = slpagingTO.getCpage();
	
	//ArrayList<BoardTO> lists = (ArrayList)request.getAttribute( "lists" );
	BoardPagingTO snlpagingTO = (BoardPagingTO)request.getAttribute( "snlpagingTO" );

	int npage = snlpagingTO.getCpage();
	
	//BoardDAO dao = new BoardDAO();
	//pagingTO = dao.boardList(pagingTO);

	int nrecordPerPage = snlpagingTO.getRecordPerPage();
	int ntotalRecode = snlpagingTO.getTotalRecord();
	
	int ntotalPage = snlpagingTO.getTotalPage();
	
	int nblockPerPage = snlpagingTO.getBlockPerPage();
	
	int nstartBlock = snlpagingTO.getStartBlock();
	int nendBlock = snlpagingTO.getEndBlock();
	
	ArrayList<BoardTO> lists = snlpagingTO.getBoardList();

	
	String searchword = (String)request.getAttribute("searchword");
	
	StringBuffer sbHtml = new StringBuffer();
	
	int cnt = 0;
	if(lists != null){
		for( BoardTO to : lists ) {
			cnt++;
			String nseq = to.getSeq();
			String ndate = to.getDate();
			String ntitle = to.getTitle();
			String nuseq = to.getUseq();
			String nfilename = to.getFilename();
			String nfilesize = to.getFilesize();
			String ncontent = to.getContent();
			String nbseq = to.getBseq();
			String nhit = to.getHit();
			String ncomment = to.getComment();
			
			// 수정하기 ★★★
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
			
			if(nfilename == null) {
				sbHtml.append("<td class='board'  width=250px height=250px>");
				// 사진 크기 250 250
				sbHtml.append("	<div class='img'>");
				sbHtml.append("	</div>");
				sbHtml.append("	<div class='text'>");
				sbHtml.append("	</div>");
				sbHtml.append("</td>");

			} else {
				sbHtml.append("<td class='board'>");
				// 사진 크기 250 250
				sbHtml.append("	<div class='img'>");
				sbHtml.append("		<a href='board_view.do'><img src='./upload/"+nfilename+"' border='0' width=250px height=250px/></a>");
				sbHtml.append("	</div>");
				sbHtml.append("	<div class='text'>");
				//sbHtml.append("		<a href='board_view.jsp'><p>"+title+"</p></a>");
				sbHtml.append("		<a href='board_view.jsp'>"+ntitle+"</a>");
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
			sbHtml.append("<td align='center'><img src='./images/no_result.jpg' /></td>");
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
	if(npage == 1) {
		out.println("<span class='off'><a>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
	} else {
		//out.println("<span class='off'><a href='./list.do?cpage="+(startBlock-blockPerPage)+"'>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
		out.println("<span class='off'><a href='./search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+1+"'>&lt;처음&gt;</a>&nbsp;&nbsp;</span>");
	}

	// < 표시 설정
	if (npage == 1) {
		out.println("<span class='off'><a>&lt;이전&gt;</a>&nbsp;&nbsp;</span>");
	} else {
		out.println("<span class='off'><a href='./search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+(npage-1)+"'>&lt;이전&gt;</a>&nbsp;&nbsp;</span>");
	}

	
	for(int i=nstartBlock; i<=nendBlock; i++) {
		
		if(npage == i) {
			// 현재 페이지
			out.println("<span class='on'><a>( "+i+" )</a></span>");
		} else {
			out.println("<span class='off'><a href='./search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+i+"'>"+i+"</a></span>");
		}
	}

	// > 표시 설정
	if (npage == ntotalPage) {
		out.println("<span class='off'>&nbsp;&nbsp;<a>&lt;다음&gt;</a></span>");
	} else {
		out.println("<span class='off'>&nbsp;&nbsp;<a href='./search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+(npage+1)+"'>&lt;다음&gt;</a></span>");
	}

	// >> 표시 설정
	//if(endBlock == totalPage) {
	if(npage == ntotalPage) {
		out.println("<span class='off'>&nbsp;&nbsp;<a>&lt;끝&gt;</a></span>");
	} else {
		//out.println("<span class='off'>&nbsp;&nbsp;<a href='list.do?cpage="+(startBlock+blockPerPage)+"'>&lt;끝&gt;</a></span>");
		out.println("<span class='off'>&nbsp;&nbsp;<a href='search_list.do?active=tab2&searchword="+searchword+"&tpage="+tpage+"&npage="+ntotalPage+"'>&lt;끝&gt;</a></span>");
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
		
