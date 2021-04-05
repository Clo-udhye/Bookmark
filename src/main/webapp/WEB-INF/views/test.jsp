<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


	 
	  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="format-detection" content="telephone=no" />
<meta name="viewport" content="initial-scale=1.0,user-scalable=no,maximum-scale=1,width=device-width" />
<title>StartUp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="./css/flexslider.css">
<script type="text/javascript" src="./js/jquery.flexslider-min.js"></script>

<style>
ul, ol, li{ margin:0; padding:0; list-style:none;}
 .imgs_wrap {
        display: flex;
        flex-flow: row wrap;
        width: 100%;
        border: 1px solid gray;
        padding: 10px;
        box-sizing: content-box;
        margin-bottom: 20px;
    }
    .imgs_wrap .img_item {
        width: 150px;
        padding: 5px;
        border: 1px solid black;
        margin-right: 10px;
    }

    .imgs_wrap .img_item img {
        width: 100%;
    }

</style>
</head>
<body>
<div class="container">
    <h3>업로드 이미지 미리보기</h3>
    <div class="imgs_wrap">

    </div>
    
    <div id="slider2" as-nav-for="#slider .flexslider" style="width:500px; height:500px;">
     	<ul id="preview" class="slides">
			<li><img class="default" id="profile_img1" src="./images/profile_Dahye.jpg" width=400px/></li>
        </ul>
    </div>

    <input type="file" id="input_file" multiple />
    <input type="button" value="submit" onclick="submitAction();" />



</div>
	<!-- <script type="text/x-mustache" id="temp_item">
        <div class="img_item" id="img_item_{{ index }}">
            <img src="{{ url_src }}" />
            <input type="button" value="삭제" onclick="deleteItemAction({{ index }})" />
            <input type="hidden" class="hd_content_index" value="{{index}}" />
        </div>
    </script>
     -->
    <script>
        var contents = new Array();
        var content_files = new Array();

        $(document).ready(function() {
        	$(".flexslider").flexslider({
      		  animation: "slide",
      		  slideshow: false,
      	  });
        	
            $(document).on("change", "#input_file", function(e){
            	var files = e.target.files;
                var filesArr = Array.prototype.slice.call(files);

                let html2="";
                filesArr.forEach(function(f) {
                    if(!f.type.match("image.*")) {
                        alert("확장자는 이미지 확장자만 가능합니다.");
                        return;
                    }

                    var reader = new FileReader();
                    reader.onload = function(e) {
                    	let index = contents.length;
                        let url_src = e.target.result;
                    	
                    	var data = {
                            "index":index,
                            "url_src":url_src,
                            "is_delete":false
                        };
                        
                        contents.push(data);
                        content_files.push(f);
                        
                        console.log(contents);

                        var html ="<div class='img_item' id='img_item_"+index+"'>";
    			        html+="<img src='"+url_src+"' />";
    			        html+="<input type='button' value='삭제' onclick='deleteItemAction("+index+")' />"
                        html+="</div>";
                        
                       	html2 ="<li>";
    			        html2+="<img src='"+url_src+"' />";
    			        html2+="<input type='button' value='삭제' onclick='deleteItemAction("+index+")' />"
                        html2+="</li>";
            			
                        $(".imgs_wrap").append(html);
                        //$("#preview").append(html2);
                        $('#preview').data('flexslider').addSlide($(html2));
                        //$(".imgs_wrap").sortable();
                    }
                    reader.readAsDataURL(f);
                });

                $("#input_file").val('');
            	
            });
        });

        function submitAction() {
            var formData = new FormData();
            $(".hd_content_index").each(function(index, item){
                for(var i=0; i<contents.length; i++) {
                    var content = contents[i];
                    if(content.index == $(this).val() && content.is_delete == false) {
                        formData.append("img_"+i, content_files[i]);
                        break;
                    }
                }
            });

            var url = "/api/form/upload_images";
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: url,
                data: formData,
                processData: false,
                contentType: false,
                success: function(result) {
                    // 성공시 http status code 200
                    console.log(result);
                },
                error: function(xhr, status, error) {
                    // 실패시 http status code 200 이 아닌 경우
                    console.log(xhr);
                }
            });

        }

        function deleteItemAction(index) {
            $("#img_item_"+index).css("display","none");
            contents[index].is_delete = true;
        }

        function handleImgFileSelect(e) {
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);

            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("확장자는 이미지 확장자만 가능합니다.");
                    return;
                }

                var reader = new FileReader();
                reader.onload = function(e) {
                	let index = contents.length;
                    let url_src = e.target.result;
                	
                	var data = {
                        "index":index,
                        "url_src":url_src,
                        "is_delete":false
                    };
                    
                    contents.push(data);
                    content_files.push(f);
                    
                    console.log(contents);

                    var html ="<div class='img_item' id='img_item_"+index+"'>";
			        html+="<img src='"+url_src+"' />";
			        html+="<input type='button' value='삭제' onclick='deleteItemAction("+index+")' />"
                    html+="</div>";
                    
                    var html2 ="<li id='img_item2_"+index+"'>";
			        html2+="<img src='"+url_src+"' />";
			        html2+="<input type='button' value='삭제' onclick='deleteItemAction("+index+")' />"
                    html2+="</li>";
        			
                    $(".imgs_wrap").append(html);
                    //$("#preview").append(html2);
                    $('#preview').data('flexslider').addSlide($(html2));
                    //$(".imgs_wrap").sortable();
                }
                reader.readAsDataURL(f);
            });

            $("#input_file").val('');
        }

    </script>

</body>
</html>
