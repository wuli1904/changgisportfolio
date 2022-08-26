<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
	 <div class="row">
 	<div class="col-lg-12">
 		<h1 class="page-header">회원가입</h1>
 		<hr>
 	</div>                   
 </div>
 
 <div class="container-fluid">
 	<div class="card shadow mb-4">
 		<div class="card-header py-3">
 			<div class="card-body">
 				<form role="form" action="/board/lregister" method="post">
 					<div class="form-group">
 						<label>아이디</label>
 						<input class="form-control" name='idinfo'>
 					</div>
 					<div class="form-group">
 						<label>비밀번호</label>
 						<input type="password" class="form-control" name='passwd'>
 					</div>
 					<div class="form-group">
 						<label>비밀번호 확인</label>
 						<input type="password" class="form-control" name='passwdc'>
 					</div>
 					<button type="submit" class="btn btn-primary">회원가입</button>
 				</form>
 			</div>
 		</div>
 	</div>
 </div>
<%@ include file="../includes/footer.jsp"%>