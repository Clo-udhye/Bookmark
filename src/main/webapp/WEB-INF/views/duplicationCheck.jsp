<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.exam.user.UserDAO" %>
<%
	int flag = (int)request.getAttribute("flag");

	UserDAO dao = new UserDAO();
	StringBuffer result = new StringBuffer();
	
	result.append("<flag>");
	result.append(flag);
	result.append("</flag>");
	
	out.println(result);
%>