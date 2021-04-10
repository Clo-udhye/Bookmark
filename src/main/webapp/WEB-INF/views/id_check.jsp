<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div >
	<div class="modal-header">
        <h2 class="modal-title">아이디 찾기</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
    	<div style="padding-left:2%; padding-top:2%;" class="fs-5"> 가입 시, 입력한 이메일을 입력해주세요</div>
		<div style="padding-left:3%; color:blue;" class="fs-7"> * 네이버 로그인을 이용한 경우, 네이버에서 아이디를 찾을 수 있습니다.</div>
		<div style="padding:2%">
			<input type="text" size="12" id="mail_1"/>
			<span>&nbsp; @ &nbsp;</span>
			<input type="text" size="15" id="mail_2" />
    	</div>
    	<div style="padding-left:2%; padding-right:10%">
	    	<div class="shadow p-3 mb-5 bg-body rounded" style="padding:5%;" align="center">
	    		확인된 아이디는 <span class="fs-4" style="color:blue; border-bottom: solid blue 1px;">&nbsp;yc0191&nbsp;</span> 입니다.
	   		</div>
   		</div>
    </div >
    <div class="modal-footer" style="margin-top:-3%;">
    	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
    	<button type="button" class="btn btn-primary">찾기</button>
    </div>
</div>