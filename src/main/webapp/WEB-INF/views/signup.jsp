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
	// 이미 로그인했으면 다시 회원가입을 할 수 없게 한다
	if (userInfo != null) {
		out.println("<script type='text/javascript'>");
		out.println("alert('이미 로그인이 되어 있습니다')");
		out.println("location.href='./home.do'");
		out.println("</script>");
	}
	
	String infoAgreement = "아래의 내용으로 개인정보를 수집, 이용 및 제공하는데 동의합니다.\n"
			+"□ 개인정보의 수집 및 이용에 관한 사항\n"
			+"- 수집하는 개인정보 항목 :\n" 
			+"  이메일, 주소\n"
			+"- 개인정보의 이용 목적 :\n" 
			+"  수집된 개인정보를 아이디, 비밀번호찾기의 용도로 활용하며,  목적 외의 용도로는 사용하지 않습니다.\n\n" 
			+"□ 개인정보의 보관 및 이용 기간\n"
			+"- 귀하의 개인정보를 다음과 같이 보관하며, 홈페이지 탈퇴시 삭제됩니다.";
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

<!-- 글쓰기 Summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<style>
  .button1{
	float: right;
	margin-right:0px;
	width: 30px;
	font-size: 20px;

}
.button2{
	float: right;
	margin-right: 50px;
	width: 30px;
	font-size: 20px;
}
.button3{
	float: right;
	width: 30px;
	font-size: 20px;
}

.jumbotron{
	width: 700px;
	height:800px;
	padding-top: 150px;
	padding-left: 450px;
	
}
form{
	width: 480px;
	height: 100px;
}
.text1{
padding-left: 100px;
}
.form-group{
	height: 60px;
	

}
.form-control
{
	float: left;
	width: 320px;
	height: 38px;
	
}
#id_check, #nickname_check, #modal-button{
	
	float: right;
	width: 110px;
	
}
#signup{
	width: 220px;
	text-font: center; 
	margin-top: 60px;
	margin-left: 100px;
}
   
