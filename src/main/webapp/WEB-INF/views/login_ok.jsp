<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if(flag == 1){
		out.println("alert('로그인에 성공했습니다.');");
		out.println("location.href='./home.do';");
	} else if(flag == 0){
		out.println("alert('비밀번호가 잘못되었습니다.');");
		out.println("history.back();");
	} else {
		out.println("alert('아이디를 확인해주세요.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
%>