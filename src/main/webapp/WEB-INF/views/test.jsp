<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!-- Modal Header -->
<div class="modal-header">
	<h4 class="modal-title">글 작성하기</h4>
	<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>

<!-- Modal body -->
<div class="modal-body">
	<h6>Hello</h6>
</div>

<!-- Modal footer -->
<div class="modal-footer">
	<button type="button" class="btn btn-submit" data-update="modal">업로드 하기</button>
	<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
</div>


<div class="card align-middle">
	<div class="card-title">
		<h2 class="card-title text-center">Login</h2>
	</div>
	<div class="card-body">
		<form method="post">
			<h5 class="form-signin-heading">Sign in</h5>
			<label class="sr-only">Your ID</label> <input type="text" id="uid"
				class="form-control" placeholder="ID" required autofocus><BR>
			<label class="sr-only">Password</label> <input type="password"
				class="form-control" placeholder="Password" required><br>
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me">
					remember me
				</label>
			</div>
			<button class="btn btn-lg btn-primary btn-block" type="submit">Sing
				in</button>
		</form>
	</div>
</div>
