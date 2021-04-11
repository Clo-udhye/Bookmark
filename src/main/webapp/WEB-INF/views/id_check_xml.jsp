<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int flag = 1;
	String user_id = "";
	
	if(request.getAttribute("id") !=null){
		flag = 0;
		user_id = (String)request.getAttribute("id");
	}

	StringBuffer html = new StringBuffer();
	html.append("<results>");
	html.append("<idsearch_flag>");
	html.append(flag);
	html.append("</idsearch_flag>");
	if(flag==0){
		html.append("<id>");
		html.append(user_id);
		html.append("</id>");
	}
	html.append("</results>");
	out.println(html);

%>