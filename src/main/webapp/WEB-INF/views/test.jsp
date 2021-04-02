<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>


<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>


<script type="text/javascript">
	$(document).ready(function(){
		$("#modal-modifybutton").click(function(){
		  	// seq=뒤에 1 대신 받아온 값 넣어야 함.
			$('.modify-content').load("./mypage_modify.do?seq=1");

		});

	});
	  
</script>


<style type="text/css">
	
	#modifymodal1 {width: 650px;}
	
	.filebox label { display: inline-block; padding: .5em .75em; color: #999; font-size: inherit; line-height: normal; vertical-align: middle; background-color: #fdfdfd; cursor: pointer; border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; }
	.filebox input[type="file"] { /* 파일 필드 숨기기 */ position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; }

</style>

</head>
<body>

<button id="modal-modifybutton" data-bs-toggle="modal" data-bs-target="#modifymodal" type="button" class="btn btn-dark" >수정하기</button>
								
<div id="modifymodal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content modify-content" id="modifymodal1"></div>
	</div>
</div>

<div id="modal" class="modal fade" tabindex="-1" role="dialog" data-bs-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content address-content"></div>
	</div>
</div>







</body>
</html>      
      
      
      
     