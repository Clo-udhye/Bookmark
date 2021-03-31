<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserTO userInfo = (UserTO)request.getAttribute("userInfo");	
	
	if(userInfo!=null) {
		session.setAttribute("userInfo", userInfo);
	} else{
		out.println("alert('네이버 로그인에 실패 하였습니다.')");
	}
	
	//System.out.println("네이버로 로그인 성공");
	out.println("<script type='text/javascript'>");
	out.println("opener.location.href = opener.document.referrer;"); 
	out.println("window.close()");
	out.println("</script>");

%>