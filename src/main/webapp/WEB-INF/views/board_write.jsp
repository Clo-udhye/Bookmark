<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	//현재 세션 상태를 체크한다
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	} else {
		out.println("<script type='text/javascript'>");
    	out.println("alert('로그인해주세요.')");
    	out.println("location.href='./login.do';");
    	out.println("</script>");
	}
	
	String useq = userInfo.getSeq();
	String id = userInfo.getId();
	String nickname = userInfo.getNickname();
	String profile_src = "./profile/" + userInfo.getProfile_filename();
%>    

<link rel="stylesheet" type="text/css" href="./css/flexslider.css">
<script type="text/javascript" src="./js/jquery.flexslider-min.js"></script>
<script>
$(document).ready(function(){
	$(".flexslider").flexslider({
		animation: "slide",	
		slideshow: false,
		disableDragAndDrop: true,
	});
	
	$('#summernote').summernote({
		placeholder: '게시글 입력...',
		dialogsInBody: true,
		width: 630,
		height: 316,
		disableResizeEditor: true,
		toolbar: [
		    // [groupName, [list of button]]
		    ['style', ['bold', 'italic', 'underline']],
		    ['fontsize', ['fontsize']],
		    ['color', ['color']]
		  ]
	});
	$('.note-statusbar').hide();
	
	//저장버튼 클릭
    $(document).on('click', '#complete_btn', function () {
        if($('#title').val()==''){
        	alert('제목을 입력해주세요.');
        	$('#title').focus();
        	return false;
        }
        if($('#img-selector').val()==''){
        	alert('이미지를 선택해주세요.');
        	$('#img-selector').focus();
        	return false;
        }
        if($('#bookname').val()==''){
        	alert('책을 선택해주세요.');
        	$('#bookname').focus();
        	return false;
        }
        if($('#summernote').val()==''){
        	alert('내용을 입력해주세요.');
        	$('#summernote').focus();
        	return false;
        }
        if($('#summernote').val().length>10000){
        	alert('10000자 이하로 입력하세요.');
        	$('#summernote').focus();
        	return false;
        }
      	
        document.wfrm.submit();
        /*
        $.ajax({
            url : './write_ok2.do',
            type : 'post',
            dataType: 'xml',
            enctype: 'multipart/form-data', // 필수 
            processData: false, // 필수 
            contentType: false, // 필수
            data : {
               'title': $('#title').val(),
               'useq' : $('#useq').val(),
               'content': $('#summernote').val(),
               'bookseq': $('#bookseq').val(),
               'file': $('#img-selector').val()
            },
            success : function(xmlData){	            	
            	alert('flag : ' + $(xmlData).find("flag").text());
			},
			error : function(request,status, error) {
				alert("[에러] : code "+ request.status);
				//alert("code:"+request.status+"\n"+"error:"+error);
			}
		});	
		*/
        
        
    });
	
	$('#title').keyup(function(){
		//제목 글자수 세기
        $('#counter-title').html('('+$(this).val().length+'/100)');
	});
	
	$('.close-btn').on('click', function(){
		$("#booklist-modal").modal("hide");
	});
	
	$('#book-search').on('click', function(){
		if($('#searchword').val().trim()==''){
			alert('검색어를 입력해주세요.');
		}else{
			$.ajax({
	            url : './booklist_search.do',
	            type : 'post',
	            dataType: 'xml',
	            data : {
	               'option' : $('input[name="radio-btn"]:checked').val(),
	               'searchword' : $('#searchword').val()
	            },
	            success : function(xmlData){	            	
	            	//console.log('flag : ' + $(xmlData).find("flag").text());
	            	let html = '';
	            	$(xmlData).find('book').each(function(){
						html += "<button type='button' style='padding: 8px;' class='list-group-item list-group-item-action' aria-current='true' bookseq='"+$(this).find("seq").text()+"' title='"+$(this).find("title").text()+"'>";
						html += "<table>";
						html += "	<tr>";
						html += "		<td>";
						html += "			<div><img src='"+$(this).find("img_url").text()+"' width='100px'/></div>";
						html += "		</td>";
						html += "		<td>";
						html += "			<div style='padding: 0px 5px;'>";
						html += "				<p style='margin:0px 0px 5px'>"+$(this).find("title").text()+"</p>";
						html += "				<p style='margin:0px 0px 5px'>"+$(this).find("author").text()+"</p>";
						html += "				<p style='margin:0px 0px 5px'>"+$(this).find("description").text()+"</p>";
						html += "			</div>";
						html += "		</td>";
						html += "</tr>";
						html += "</table>";
						html += "</button>";
					});
	            	$('.list-group').html(html);
				},
				error : function(request,status, error) {
					alert("[에러] : code "+ request.status);
					//alert("code:"+request.status+"\n"+"error:"+error);
				}
			});	
		}
	});
	
	$(document).on('click', '.list-group button',function(e){
		$('#searchword').val($(this).attr('title'));
		console.log($(this).attr('title'));
		$(this).tab('show')
	});
	
	$('#selected-book').on('click', function(){
		$('#bookname').val($('#searchword').val());
		$('input[name="bookseq"]').val($('.list-group button').tab().attr('bookseq'));
		$("#booklist-modal").modal("hide");
	});
	
});
	//나중에 추가 ..
	var dropFile = function(event) {
		//이미지 드래그앤드롭을 위해 기존의 브라우저 이벤트 막기 - 
		event.preventDefault();
	}

	$(document).on('change', "#img-selector", function(e) {
		//div 내용 비워주기
		//$('#img_preview').empty();

		var files = e.target.files;
		var arr = Array.prototype.slice.call(files);

		//업로드 가능 파일인지 체크
		for (var i = 0; i < files.length; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
		}
		preview(arr);
	});//file change

	function checkExtension(fileName, fileSize) {
		var regex = /^[a-zA-Z0-9_-]+\.(png|jpg|gif|bmp|PNG|JPG|GIF|BMP)$/;
		var maxSize = 20971520; //20MB

		if (fileSize >= maxSize) {
			alert('"' + fileName + '" 파일 사이즈 초과');
			$("#img-selector").val(""); //파일 초기화
			return false;
		}

		if (!regex.test(fileName)) {
			alert('"' + fileName + '" 파일이름에는 \/:*?"<>|!가 포함될수 없습니다.');
			$("#img-selector").val(""); //파일 초기화
			return false;
		}

		if (fileName.length > 100) {
			alert('"' + fileName + '" 파일이름의 길이는 100자를 초과할수 없습니다.');
			$("#img-selector").val(""); //파일 초기화
			return false;
		}
		return true;
	}

	function preview(arr) {
		arr
				.forEach(function(f) {
					//파일명이 길면 파일명...으로 처리
					/*
					var fileName = f.name;
					if(fileName.length > 10){
						fileName = fileName.substring(0,7)+"...";
					}
					 */

					//div에 이미지 추가
					let str = '';

					//이미지 파일 미리보기
					if (f.type.match('image.*')) {
						var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
						reader.onload = function(e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
							console.log(f.name);
							console.log(f.path);
							str += '<li><img src="'+e.target.result+'" title="'+f.name+'" width=600px /></li>';
							//$(str).appendTo('#preview');
							$('#img_preview').data('flexslider').addSlide(
									$(str));
						}
						reader.readAsDataURL(f);
					}
				});//arr.forEach
	}
