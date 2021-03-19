<%@page import="com.exam.theseMonthBoard.Home_BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Home_BoardTO to = (Home_BoardTO)request.getAttribute("home_BoardTO");
	String seq = to.getSeq();
	String date = to.getDate().substring(0, 11);
	String title = to.getTitle();
	String nickname = to.getNickname();
	String filename = to.getFilename();
	String content = to.getContent();
	String book_title = to.getBook_title();
	String comment = to.getComment();
	String hit = to.getHit();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책갈피</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
	#comment {
		width : 520;
		height : 100;
	}
	#vertical2 {
		width: max-content;
		overflow-y: scroll;
		height : 70px;
	}
	#vertical1 {
		width: max-content;
		overflow-y: scroll;
		height : 250px;
	}
	.wrap {
		float: left;
	}
	.wrapTable table {
		border : 1px;
	}
	.wrapTable tr,th,td {
		padding : 5px;
		margin : 5px;
	}
	#wrapTable tr:hover {
		background-color : ivory;
		font-color : black; 
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

</head>
<body>
<div id="main" width=100%>
    <div id="content">
       <table>
       	<tr>
       		<td rowspan="3" border="1"> <img src="./images/<%=filename %>" style="width : 500px; height : 500px;"/></td>
       		<td >
	       		<table width="620" height="50">
	       			<tr>
	       				<td width="150">작성자 : <%=nickname %></td>
	       				<td width="180">작성 일자 : <%= date %></td>
	       				<td width="100">조회수 : <%=hit %></td>
	       				<td rowspan="2">
	       				<table>
	       					<tr><td><input type="button" value="수정"/></td><td><input type="button" value="삭제"/></td></tr>
	       				</table>
	       				 	 
	       				</td >
	       				<td rowspan="2" align="top" width="30">
	       					<div align="right">
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" ></button></span>
						    </div>
	       				</td>
	       			</tr>
	       			<tr>
	       				<td colspan="3">책 제목 : <%=book_title %></td><td></td>
	       			</tr>
	       		</table>
       		</td>
       	</tr>
       	<tr>
       		<td>
       			<table width="600" height="350">
       				<tr height="250">
       					<td>
       						<div id="vertical1">
       							<div class="wrap"> 
       								<table border="1" height="250" width="580" class="wrapTable"> <tr><td>
       								<p><%=content %></p>
       								</td></tr></table>
       							</div>
       						</div>
   						</td>
       				</tr>
       				<tr>
       					<td>
       						<div id="vertical2">
       							<div class="wrap">
       								<table border="1" height="70" width="580" id="wrapTable">
			       						<tr>
			       							<td>user12</td><td>우와 멋져요! 소통해요!!!</td><td>2021/03/19</td>
			       						</tr>
			       						<tr>
			       							<td>user12</td><td>우와 멋져요! 소통해요!!!</td><td>2021/03/19</td>
			       						</tr>
			       						<tr>
			       							<td>user12</td><td>우와 멋져요! 소통해요!!!</td><td>2021/03/19</td>
			       						</tr>
			       						<tr>
			       							<td>user12</td><td>우와 멋져요! 소통해요!!!</td><td>2021/03/19</td>
			       						</tr>
			       						<tr>
			       							<td>user12</td><td>우와 멋져요! 소통해요!!!</td><td>2021/03/19</td>
			       						</tr>
			       						
		       						</table>
       							</div>
       						</div>
       					</td>
       				</tr>
       			</table>
       		</td>
       	</tr>
       	<tr>
       	<td>
       		<table height="100" width="600" border="1">
       			<tr> <td width="80"> <input type="button" value="like"/></td><td width="120"> 좋아요 x <%=hit %>개</td><td width="200"></td><td width="100"></td></tr>
       			<tr>
	       			<form>
	       				<td colspan="3" width="520">
       						<input type="text" value="댓글을 입력하세요" size="60"/>
	       				</td>
	       				<td><input type="submit" value="등록하기" height="100"/></td>
	       			</form>
       			</tr>
       		</table>
       	</td>
       	</tr>
       
       </table>
    </div>
</div>

</body>
</html>