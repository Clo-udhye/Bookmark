<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="./css/flexslider.css">
<script type="text/javascript" src="./js/jquery.flexslider-min.js"></script>
<style type="text/css">
ul, ol, li{ margin:0; padding:0; list-style:none;}
</style>
</head>
<body>
  <h1>첨부파일 미리보기</h1>
  <hr>
  <table border="1">
    <tr>
      <th align="center" bgcolor="orange" width="500px">첨부파일</th>
    </tr>
    <tr>
      <td align="center">
        <input type="file" name="uploadFile" id="uploadFile" multiple accept=".gif, .jpg, .png">
        <div id="slider" class="flexslider" style="width:500px; height:500px;">
        	<ul id="preview" class="slides">
        		<li><img class="default" id="profile_img1" src="./images/profile_Dahye.jpg" width=400px/></li>
        	</ul>
        </div>
      </td>
    </tr>
  </table>
  <input type="button" id="btn" value="btn"/>
</body>
<script type="text/javascript">
  $(document).ready(function (e){
	 
	  $(".flexslider").flexslider({
		  animation: "slide",
		  slideshow: false,
	  });
	  
	function flex(){
		console.log("flex");
		 $('.flexslider').flexslider({
			  animation: "slide",
			  slideshow: false,
		  });
	};
	$(document).on('click', '#btn', function(){
		let html = '<li><img id="profile_img4" src="./images/profile_Minji.jpg" width=400px/></li>'
		$('#slider').data('flexslider').addSlide($(html));
		$('#slider').data('flexslider').removeSlide($('#profile_img1'));
		//$('#preview').empty();
		
	});
	
	function removeRose() {
	    saved1 = $('#carousel').find('.rose');
	    saved2 = $('#slider').find('.rose');
	    $('#carousel').data('flexslider').removeSlide($('.rose'));
	    $('#slider').data('flexslider').removeSlide($('.rose'));
	};

	function addRose() {
	    $('#carousel').data('flexslider').addSlide(saved1);
	    $('#slider').data('flexslider').addSlide($(saved2));
	};
	
	
	  
    //$("input[type='file']").change(function(e){
	$(document).on('change',"input[type='file']", function(e){    	

      //div 내용 비워주기
     //$('#preview').empty();
       //$('#slider').data('flexslider').removeSlide($('.default'));
       //$('#slider').data('flexslider').removeSlide($('.clone'));
	
      var files = e.target.files;
      var arr =Array.prototype.slice.call(files);
      
      //업로드 가능 파일인지 체크
      for(var i=0;i<files.length;i++){
    	  console.log(files[i].name);
        if(!checkExtension(files[i].name,files[i].size)){
 
          return false;
        }
      }
      
      preview(arr);  
    });//file change
    
    function checkExtension(fileName,fileSize){
    	
    var regex1 = /^[a-zA-Z0-9_-]+\.(png|jpg|gif|bmp|PNG|JPG|GIF|BMP)$/;
    	
      var maxSize = 20971520;  //20MB
      
      if(fileSize >= maxSize){
        alert('파일 사이즈 초과');
        $("input[type='file']").val("");  //파일 초기화
        return false;
      }
      
      if(!regex1.test(fileName)){
        alert('업로드 불가능한 파일이 있습니다.');
        $("input[type='file']").val("");  //파일 초기화
        return false;
      }
     
      return true;
    }
    
    function preview(arr){
      arr.forEach(function(f){
        
        //파일명이 길면 파일명...으로 처리
        var fileName = f.name;
        if(fileName.length > 10){
          fileName = fileName.substring(0,7)+"...";
        }
        
        //div에 이미지 추가
        let str = '';
        
        //이미지 파일 미리보기
        if(f.type.match('image.*')){
          var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
          reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
            //str += '<button type="button" class="delBtn" value="'+f.name+'" style="background: red">x</button><br>';
            str += '<li><img src="'+e.target.result+'" title="'+f.name+'" width=400px /></li>';
            //$(str).appendTo('#preview');
            $('#slider').data('flexslider').addSlide($(str));
            
          } 
          reader.readAsDataURL(f);
        }else{
          str += '<img src="/resources/img/fileImg.png" title="'+f.name+'" width=100 height=100 />';
          $(str).appendTo('#preview');
        }
        
      });//arr.forEach        
    }
  });
</script>
</html>