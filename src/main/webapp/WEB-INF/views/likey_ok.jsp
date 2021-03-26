<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	int flag_like = (Integer)request.getAttribute("flag_like");
 	
 	out.println("<script type='text/javascript'>");
 	if (flag_like == 1) {
 		out.println("alert('성공')");
 	} else if (flag_like == 0) {
 		out.println("alert('좋아요 입력 실패')");
 	} else {
 		out.println("alert('알수없는 오류가 발생하였습니다.');");
 	}
 	out.println("</script>");
 %>