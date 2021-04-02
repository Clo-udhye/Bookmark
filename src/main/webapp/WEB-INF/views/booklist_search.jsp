<%@page import="com.exam.booklist.BookTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<BookTO> booklist = (ArrayList)request.getAttribute("booklist");
	//System.out.println(booklist.size());
	StringBuffer result = new StringBuffer();
	result.append("<result>");
	for(BookTO to : booklist){			
		result.append("<book>");
		result.append("<seq>"+ to.getMaster_seq() +"</seq>");
		result.append("<isbn13>"+ to.getIsbn13() +"</isbn13>");
		
		to.setTitle(to.getTitle().replaceAll("<", "&lt;"));
		to.setTitle(to.getTitle().replaceAll(">", "&gt;"));
		to.setTitle(to.getTitle().replaceAll("&", "&amp;"));
		result.append("<title>"+ to.getTitle()+"</title>");
		
		to.setAuthor(to.getAuthor().replaceAll("<", "&lt;"));
		to.setAuthor(to.getAuthor().replaceAll(">", "&gt;"));
		to.setAuthor(to.getAuthor().replaceAll("&", "&amp;"));
		result.append("<author>"+ to.getAuthor() +"</author>");
		
		to.setPublisher(to.getPublisher().replaceAll("<", "&lt;"));
		to.setPublisher(to.getPublisher().replaceAll(">", "&gt;"));
		to.setPublisher(to.getPublisher().replaceAll("&", "&amp;"));
		result.append("<publisher>"+ to.getPublisher() +"</publisher>");
		
		String description = to.getDescription();
		if(description.length() > 20){
			description = description.substring(0,17)+"...";
		}
		description = description.replaceAll("<", "&lt;");
		description = description.replaceAll(">", "&gt;");
		description = description.replaceAll("&", "&amp;");
		result.append("<description>"+ description +"</description>");
		
		to.setImg_url(to.getImg_url().replaceAll("&", "&amp;"));
		result.append("<img_url>"+ to.getImg_url() +"</img_url>");
		result.append("</book>");
	}
	result.append("</result>");
	
	out.println(result);
%>