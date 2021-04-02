<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.File" %>
 
<%
	int flag = (int)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 1){
		out.println("alert('글쓰기에 성공했습니다.');");
		out.println("history.back();");
	} else {
		out.println("alert('[Error] : 글쓰기에 실패했습니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
%>
