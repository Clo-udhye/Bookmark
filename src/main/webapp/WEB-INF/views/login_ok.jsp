<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.exam.user.UserTO"%>
<%@page import="com.exam.user.LoginTO"%>
 
<%
 	// 현재 세션 상태를 체크한다
 	UserTO userInfo = null;
   	if (session.getAttribute("userInfo") != null) {
   		userInfo = (UserTO)session.getAttribute("userInfo");
   	}
   	// 이미 로그인했으면 다시 로그인을 할 수 없게 한다
   	if (userInfo != null) {
   		out.println("<script type='text/javascript'>");
   		out.println("alert('이미 로그인이 되어 있습니다')");
   		//out.println("location.href='./home.do'");
   		out.println("history.go(-2);");
   		out.println("</script>");
   	}

   	LoginTO lto = (LoginTO)request.getAttribute("lto");
   	
	StringBuffer result = new StringBuffer();
	
	//System.out.println("flag : " + lto.getFlag());
	
	result.append("<flag>");
	result.append(lto.getFlag());
	result.append("</flag>");

	if(lto.getFlag() == 1){
		session.setAttribute("userInfo", lto.getUto());
	}
	
	out.println(result);
 %>