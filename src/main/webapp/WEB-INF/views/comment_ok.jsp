<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	int flag = (Integer)request.getAttribute("flag");
 	
 	out.println("<script type='text/javascript'>");
 	if (flag == 1) {
 		out.println("history.back()");
 	} else if (flag == 0) {
 		out.println("alert('댓글 입력 실패')");
 		out.println("history.back();");
 	} else {
 		out.println("alert('알수없는 오류가 발생하였습니다.');");
 		out.println("history.back();");
 	}
 	out.println("</script>");
 %>