<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Callback</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script type = "text/javascript" src = "https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</head>
<body>
  <script type="text/javascript">
        //var naver_id_login = new naver_id_login("ayKuMJkaKd7XupXX8g4J", "http://localhost:8080/bookmark//callback1.do"); //'localhost'가 포함된 CallBack URL
        //var naver_id_login = new naver_id_login("ayKuMJkaKd7XupXX8g4J", "http://49.50.174.216:8080/Project_BM/callback1.do"); //'localhost'가 포함된 CallBack URL
        var naver_id_login = new naver_id_login("ayKuMJkaKd7XupXX8g4J", "http://bookmark-project.com/callback1.do"); //'localhost'가 포함된 CallBack URL
        
        // 접근 토큰 값 출력
        //alert(naver_id_login.oauthParams.access_token);
        
        // 네이버 사용자 프로필 조회
        naver_id_login.get_naver_userprofile("naverSignInCallback()");
        
        // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
        function naverSignInCallback() {
            //console.log(naver_id_login.getProfileData('email'));
            //console.log(naver_id_login.getProfileData('nickname'));
            
            let sns_id = naver_id_login.getProfileData('email').split('@')[0];
			let sns_nickname = naver_id_login.getProfileData('nickname');
            
            location.href="./sns_user.do?sns_id="+sns_id+"&sns_type=naver&sns_nickname="+sns_nickname;   
        }
    </script>
  

</body>
</html>