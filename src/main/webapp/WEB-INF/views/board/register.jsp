<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

 <div class="row">
 	<div class="col-lg-12">
 		<h1 class="page-header">글 작성</h1>
 		<hr>
 	</div>                   
 </div>
 
 <div class="container-fluid">
 	<div class="card shadow mb-4">
 		<div class="card-header py-3">
 			<div class="m-0 font-weight-bold text-primary">글자 하나가 어떤 사람에겐 하루의 기분을 바꿉니다.</div>
 			<div class="card-body">
 				<form role="form" action="/board/register" method="post">
 					<div class="form-group">
 						<c:choose>
                        	<c:when test="${sessionScope.idinfo == null}">
                                <input type="hidden" class="form-control" value=0 name='uno'>
                            </c:when>
                            <c:otherwise>
                               	<input type="hidden" class="form-control" name='uno' value='<c:out value="${sessionScope.uno}"/>'>
                           	</c:otherwise>
                        </c:choose>
 					</div>
 					<div class="form-group">
 						<label>제목</label> <input class="form-control" name='title'>
 					</div>
 					<div class="form-group">
 						<label>글내용</label>
 						<textarea class="form-control" rows="6" name='content'></textarea>
 					</div>
 					<div class="form-group">
 						<label>작성자</label>
 						<c:choose>
                        	<c:when test="${sessionScope.idinfo == null}">
                                <input class="form-control" name='writer'>
                            </c:when>
                            <c:otherwise>
                               	<input class="form-control" name='writer' value='<c:out value="${sessionScope.idinfo}"/>' readonly="readonly">
                           	</c:otherwise>
                        </c:choose>
 					</div>
 					<div class="form-group">
 						<c:choose>
                        	<c:when test="${sessionScope.idinfo == null}">
                        		<label>비밀번호</label>
                                <input type="password" class="form-control" name='passwd'>
                            </c:when>
                            <c:otherwise>
                               	<input type="hidden" class="form-control" name='passwd' value='<c:out value="${sessionScope.passwd}"/>'>
                           	</c:otherwise>
                        </c:choose>
 					</div>
 					<button type="submit" class="btn btn-primary">글작성</button>
 					<button type="reset" class="btn btn-primary">초기화</button>
 				</form>
 			</div>
 		</div>
 	</div>
 </div>
<%@ include file="../includes/footer.jsp"%>