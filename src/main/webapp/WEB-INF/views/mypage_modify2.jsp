<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="com.exam.user.UserDAO"%>
<%@page import="com.exam.user.UserTO"%>
<%@page import="java.util.ArrayList"%>

<%
	ArrayList<UserTO> lists = (ArrayList)request.getAttribute( "lists" );


	String seq = "";
	String id = "";
	String nickname = "";
	String mail = "";
	String address = "";
	String addresses = "";
	String keywords = "";
	String introduction = "";
	String profile_filename = "";
	
	if(lists != null) {
		for( UserTO to : lists ) {
			seq = to.getSeq();
			id = to.getId();
			nickname = to.getNickname();
			mail = to.getMail();
			if ( to.getAddress() != null ) {
				address = to.getAddress();
			}
			if ( to.getAddresses() != null ) {
				addresses = to.getAddresses();
			}
			keywords = to.getKeywords();
			introduction = to.getIntroduction();
			profile_filename = to.getProfile_filename();
		}
	}

%>

<style type="text/css">
	#user_img img {border-radius: 50%;}
	.form-control0 {width: 300px;}
	td { padding: 3px 4px 3px 4px;}
	.btn {padding: 2px 4px 2px 4px;}
</style>

<script type="text/javascript">
	$(document).ready(function(){

		$('#nickname_check_sucess').show();
		$('#nickname_check').hide();

		//중복확인후 변경시 제출하지못하게 변경
		$('#nickname').on('change', function() {
			$('#nickname_check_sucess').hide();
			$('#nickname_check').show();
			$('#nickname').attr("check_result", "fail");
		});
				
		document.getElementById('nickname_check').onclick = function(){
			// 별명 정규표현식, 한글 숫자만 가능, 2~12자
			const regexp2 = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|0-9a-zA-Z]{2,20}$/;
			if(!regexp2.test(document.mypagemodify_frm.nickname.value.trim())){
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
				request.open('GET', './duplicationCheck.do?item=nickname&value=' + document.mypagemodify_frm.nickname.value.trim(), true);
				request.send();
			}
		};
		
		document.getElementById('save').onclick = function(){

			if(document.mypagemodify_frm.nickname.value.trim()==''){
				alert('별명을 입력하셔야합니다.');
				$('#nickname').focus();
				return false;
			}

			if(document.mypagemodify_frm.mail.value.trim()==''){
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
			
			//document.mypagemodify_frm.submit();
			$.ajax({
	            url : './mypage_modify_ok.do',
	            type : 'get',
	            data : {
	            	'seq' : <%=seq%>,
	            	'id' : $('#userID').val(),
	            	'nickname' : $('#nickname').val(),
	            	'mail' : $('#mail').val(),
	            	'address' : $('#address').val(),
	            	'addresses' : $('#addresses').val(),
	            	'keywords' : $('#keywords').val(),
	            	'introduction' : $('#introduction').val(),
	            	'profile_filename' : $('#profile_filename').val()

	            },
	            success : function(xmlData){
	            	
	               //console.log(typeof($(xmlData).find('flag').text()));
	               if($(xmlData).find('flag').text() == 1){
	            	   alert('개인정보 수정에 성공했습니다');
	            	   location.reload();
	               } else {
	            	   alert('개인정보 수정에 실패했습니다');
	               }
	               
	            },
	            error : function(){
	            }
	         });      
		};
		
		$(".btn-close").click(function(){
			location.reload();
		});
		
	});
</script>

<script type="text/javascript">
	$(document).ready(function(){
		$("#modal-button").click(function(){
		  	const regexp2 = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|0-9]{2,12}$/;
			if(!regexp2.test($('#address').val().trim())){
				alert('동이름으로 검색해주세요');
				$('#address').val('');
			}
			
			$('.address-content').load("./zipsearch.do?strDong="+$('#address').val());
				
		  });
	  
		$("#imgchoice").click(function(){
		 alert("imgchoice"); 
		  });
	  
		$("#keywordset").click(function(){
			 alert("keywordset");
		});
	});
	
</script>