</style>
<script type="text/javascript">
	$(document).ready(function(){
		//중복확인후 변경시 제출하지못하게 변경
		$('#userID').on('change', function() {
			$('#id_check_sucess').hide();
			$('#id_check').show();
			$('#userID').attr("check_result", "fail");
		});
		
		$('#nickname').on('change', function() {
			$('#nickname_check_sucess').hide();
			$('#nickname_check').show();
			$('#nickname').attr("check_result", "fail");
		});
		
		$(document).on('click', '#id_check', function(){
			// 아이디 정규표현식, 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.(네이버와 동일)
			const regexp = /^[a-z0-9-_]{5,20}$/;
			if(!regexp.test($('#userID').val().trim())){
				alert('아이디는 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.');
				
				$('#userID').focus();
			} else{
				//아이디 중복확인
				const request = new XMLHttpRequest();
				request.onreadystatechange = function(){
					if(request.readyState == 4){
						if(request.status == 200){
							const data = request.responseXML;
							const flags = data.getElementsByTagName('flag');
							let flag = flags[0].childNodes[0].nodeValue;
						
							if(flag == 0){
								alert("이미 존재하는 아이디 입니다.");
								$('#userID').focus();
								return false 
							} else{
								alert("사용가능한 아이디 입니다.");
								$('#userID').attr("check_result", "success");
								$('#id_check_sucess').show();
								$('#id_check').hide();
								return false;	          
							}
							
						} else{
							alert('[Error]');
						}
					}
				};
				request.open('GET', './duplicationCheck.do?item=id&value=' + document.signup_frm.userID.value.trim(), true);
				request.send();
			}
		});
		
		$(document).on('click', '#nickname_check', function(){
			// 별명 정규표현식, 한글 숫자만 가능, 2~12자
			const regexp2 = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|0-9a-zA-Z]{2,20}$/;
			if(!regexp2.test($('#nickname_check').val().trim())){
				alert('별명은 20자 이내의 영문, 한글, 숫자만 가능합니다.');
				$('#nickname').focus();
				
			} else{
				//별명 중복확인
				const request = new XMLHttpRequest();
				request.onreadystatechange = function(){
					if(request.readyState == 4){
						if(request.status == 200){
							const data = request.responseXML;
							const flags = data.getElementsByTagName('flag');
							let flag = flags[0].childNodes[0].nodeValue;
						
							if(flag == 0){
								alert("이미 존재하는 별명 입니다.");
								$('#nickname').focus();
								return false 
							} else{
								alert("사용가능한 별명 입니다.");
								$('#nickname').attr("check_result", "success");
								$('#nickname_check_sucess').show();
								$('#nickname_check').hide();
								return false;	          
							}
							
						} else{
							alert('[Error]');
						}
					}
				};
				request.open('GET', './duplicationCheck.do?item=nickname&value=' + document.signup_frm.nickname.value.trim(), true);
				request.send();
			}
		});
		
		$(document).on('click', '#signup', function(){
			if($('#userID').val().trim()==''){
				alert('아이디를 입력하셔야합니다.');
				$('#userID').focus();
				return false;
			}
			if($('#nickname').val().trim()==''){
				alert('별명을 입력하셔야합니다.');
				$('#nickname').focus();
				return false;
			}
			if($('#userPassword').val().trim()==''){
				alert('비밀번호를 입력하셔야합니다.');
				$('#userPassword').focus();
				return false;
			}
			if($('#userPasswordCheck').val().trim()==''){
				alert('비밀번호 확인을 입력하셔야합니다.');
				$('#userPasswordCheck').focus();
				return false;
			}			
			if($('#mail').val().trim()==''){
				alert('메일을 입력하셔야합니다.');
				$('#mail').focus();
				return false;
			}
			
			// 아이디, 별명 중복확인 버튼 눌렀는지 확인
			if ($('#userID').attr("check_result") == "fail"){
			    alert("아이디 중복체크를 해주시기 바랍니다.");
			    $('#userID').focus();
			    return false;
			 }
			if ($('#nickname').attr("check_result") == "fail"){
			    alert("별명 중복체크를 해주시기 바랍니다.");
			    $('#nickname').focus();
			    return false;
			  }
			// 비밀번호와 비밀번호확인이 동일한지 확인
			if($('#userPassword').val().trim()!=$('#userPasswordCheck').val().trim()){
				alert("비밀번호를 다시 확인해주세요");
			    $('#userPassword').focus();
			    return false;
			}
			
			if($('#agree').is(":checked")==false){
				alert('정보제공 동의를 해주세요.');
				return false;
			}
			
			document.signup_frm.submit();
		});

	  $("#modal-button").click(function(){
		  	const regexp2 = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|0-9]{2,12}$/;
			if(!regexp2.test($('#address').val().trim())){
				alert('동이름으로 검색해주세요');
				$('#address').val('');
			}		
			$('.address-content-content').load("./zipsearch.do?strDong="+$('#address').val());			
	  });
	  $("#write_button").on('click', function(){
			<%if(userInfo!=null){%>
				$("#write-modal").modal("show");
				$('.write-content').load("./write.do");
			<%}else{%>
				var comfirm_login = confirm("로그인이 필요한 서비스입니다. \n'확인'버튼을 클릭 시, 로그인 창으로 이동합니다.");
				if(comfirm_login==true){
					location.href="./login.do";
				}
			<%}%>	        	
		});
	});
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
			<a href="./mypage.do?useq=<%=userInfo.getSeq()%>" >My Page</a>
		<%}
	}%>
	<a href="./list.do">모든 게시글 보기</a>
	<a href="./book_list.do">책 구경하기</a>
	
	<div style="padding:8px; position:absolute; bottom:2%; width:100%">
		<button style="width:100%" id="write_button" type="button" class="btn btn-outline-light">글쓰기</button>
	</div>
</div>

