<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.exam.user.UserDAO"%>

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
		document.getElementById('userID').onchange = function(){
			$('#id_check_sucess').hide();
			$('.id_overlap_button').show();
			$('.username_input').attr("check_result", "fail");
		}
		document.getElementById('btn').onclick = function(){			
			const id = document.getElementById('userID').value.trim();
		
			const request = new XMLHttpRequest();
			request.onreadystatechange = function(){
				if(request.readyState == 4){
					if(request.status == 200){
						const data = request.responseXML;
						const flags = data.getElementsByTagName('flag');
						let flag = flags[0].childNodes[0].nodeValue;
					
						if(flag == 0){
							alert("이미 존재하는 아이디 입니다.");
							
					    
						} else{
							alert("사용가능한 아이디 입니다.");
					          $('.username_input').attr("check_result", "success");
					          $('#id_check_sucess').show();
					          $('.id_overlap_button').hide();
						}
						
					} else{
						alert('에러페이지');
					}
				}
			};
			request.open('GET', './duplicationCheck.do?item=id&value=' + id, true);
			request.send();
		};
	};
	</script>
</head>
<body>
	<input type="text" class="username_input" id="userID" check_result="fail" required />
	<button type="button" class="id_overlap_button" id="btn">중복검사</button>
	<i class="fa fa-check" id="id_check_sucess" style="display: none;" aria-hidden="true" ></i>
</body>
</html>