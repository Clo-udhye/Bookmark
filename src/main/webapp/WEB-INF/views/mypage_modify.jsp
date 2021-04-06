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
	String[] kwdarray = new String[3];
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
			kwdarray = keywords.split("//");
			String intro = to.getIntroduction();
			introduction = intro.replaceAll("<br/>", "\r\n");
			profile_filename = to.getProfile_filename();
		}
	}

%>



<style type="text/css">
	#user_img img {border-radius: 50%;}
	.form-control0 {width: 300px;}
	td { padding: 3px 4px 3px 4px; height:30px;}
	.btn {padding: 2px 4px 2px 4px;}
	.kwdselect {width:90px;}
	#kwd3 {width:105px;}
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
			if ($('#id').attr("check_result") == "fail"){
			    alert("아이디 중복체크를 해주시기 바랍니다.");
			    $('#id').focus();
			    return false;
			}
			if ($('#nickname').attr("check_result") == "fail"){
			    alert("별명 중복체크를 해주시기 바랍니다.");
			    $('#nickname').focus();
			    return false;
			}
			
			// 상세 주소 입력 전 주소 입력하기
			if($("#address").val() == "" && $("#addresses").val() != "") {
				alert('상세 주소를 입력하시려면 주소를 입력하셔야합니다.')
				$('#address').focus();
				return false;				
			}
			
			// 키워드 알림창
			//$("#kwd1 option:selected").val();
			if($("#kwd1 option:selected").val() == "none"){
				alert('키워드1을 선택해주세요.');
				$('#kwd1').focus();
				return false;
			}
			if($("#kwd2 option:selected").val() == "none"){
				alert('키워드2를 선택해주세요.');
				$('#kwd2').focus();
				return false;
			}			
			if($("#kwd3 option:selected").val() == "none"){
				alert('키워드3을 선택해주세요.');
				$('#kwd3').focus();
				return false;
			}
			
			//console.log($('#id').val());
			//document.mypagemodify_frm.submit();
			
			let formData = new FormData($('#mypagemodify_frm')[0]);
			$.ajax({
	            url : './mypage_modify_ok.do',
	            type : 'POST',
	            //enctype: 'multipart/form-data',
	            cache: false,
	            processData: false,
	            contentType: false,
	            data : formData,
	            //dataType: "xml",

	            success : function(xmlData){
	            	
	               //console.log(typeof($(xmlData).find('flag').text()));
	               if($(xmlData).find('flag').text() == 1){
	            	   alert('개인정보 수정에 성공했습니다');
	            	   location.reload();
	               } else {
	            	   alert('개인정보 수정에 실패했습니다');
	               }
	               
	            },
	            //error : function(){
	            //}
	            error : function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
	  
	});
	
</script>

<!-- 키워드 부분 -->
<script type="text/javascript">
$(document).ready(function(){
	// kwdarray[0]에 해당하는 값을 kwd1 네임을 갖는 곳에서 찾아서 그 option에 selected를 준다
	$("select option[value='<%=kwdarray[0]%>']").attr("selected", true);
	$("select option[value='<%=kwdarray[1]%>']").attr("selected", true);
	$("select option[value='<%=kwdarray[2]%>']").attr("selected", true);
});
</script>


