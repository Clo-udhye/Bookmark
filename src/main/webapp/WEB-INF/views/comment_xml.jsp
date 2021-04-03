<%@page import="com.exam.theseMonthBoard.Board_CommentTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	ArrayList<Board_CommentTO> comment_lists = (ArrayList)request.getAttribute("board_commentTO");
	StringBuffer comment_html = new StringBuffer();
	comment_html.append("<result>");
	for(Board_CommentTO comment_list : comment_lists ){
		comment_html.append("<comment>");
		comment_html.append("<seq>" +comment_list.getSeq() +"</seq>");
		comment_html.append("<useq>" +comment_list.getUseq() +"</useq>");
		comment_html.append("<nickname>" +comment_list.getNickname() +"</nickname>");
		comment_html.append("<profile>" +comment_list.getFilename() +"</profile>");
		comment_html.append("<content>" +comment_list.getContent() +"</content>");
		comment_html.append("<date_time>" +comment_list.getDate_time() +"</date_time>");
		comment_html.append("</comment>");
	}
	comment_html.append("</result>");
	out.println(comment_html);
%>