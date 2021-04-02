<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.File" %>
 
<%
   String uploadPath = "C:/Java/project-workspace/Project_Bookmark/src/main/webapp/profile";
   int maxFileSize = 1024 *1024 * 2; 
   String encType = "utf-8";
   
   MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
   
   //System.out.println(multi.getParameter("title"));
   System.out.println(multi.getParameter("seq"));
   //System.out.println(multi.getParameter("summernote"));
   //System.out.println(multi.getParameter("bookseq"));
   //System.out.println(multi.getFilesystemName("filename[]"));
   %>