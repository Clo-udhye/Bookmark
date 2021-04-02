<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int likey_count = (Integer)request.getAttribute("likey_count");
	int like_count_check = (Integer)request.getAttribute("like_count_check");
		
	StringBuffer likey_count_html = new StringBuffer();
	likey_count_html.append("<results>");
	likey_count_html.append("<result>");
	likey_count_html.append(likey_count);
	likey_count_html.append("</result>");
	likey_count_html.append("<resultcheck>"+like_count_check+"</resultcheck>");
	likey_count_html.append("</results>");
	out.println(likey_count_html);
%>