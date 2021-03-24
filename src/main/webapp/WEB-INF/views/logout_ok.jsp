<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//session.invalidate(); 	//세션 전체 삭제
	//session에 해당하는 이름을 매개변수로 넣어줘야 한다*/
	session.removeAttribute("userInfo");

	out.println("<script type='text/javascript'>");
	
	out.println("alert('로그아웃 되었습니다.');");
	out.println("location.href='./home.do';");
	
	out.println("</script>");
%>