<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(document).ready(function(){	  
	  $('#ok').click(function(){
		  console.log($('#address_select').val());
		 $('#address').val($('#address_select').val());
	  });
	});
</script>  

      <div class="modal-header">
        <h5 class="modal-title">우편번호 검색하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="text" placeholder="주소" id="address_select" name="address" maxlength="20">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="ok">확인</button>
      </div>