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
   	int flag = lto.getFlag();
   	
   	out.println("<script type='text/javascript'>");
   	if (flag == 1) {
   		out.println("alert('로그인에 성공했습니다.');");
   		// 로그인 생성시 세션 생성
   		//session.setAttribute("userID", request.getParameter("userID"));
   		session.setAttribute("userInfo", lto.getUto());
   		//out.println("location.href='./home.do';");
   		out.println("history.go(-2);");
   	} else if (flag == 0) {
   		out.println("alert('비밀번호가 잘못되었습니다.');");
   		out.println("history.back();");
   	} else {
   		out.println("alert('아이디를 확인해주세요.');");
   		out.println("history.back();");
   	}
   	out.println("</script>");
 %>