<!-- 프로필 이미지 부분 -->
<script type="text/javascript">
  $(document).ready(function (e){
    $("input[type='file']").change(function(e){

      //div 내용 비워주기
      // 설정한 확장자에 해당하는 파일이 아닐 경우 알림창이 뜨고 파일 선택 창이 사라지는데 모달창에 기존 이미지가 사라짐.. 처리함
      $('#preview-image').empty();


      var files = e.target.files;
      var arr = Array.prototype.slice.call(files);
      
      //업로드 가능 파일인지 체크
      // 파일 하나라서 for문 필요 없을 듯. 추후 수정 ★★
      for(var i=0; i<files.length; i++){
        if(!checkExtension(files[i].name,files[i].size)){
          return false;
        }
      }
      
      preview(arr);

    });//file change
    
    function checkExtension(fileName,fileSize){

      //var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
      var maxSize = 1024 * 1024 * 2;  //2MB
      
      if(fileSize >= maxSize){
        alert('이미지파일 용량이 2MB를 사이즈 초과할 수 없습니다.');
        $("input[type='file']").val("");  //파일 초기화
        return false;
      }
      /*
      if(regex.test(fileName)){
        alert('업로드 불가능한 파일이 있습니다.');
        $("input[type='file']").val("");  //파일 초기화
        return false;
      }
      */
      
		// 확장자 처리 수정.. 대문자는 이미지로 인식을 안함..ㅠ ★★★
		const extension = fileName.split('.').pop();
		if(extension != 'png' && extension != 'jpg' && extension != 'gif' && extension != 'PNG' && extension != 'JPG' && extension != 'GIF' ) {
			alert('이미지 파일을 첨부하셔야 합니다. ( *.png || *.jpg || *.gif )');
			//$("input[type='file']").val("");  //파일 초기화
            var str = '';
			str += '<img src="./profile/<%=profile_filename %>" border="0" width=100px height=100px/>';
            $(str).appendTo('#preview-image');			
			return false;
		}

      return true;
    }
    
    function preview(arr){
      arr.forEach(function(f){
        //파일명이 길면 파일명...으로 처리
        var fileName = f.name;
        /* ... 처리하면 데이터 가지고 저장하기 번거로워서 안함
        if(fileName.length > 12){
          fileName = fileName.substring(0,9)+"...";
        }
		*/
		
        // upload-name 칸에 fileName 넣음.  
        $('.upload-name').val(fileName);

        //div에 이미지 추가
        //var str = '<div style="display: inline-flex; padding: 10px;"><li>';
        //str += '<span>'+fileName+'</span><br>';
        var str = '';
        
        //이미지 파일 미리보기
        var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
        
        reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
            //str += '<button type="button" class="delBtn" value="'+f.name+'" style="background: red">x</button><br>';
            str += '<img src="'+e.target.result+'" title="'+f.name+'" width=100 height=100 />';
            //str += '</li></div>';
            $(str).appendTo('#preview-image');
          } 
          reader.readAsDataURL(f);
      });//arr.forEach
    }
  });
</script>

<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />    

