<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 현재 세션 상태를 체크한다
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	}
	// 이미 로그인했으면 다시 로그인을 할 수 없게 한다
	if (userInfo != null) {
		out.println("<script type='text/javascript'>");
		out.println("alert('이미 로그인이 되어 있습니다')");
		out.println("location.href='./home.do'");
		out.println("</script>");
	}
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>

<script type="text/javascript">
	window.onload = function(){
		document.getElementById('login').onclick = function(){
			if(document.login_frm.userID.value.trim()==''){
				alert('아이디를 입력하셔야합니다.');
				return false;
			}
			if(document.login_frm.userPassword.value.trim()==''){
				alert('비밀번호를 입력하셔야합니다.');
				return false;
			}
			
			// 아이디 정규표현식, 영어소문자 숫자만 가능, 6~16자
			const regexp = /^[a-z0-9]{6,16}$/;
			if(!regexp.test(document.login_frm.userID.value.trim())){
				alert('아이디는 6자이상 16자 이하의 영어소문자, 숫자로 이루어져 있습니다.');
				return false;
			}
			document.login_frm.submit();
		};
	};
</script>

</head>
<body>

	<div id="mySidebar" class="sidebar">
		<div class="sidebar-header">
			<h3>당신의 책갈피</h3>
		</div>
	
		<%if (userInfo != null) {%>
			<p><%=userInfo.getNickname()%>님이 로그인 중 입니다.</p>
		<%} else {%>
			<p>로그인해주세요.</p>
		<%}%>
		<a href="./home.do">Home</a>
			<%if(userInfo != null){
			if(userInfo.getId().equals("testadmin1")) {%>
				<a href="./admin.do">Admin Page</a>
			<%} else{ %>
				<a href="./mypage.do">My Page</a>
			<%}
		}%>
		<a href="./list.do">모든 게시글 보기</a>
		<a href="./book_list.do">책 구경하기</a>
	</div>

	<div id="main">
		<div id="header">
			<p>
				<span>
					<button class="sidebar-btn" onclick="sidebarCollapse()">
						<span><i class="fa fa-bars" aria-hidden="true"></i></span>
		             </button>
				</span>
		        <span><a class="navbar-brand" href="./home.do"><img src="./images/logo.png" alt="logo" style="width: 100px;"></a></span>
		        <span><a href="./login.do">시작하기</a></span>
				<span><a href="./search.do"><i class="fa fa-search" aria-hidden="true"></i></a></span>		
	    	</p>
	    </div>

		<div id="content">
			<!-- 로그인 양식 -->
			<div class="container">
				<!-- 하나의 영역 생성 -->
				<div class="col-lg-4">
					<!-- 영역 크기 -->
					<!-- 점보트론은 특정 컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
					<div class="jumbotron" style="padding-top: 20px;">
						<form method="post" action="./login_ok.do" name="login_frm">
							<h3 style="text-align: center;">로그인 화면</h3>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
							</div>
							<div class="form-group">
								<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
							</div>
							<input type="button" class="btn btn-dark form-control" value="로그인" id="login">
							<input type="button" class="btn btn-dark" value="회원가입" onclick="location.href='./signup.do'" />
							<input type="button" class="btn btn-dark" value="카카오로그인" onclick="location.href='#'" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>