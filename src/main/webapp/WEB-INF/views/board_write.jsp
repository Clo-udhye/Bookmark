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
var contents = new Array();
var content_files = new Array();

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
		height: 260,
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
        	let count_files =0;
    		for(let i=0; i<contents.length; i++){
    			if(!contents[i].is_delete){
    				count_files++;
    			}
    		}
    		if(count_files == 0){
    			alert('이미지를 선택해주세요.');
    			$('#img-selector').focus();
    			return false;
    		}
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
        var text = $('#summernote').val();
        text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
        if(text.length>10000){
        	alert('10000자 이하로 입력하세요.');
        	$('#summernote').focus();
        	return false;
        }
      	
        //document.wfrm.submit();
        let formData = new FormData();
        formData.append('title',$('#title').val());
        formData.append('useq',$('#useq').val());
        formData.append('content',$('#summernote').val());
        formData.append('bookseq',$('#bookseq').val());
		for(var i=0; i<contents.length; i++) {
            var content = contents[i];
            if(content.is_delete == false) {
            	formData.append("files", content_files[i]);
            }
        }
        
        $.ajax({
            url : './write_ok.do',
            type:'POST',
			cache: false,
			processData: false,
			contentType: false,
			data : formData,
			dataType: 'xml',
            success : function(xmlData){	            	
            	//alert('flag : ' + $(xmlData).find("flag").text());
            	if($(xmlData).find("flag").text() == 1){
            		alert('글쓰기에 성공했습니다.');
            		location.href="./mypage.do?useq="+<%=useq%>;
            	} else {
            		alert('[Error] : 글쓰기에 실패했습니다.');
            	}
			},
			error : function(request,status, error) {
				alert("[에러] : code "+ request.status);
				//alert("code:"+request.status+"\n"+"error:"+error);
			}
		});	
		
        
        
    });
	
	$('#title').keyup(function(){
		//제목 글자수 세기
        $('#counter-title').html('('+$(this).val().length+'/100)');
	});
	
	$('.close-btn').on('click', function(){
		$("#booklist-modal").modal("hide");
	});
	
	$('#book-search').on('click', function(){
		$('#searchword').attr("bookseq", "-1");
		//console.log($('#searchword').attr("bookseq"));
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
		$('#searchword').attr("title", $(this).attr('title'));
		$('#searchword').attr("bookseq", $(this).attr('bookseq'));
		//console.log($('#searchword').attr("bookseq"));
		$(this).tab('show')
	});
	
	$('#selected-book').on('click', function(){
		if($('#searchword').attr('bookseq')==-1){
			alert('책을 선택해주세요.');
		}else{
			$('#bookname').val($('#searchword').attr('title'));
			$('input[name="bookseq"]').val($('#searchword').attr('bookseq'));
			$("#booklist-modal").modal("hide");	
		}
	});
	
	$(document).on('click','.delete_btn', function(){
		//console.log('이미지삭제' + $(this).attr('index'));
		deleteItemAction($(this).attr('index'));
	});
	
});
	//나중에 추가 ..
	var dropFile = function(event) {
		//이미지 드래그앤드롭을 위해 기존의 브라우저 이벤트 막기 - 
		event.preventDefault();
	}

	$(document).on('change', "#img-selector", function(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
	
		var check_flag=1;
		if(filesArr.length>5){
			alert("이미지는 5장까지만 업로드가능합니다.");
			$("#img-selector").val("");
            return;
		}
		
		filesArr.forEach(function(f) {
			//console.log(f.name.length);
            if(!f.type.match("image.*")) {
                alert("이미지 파일만 업로드가능합니다.");
                $("#img-selector").val("");
                check_flag=0;
                return;
            }          
            var regexp = /^[ㄱ-힣0-9a-zA-Z-_.]{1,25}$/;
            if(!regexp.test(f.name)){
            	alert('['+f.name+']:이미지 이름은 영문자, 한글, 특수문자(_,-)만 가능합니다.');
            	$("#img-selector").val("");
            	check_flag=0;
            	return false;
			}
            var maxSize = 1024*1024*3; //3MB
            if (f.size >= maxSize) {
    			alert('['+f.name+']: 이미지파일 용량이 3MB를 사이즈 초과할수없습니다.');
    			$("#img-selector").val("");
    			check_flag=0;
    			return false;
    		}
            if(f.name.length>20) {
    			alert('['+f.name+']: 파일이름의 길이는 20자를 초과할수 없습니다.');
    			$("#img-selector").val("");
    			check_flag=0;
    			return false;
    		}
		});
		
		if(check_flag==1){
			preview(filesArr);	
		}
	});//file change

	function preview(arr) {
		arr.forEach(function(f) {
			let str = '';
			
			//이미지 파일 미리보기		
			var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
			reader.onload = function(e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
				let index = contents.length;
                let url_src = e.target.result;
            	
            	var data = {
                    "index":index,
                    "url_src":url_src,
                    "is_delete":false
                };
               	contents.push(data);
                content_files.push(f);
                        
				str += '<li class="myslide"><button type="button" class="delete_btn del-btn btn" index="'+index+'"><i class="fas fa-times-circle fa-3x"></i></button><img src="'+url_src+'" title="'+f.name+'" style="width:492px; height:492px;" /></li>';
				$('#img_preview').data('flexslider').addSlide($(str));
				
				let count_files =0;
				for(let i=0; i<contents.length; i++){
					if(!contents[i].is_delete){
						count_files++;
					}
				}
				if(count_files==1){
					$('#img_preview').data('flexslider').removeSlide(0);
				}
			}
			reader.readAsDataURL(f);
		});//arr.forEach
		$("#img-selector").val('');
	}
	
	function deleteItemAction(index) {		
		let count_files =0;
		for(let i=0; i<contents.length; i++){
			if(!contents[i].is_delete){
				count_files++;
			}
		}
        if(count_files==1){
        	//console.log('마지막');
        	let str = '<li><img class="no-image" src="./images/no_Image_upload.jpg" title="no_Image_upload" style="width:492px; height:492px;"" /></li>';
        	$('#img_preview').data('flexslider').addSlide($(str));
        }
        $('#img_preview').data('flexslider').removeSlide($('#img_preview').data('flexslider').currentSlide);
        contents[index].is_delete = true;
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
	position: relative;
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

.del-btn {
  position: absolute;
  top:10px;
  z-index: 10;
  opacity: 0;
  cursor: pointer;
  color: rgba(0, 0, 0, 0.8);
  text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.3);
  transition: all 0.3s ease-in-out;
}

