<%@page import="com.exam.theseMonthBoard.Home_BoardTO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	StringBuffer board_html = new StringBuffer();
 	int flag = (Integer)request.getAttribute("flag");
 	if(flag == 1){
 		Home_BoardTO to = (Home_BoardTO)request.getAttribute("home_BoardTO");
 		board_html.append("<board>");
 		board_html.append("<title>"+to.getTitle()+"</title>");
 		board_html.append("<content>"+to.getContent()+"</content>");
 		board_html.append("</board>");
 	}
 	
 	out.println(board_html);
 %>