</script>

<style type="text/css">
.writerInfo td{
	padding: 5px;
	}
#profile_img {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	}
#img_preview{
	width: 500px; 
	height: 500px;
	}
.userID, #counter-title{
	color: #d2d2d2;
}	

/*이미지 드래그앤드롭 가능 영역 확장 - 나중에 추가*/
#img_preview {
  apperance: none;
  -webkit-apperance: none;
}

ul, ol, li{ margin:0; padding:0; list-style:none;}

.list-group{
    max-height: 500px;
    overflow:scroll;
    -webkit-overflow-scrolling: touch;
}
 
.list-group-item.active {
  background-color: #999999;
  border-color: #999999;
}

</style>

    
<div class="modal-header">
	<h4 class="modal-title">새 게시물</h4>
	<button type="button" class="close" data-bs-dismiss="modal">&times;</button>
</div>
<form action="./write_ok.do" name="wfrm" method="post" enctype="multipart/form-data">
<input type="hidden" name="useq" value=<%=useq %>>
<input type="hidden" name="bookseq" value=0>
<div class="modal-body" style="padding:0;">
	<table>
		<tr>
			<td>
				<div id="img_preview" class="flexslider">
        			<ul class="slides">
        				<li><img class="default" id="profile_img1" src="./images/profile_Dahye.jpg" /></li>
        				<li><img class="upload_img" src="./images/profile_Minji.jpg" /></li>
        			</ul>
        		</div>
			</td>
			<td>
				<table width=100%>
					<tr class="writerInfo">
						<td>
							<img id="profile_img" src=<%=profile_src %>>
							<span class="nickname"><%=nickname %></span>
							<span class="userID">(<%=id %>)</span>
						</td>
					</tr>
					<tr class="boardInfo">
						<td>
							<div class="col-lg-10 d-inline-block">
								<input class="form-control" type="text" placeholder="제목을 입력해주세요." id="title" name="title" maxlength="100" size="5"/>
							</div>
							<div class="d-inline">							
								<span id="counter-title">(0/100)</span>
							</div>
						</td>
					</tr>
					<tr class="imgSelector">
						<td>
							<div>
								<input type="file" id="img-selector" multiple="multiple"  class="form-control form-control-sm" name="filename[]"/>
							</div>
						</td>
					</tr>
					<tr class="bookInfo">
						<td>
							<div>
								<div class="input-group mb-3" style="margin:0">
									<input type="text" class="form-control" placeholder="책 선택" id="bookname" readonly>
									<button class="btn btn-outline-secondary" type="button" id="book-selectbtn"  data-bs-toggle="modal" data-bs-target="#booklist-modal">검색</button>
									
									<div class="booklist-modal" >
									<div id="booklist-modal" class="modal fade" tabindex="-1" role="dialog">
										<div class="modal-dialog">
											<div class="modal-content booklist-content">
												<div class="modal-header">
													<h5 class="modal-title">책 검색</h5>
											        <button type="button" class="close close-btn">&times;</button>
												</div>
												<div class="modal-body">
													<div class="form-check form-check-inline">
											  			<input class="form-check-input" type="radio" name="radio-btn" id="inlineRadio1" value="title" checked>
											  			<label class="form-check-label" for="inlineRadio1">책제목</label>
													</div>
													<div class="form-check form-check-inline">
											  			<input class="form-check-input" type="radio" name="radio-btn" id="inlineRadio2" value="author">
											  			<label class="form-check-label" for="inlineRadio2">작가</label>
													</div>
													<div class="input-group mb-3">
														<input type="text" class="form-control" placeholder="검색어를 입력하세요." id="searchword">
														<button class="btn btn-outline-secondary" type="button" id="book-search">검색</button>
													</div>
													<div class="list-group">
													</div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary close-btn">Close</button>
											        <button type="button" class="btn btn-dark" id="selected-book">확인</button>
												</div>
											</div>
										</div>
									</div>
								</div>
								</div>
							</div>
						</td>
					</tr>
					
				</table>
				<textarea id="summernote" name="summernote"></textarea>
			</td>
		</tr>
	</table>
	
</div>
<div class="modal-footer">
	<input type="button" value="쓰기" id="complete_btn" class="btn btn-default" />
</div>
</form>