<div id="main">

	<div class="modal-header" style="padding-top: 10px; padding-bottom: 10px;">
		<span style="font-size:18px;"><b>프로필 수정하기</b></span>
		<span style="color:gray; font-size:14px;">수정 후, 하단의 저장하기를 꼭 눌러주세요!</span>

		<span><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></span>
	</div>
	
    <div class="modal-body" style="padding: 15px 16px 15px 16px;">
    <!-- 파일 업로드 할 때 enctype~ 필요함  -->
    <form action="./mypage_modify_ok.do" name="mypagemodify_frm" id="mypagemodify_frm" method="post" enctype="multipart/form-data">
    <!-- <form method="post" action="./mypage_modify_ok.do" name="mypagemodify_frm" id="mypagemodify_frm"> -->
    <input type="hidden" name="seq" value="<%=seq%>"/>
    <!-- 기존파일명 가져가기 -->
    <input type="hidden" name="prefileName" value="<%=profile_filename %>"/>
    	<table>
    		<!-- 아이디 -->
    		<tr>
    			<td rowspan="7" id="user_img" style="padding-right:18px;">
    				<!--  
    				<div><img src="./profile/<%=profile_filename %>" border='0' width=100px height=100px/></div>
    				<br/>
    				-->
    				<!--
    				<div><input type="button" id="imgchoice" class="btn btn-dark" value="이미지 선택"/></div>
    				<div style="width:96px;">파일명 : <input type="text" style="width:96px;" class="profile_filename" id="profile_filename" name="profile_filename" value="<%=profile_filename %>" maxlength="20" readonly/></div>
    				-->
    				<!-- 프로필 이미지 & 버튼 -->
					<div class="filebox">
						<div id="preview-image"><img src="./profile/<%=profile_filename %>" border='0' width=100px height=100px/></div>
						<br/>
						<!-- <textarea rows="1" cols="15" class="upload-name" id="profile_filename" name="profile_filename" style="resize:none;" ><%=profile_filename %></textarea> -->
						<!-- <input type="text" class="upload-name" id="profile_filename" name="profile_filename" value="<%=profile_filename %>" style="width:96px;" readonly /> -->
						<input type="text" class="upload-name" value="<%=profile_filename %>" style="width:96px;" readonly />
						<br/>
						<label for="uploadFile">업로드</label>
						<!-- 파일 업로드 테스트 해보려고 name="uploadFile" 추가함 -->
						<!-- <input type="file" name="uploadFile" id="uploadFile" class="upload-hidden"> -->
						<input type="file" name="uploadFile" id="uploadFile" />
					</div>
					<!-- <input type="file" name="uploadFile" id="uploadFile" value="" /> -->
					
    			</td>
    			<td><span class="form-title">아이디</span></td>
    			<td class="form-group">
    				<!-- 
					<div class="form-group">
    					<span><input type="text" class="form-control0" id="id" name="id" value="<%=id %>" maxlength="20" check_result="success" readonly/></span>
    				</div> 
    				-->
    				 <input type="text" class="form-control0" id="id" name="id" value="<%=id %>" maxlength="20" check_result="success" readonly/>
    			</td>
    			<td></td>

    		</tr>
    			
    		<!-- 별명 -->
    		<tr>
    			<td><span class="form-title">별명</span></td>
    			<td class="form-group">
    				<!-- 
    				<div class="form-group">
    					<span><input type="text" class="form-control0" id="nickname" name="nickname" value="<%=nickname %>" maxlength="20" check_result="success" required /></span>
    				</div>
    				-->
    				<input type="text" class="form-control0" id="nickname" name="nickname" value="<%=nickname %>" maxlength="20" check_result="success" required />
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
    			<td  class="form-group">
    				<!-- 
					<div class="form-group">
    					<span><textarea class="form-control0" id="introduction" name="introduction" style="resize:none;"><%=introduction %></textarea></span>
    				</div>
    				-->
    				 <textarea class="form-control0" id="introduction" name="introduction" style="resize:none;" maxlength="250"><%=introduction %></textarea>
    			</td>
    			<td></td>
    		</tr>    		
    		
    		<!-- 메일 -->
    		<tr>
    			<td><span class="form-title">메일</span></td>
    			<td class="form-group">
    				<input type="email" class="form-control0" id="mail" name="mail" value="<%=mail %>" maxlength="50" />	
    			</td>
    			<td></td>
    		</tr>	
    		
    		<!-- 주소 -->
    		<tr>
    			<td><span class="form-title">주소</span></td>
    			<td class="form-group">
    				<!--  
    				<div class="form-group">
    					<span><input type="text" class="form-control0" id="address" name="address" value="<%=address %>"maxlength="20" /></span>
    				</div> 
    				-->   		
    				<input type="text" class="form-control0" id="address" name="address" value="<%=address %>"maxlength="20" />	
    			</td>
    			<td>
    				<span class="form-btn">
						<button id="modal-button" data-bs-toggle="modal" data-bs-target="#zipsearchmodal" type="button" class="btn btn-dark" >주소찾기</button>
    				</span>    			
    			</td>
    		</tr>
    		
    		<!-- 상세 주소 -->
    		<tr>
    			<td><span class="form-title">상세 주소</span></td>
    			<td class="form-group">
    				<!--  
       				<div class="form-group">
    					<span><input type="text" class="form-control0" id="addresses" name="addresses" value="<%=addresses %>" maxlength="20" /></span>
    				</div>
    				-->
    				<input type="text" class="form-control0" id="addresses" name="addresses" value="<%=addresses %>" maxlength="20" />	
    			</td>
    			<td></td>
    		</tr>
    		
    		<!-- 태그 -->
    		<tr>
    			<td><span class="form-title">태그</span></td>
    			<td colspan="2" class="form-group">
    				<!--  
       				<div class="form-group">
    					<span><input type="text" class="form-control0" id="keywords" name="keywords" value="<%=keywords %>" maxlength="20" /></span>
    				</div>
    				-->      			
					<select class="kwdselect" name="kwd1" id="kwd1">
						<option value="none">키워드1</option>
						<!-- IT / SF / 경제 / 과학 / 만화 / 사진 / 소설 / 시 / 에세이 / 여행 / 역사 / 자기 개발 / 잡지 / 추리 / 패션 -->
						<option value="경제">경제</option>
						<option value="과학">과학</option>
						<option value="만화">만화</option>
						<option value="사진">사진</option>
						<option value="소설">소설</option>
						<option value="시">시</option>
						<option value="에세이">에세이</option>
						<option value="여행">여행</option>
						<option value="역사">역사</option>
						<option value="자기 개발">자기 개발</option>
						<option value="잡지">잡지</option>
						<option value="추리">추리</option>
						<option value="패션">패션</option>
						<option value="IT">IT</option>
						<option value="SF">SF</option>
					</select>
					
					<span>을(를) 좋아하는 </span>
					<select class="kwdselect" name="kwd2" id="kwd2">
						<option value="none">키워드2</option>
						<!-- 감성적인 / 계획적인 / 귀여운 / 꿈꾸는 / 똑똑한 / 말이 많은 / 매력있는 / 밝은 / 상큼한 / 섹시한 / 소심한 / 솔직한 / 잘생긴 / 적극적인 / 허술한 / 활발한 -->
    					<option value="감성적인">감성적인</option>
    					<option value="계획적인">계획적인</option>
    					<option value="귀여운">귀여운</option>
    					<option value="꿈꾸는">꿈꾸는</option>
    					<option value="똑똑한">똑똑한</option>
    					<option value="말이 많은">말이 많은</option>
    					<option value="매력있는">매력있는</option>
    					<option value="밝은">밝은</option>
    					<option value="상큼한">상큼한</option>
    					<option value="섹시한">섹시한</option>
    					<option value="소심한">소심한</option>
    					<option value="솔직한">솔직한</option>
    					<option value="잘생긴">잘생긴</option>
    					<option value="적극적인">적극적인</option>
    					<option value="허술한">허술한</option>
    					<option value="활발한">활발한</option>
    				</select>
    				<select class="kwdselect" name="kwd3" id="kwd3">
    					<option value="none">키워드3</option>
    					<!-- SNS스타 / 강사 / 개발자 / 건축가 / 기획자 / 디자이너 / 마케터 / 백수 / 소설가 / 쉐프 / 알바생 / 에세이스트 / 연예인 / 예술인 / 작가 지망생 / 주부 / 직장인 / 취준생 / 프로듀서 / 프리랜서 / 학생 -->
    					<option value="강사">강사</option>
    					<option value="개발자">개발자</option>
    					<option value="건축가">건축가</option>
    					<option value="기획자">기획자</option>
    					<option value="디자이너">디자이너</option>
    					<option value="마케터">마케터</option>
    					<option value="백수">백수</option>
    					<option value="소설가">소설가</option>
    					<option value="쉐프">쉐프</option>
    					<option value="알바생">알바생</option>
    					<option value="에세이스트">에세이스트</option>
    					<option value="연예인">연예인</option>
    					<option value="예술인">예술인</option>
    					<option value="작가 지망생">작가 지망생</option>
    					<option value="주부">주부</option>
    					<option value="직장인">직장인</option>
    					<option value="취준생">취준생</option>
    					<option value="프로듀서">프로듀서</option>
    					<option value="프리랜서">프리랜서</option>
    					<option value="학생">학생</option>
    					<option value="SNS스타">SNS스타</option>
    				</select>     			
    			</td>
    			<!-- 
    			<td>
    				<span class="form-btn"><input type="button" id="keywordset" class="btn btn-dark" value="키워드 선택" /></span>    			
    			</td>
    			 -->
    		</tr>
    	</table>
    </form>
    </div>
    
    <div class="modal-footer" style="padding:3px 16px;">
    	<input type="button" id="save" class="btn btn-dark" value="저장하기" />
    </div>
    
</div>



