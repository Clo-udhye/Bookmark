<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   int flag = (Integer)request.getAttribute("flag");
   UserTO userInfo = (UserTO)request.getAttribute("userInfo");

   StringBuffer result = new StringBuffer();
   
   result.append("<flag>");
   result.append(flag);
   result.append("</flag>");
   
   session.setAttribute("userInfo",userInfo);
   
   out.println(result);
%>