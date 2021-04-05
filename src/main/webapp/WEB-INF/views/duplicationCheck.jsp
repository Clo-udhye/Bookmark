<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");

	StringBuffer result = new StringBuffer();
	
	result.append("<flag>");
	result.append(flag);
	result.append("</flag>");
	
	out.println(result);
%>