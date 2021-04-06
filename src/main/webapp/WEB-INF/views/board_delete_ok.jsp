<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.exam.user.UserTO"%>
<%@page import="com.exam.user.LoginTO"%>
 
<%
 	// 현재 세션 상태를 체크한다
 	UserTO userInfo = null;
   	if (session.getAttribute("userInfo") != null) {
   		userInfo = (UserTO)session.getAttribute("userInfo");
   		// 관리자 혹은 작성자만 삭제 가능
   		/*
   		if(!userInfo.getId().equals("testadmin1")){
   			out.println("<script type='text/javascript'>");
   	   		out.println("alert('관리자만 접근 가능합니다.')");
   	   		//out.println("location.href='./home.do'");
   	   		out.println("history.back();");
   	   		out.println("</script>");
   		}
   		*/
   	}

   	int flag = (Integer)request.getAttribute("flag");
   	
   	out.println("<script type='text/javascript'>");
   	if (flag == 1) {
   		out.println("alert('게시글 삭제에 성공했습니다.');");
   		out.println("location.href='./admin.do';");
   	} else {
   		out.println("alert('게시글 삭제에 실패했습니다.');");
   		out.println("location.href='./admin.do';");
   	}
   	out.println("</script>");
 %>