<div id="main">

	<div class="modal-header" style="padding-top: 10px; padding-bottom: 10px;">
		<span style="font-size:18px;"><b>프로필 수정하기</b></span>
		<span style="color:gray; font-size:14px;">수정 후, 하단의 저장하기를 꼭 눌러주세요!</span>

		<span><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></span>
	</div>
	
    <div class="modal-body" style="padding: 15px 18px 15px 18px;">
    <form method="post" action="./mypage_modify_ok.do" name="mypagemodify_frm">
    <input type="hidden" name="seq" value="<%=seq%>"/>
    	<table>
    		<!-- 아이디 -->
    		<tr>
    			<td rowspan="7" id="user_img" style="padding-right:18px;">
    				<!-- filename 위에서 받아와서 변경 -->
    				<div><img src="./profile/<%=profile_filename %>" border='0' width=100px height=100px/></div>
    				<br/>
    				<div><input type="button" id="imgchoice" class="btn btn-dark" value="이미지 선택"/></div>
    				<div style="width:96px;">파일명 : <input type="text" style="width:96px;" class="filename" id="profile_filename" name="profile_filename" value="<%=profile_filename %>" maxlength="20" readonly/></div>
    			</td>
    			<td><span class="form-title">아이디</span></td>
    			<td>
					<div class="form-group">
    					<span><input type="text" class="form-control0" id="userID" name="userID" value="<%=id %>" maxlength="20" check_result="success" required readonly/></span>
    				</div> 
    			</td>
    			<td></td>

    		</tr>
    			
    		<!-- 별명 -->
    		<tr>
    			<td><span class="form-title">별명</span></td>
    			<td>
    				<div class="form-group">
    					<span><input type="text" class="form-control0" id="nickname" name="nickname" value="<%=nickname %>" maxlength="20" check_result="success" required /></span>
    				</div>		
    			</td>
    			<td>
    				<span class="form-btn">
						<input type="button" class="btn btn-dark" value="중복확인" id="nickname_check" />
						<i class="fa fa-check" id="nickname_check_sucess" style="display: none;" aria-hidden="true" ></i>    						
    				</span>    			
    			</td>
    		</tr>
    		
    		<!-- 소개 -->	
    		<tr>
    			<td><span class="form-title">소개</span></td>
    			<td>
					<div class="form-group">
    					<span><textarea class="form-control0" id="introduction" name="introduction" style="resize:none;"><%=introduction %></textarea></span>
    				</div>
    			</td>
    			<td></td>
    		</tr>    		
    		
    		<!-- 메일 -->
    		<tr>
    			<td><span class="form-title">메일</span></td>
    			<td>
					<div class="form-group">
    					<span><input type="email" class="form-control0" id="mail" name="mail" value="<%=mail %>" maxlength="20" /></span>
    				</div>    			
    			</td>
    			<td></td>
    		</tr>	
    		
    		<!-- 주소 -->
    		<tr>
    			<td><span class="form-title">주소</span></td>
    			<td>
    				<div class="form-group">
    					<span><input type="text" class="form-control0" id="address" name="address" value="<%=address %>"maxlength="20" /></span>
    				</div>    			
    			</td>
    			<td>
    				<span class="form-btn">
						<button id="modal-button" data-bs-toggle="modal" data-bs-target="#modal" type="button" class="btn btn-dark" >주소찾기</button>
    				</span>    			
    			</td>
    		</tr>
    		
    		<!-- 상세 주소 -->
    		<tr>
    			<td><span class="form-title">상세 주소</span></td>
    			<td>
       				<div class="form-group">
    					<span><input type="text" class="form-control0" id="addresses" name="addresses" value="<%=addresses %>" maxlength="20" /></span>
    				</div>    			
    			</td>
    			<td></td>
    		</tr>
    		
    		<!-- 태그 -->
    		<tr>
    			<td><span class="form-title">태그</span></td>
    			<td>
       				<div class="form-group">
    					<span><input type="text" class="form-control0" id="keywords" name="keywords" value="<%=keywords %>" maxlength="20" /></span>
    				</div>       			
    			</td>
    			<td>
    				<span class="form-btn"><input type="button" id="keywordset" class="btn btn-dark" value="키워드 선택" /></span>    			
    			</td>
    		</tr>
    	</table>
    </form>
    </div>
    
    <div class="modal-footer" style="padding-top:3px; padding-bottom:3px;">
    	<input type="button" id="save" class="btn btn-dark" value="저장하기" />
    </div>
    
</div>