<div id="main">
   <div id="header">
      <div>
			<table>
				<tr>
					<td width=5%><span>
						<button class="sidebar-btn" onclick="sidebarCollapse()">
							<span><i class="fa fa-bars" aria-hidden="true"></i></span>
			             </button>
					</span>
					</td>
					<td width=5%><span><a class="navbar-brand" href="./home.do"> <img src="./images/logo.png" alt="logo" style="width: 200px; height:50px; "></a></span></td>
					<% if(userInfo == null){ %>
						<td width=75% ><span><a class="button1" href="./login.do" id="start-button" style="color: black;">START</a></span></td>
	        		<% }else{ %>
	        			<td width=75% ><span><a class="button2" href="./logout_ok.do" id="logout-button" style="color: black;">LOGOUT</a></span></td>
	        		<% } %>
					<td width=5%><span><a class="button3" href="./search.do" style="color: black;"><i class="fa fa-search" aria-hidden="true"></i></a></span></td>
				</tr>
			</table>		
    	</div>
    </div>
    
    <div id="content" >
			<!-- 회원가입 양식 -->
			<div class="container">
				<!-- 하나의 영역 생성 -->
				<div>
					<!-- 영역 크기 -->
					<!-- 점보트론은 특정 컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
					<div class="jumbotron" >
						<form method="post" action="./signup_ok.do" name="signup_frm">
						<div style="height: 75px;">
						<img src="./images/login-image.png" alt="login-image" width="65px;" height="65px;" style="float: left;"/>
						<div class="text1" >
							<h3><b>책갈피 회원가입</b></h3>
							<p>아래의 양식에 맞게 입력해주십시오</p>
						</div>
						</div>
						
							<div class="form-group">
									<input type="text" class="form-control"  placeholder="아이디(*)" id="userID" name="userID" maxlength="20"  check_result="fail" required />							
								<div class="double-check" >
									<input type="button" class="btn btn-dark form-control" value="중복확인" id="id_check" >
									<i class="fa fa-check" id="id_check_sucess" style="display: none; padding-left: 30px;" aria-hidden="true" ></i>
									</input>
								</div>
							</div>	
								

							<div class="form-group">
									<input type="text" class="form-control" placeholder="별명(*)" id="nickname" name="nickname" maxlength="20"></input>
								
								<div class="nickname-button" >
									<input type="button" class="btn btn-dark form-control"  value="중복확인" id="nickname_check" />
									<i class="fa fa-check" id="nickname_check_sucess" style="display: none; padding-left: 30px;" aria-hidden="true" ></i>
									
								</div>
							</div>
							
							
							
							<div class="form-group" >
								<input type="password" class="form-control" placeholder="비밀번호(*)" name="userPassword" id="userPassword" maxlength="20" />
							</div>
							<div class="form-group" >
								<input type="password" class="form-control" placeholder="비밀번호 확인(*)" name="userPasswordCheck" id="userPasswordCheck" maxlength="20" />

							</div>
							
							<div class="form-group" >
								<input type="email" class="form-control" placeholder="이메일(*)" name="mail" id="mail" maxlength="20" />
								
							</div>
						
							<div class="form-group" >
							<div>
								<input type="text" class="form-control" placeholder="주소" id="address" name="address" maxlength="20" /> 
							
							
							<div class="address-modal" >
								<button id="modal-button" data-bs-toggle="modal" data-bs-target="#modal" type="button" class="btn btn-dark form-control" >주소찾기</button>
								<div id="modal" class="modal fade" tabindex="-1" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content address-content"></div>
									</div>
								</div>
								</div>
							</div>
							</div>
						
							<div class="form-group">
								<input type="text" class="form-control" placeholder="상세 주소" name="addresses" maxlength="20" />
								
							</div>
							<div class="form-group">
								<!-- <input type="text"  id="information" style="float:left; width: 430px; height: 150px; " value="<%=infoAgreement %>" disabled /> -->
								<textarea  id="information" style="float:left; width: 430px; height: 150px; padding: 5px 10px" disabled><%=infoAgreement %></textarea>
							</div>
							
							
							<div class="form-group" style="padding-top: 90px; padding-left: 240px;">
								<input type="checkbox" name="agree" id="agree" value="동의합니다" />위 상기 사항에 동의합니다.
							</div>
							
							<div class="form-group" >
								<input type="button" class="btn btn-dark form-control" value="회원가입" id="signup"  />
							</div>

							
                  </form>
               </div>
            </div>
         </div>
      </div>
</div>
<!-- 모달창 정보 -->		             
<div id="write-modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content write-content">
		</div>
	</div>
</div>

</body>
</html>