#img_preview:hover .del-btn{
  opacity: 0.6;
}
#img_preview:hover .del-btn:hover{
  opacity: 1;
}

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

<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />    
<div class="modal-header">
	<h4 class="modal-title">새 게시물</h4>
	<button type="button" class="close" data-bs-dismiss="modal">&times;</button>
</div>
<form action="./write_ok.do" id="wfrm" method="post" enctype="multipart/form-data">
<input type="hidden" id="useq" name="useq" value=<%=useq %> required />
<input type="hidden" id="bookseq" name="bookseq" value=0 required />
<div class="modal-body" style="padding:0;">
	<table>
		<tr>
			<td>
				<div id="img_preview" class="flexslider">
					<div class="darkness"></div>
        			<ul class="slides">
        				<li><img class="no-image" src="./images/no_Image_upload.jpg" title="no_Image_upload" style="width:492px; height:492px;" /></li>
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
								<input class="form-control" type="text" placeholder="제목을 입력해주세요." id="title" name="title" maxlength="100" size="5" required />
							</div>
							<div class="d-inline">							
								<span id="counter-title">(0/100)</span>
							</div>
						</td>
					</tr>
					<tr class="imgSelector">
						<td>
							<div>
								<input type="file" id="img-selector" class="form-control form-control-sm"  accept="image/*" name="files" multiple required /> 
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
														<input type="text" class="form-control" placeholder="검색어를 입력하세요." id="searchword" title="" bookseq="-1">
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
