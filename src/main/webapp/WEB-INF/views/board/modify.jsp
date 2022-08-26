<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

 <div class="row">
 	<div class="col-lg-12">
 		<h1 class="page-header">글 수정</h1>
 		<hr>
 	</div>                   
 </div>
 
 <div class="container-fluid">
 	<div class="card shadow mb-4">
 		<div class="card-header py-3">
 			<div class="m-0 font-weight-bold text-primary">글자 하나가 어떤 사람에겐 하루의 기분을 바꿉니다.</div>
 			<div class="card-body">
 				<form role="form" action="/board/modify" method="post">
 					<div class="form-group">
 					 <div class="form-group">
 						<label>글번호</label> <input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
 					</div>
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
 						<label>제목</label> <input class="form-control" name='title' value="${board.title}">
 					</div>
 					<div class="form-group">
 						<label>글내용</label>
 						<textarea class="form-control" rows="6" name='content'><c:out value="${board.content}"/></textarea>
 					</div>
 					<div class="form-group">
 						<label>작성자</label>
 						<c:choose>
                        	<c:when test="${sessionScope.idinfo == null}">
                                <input class="form-control" name='writer' value="${board.writer}" readonly="readonly">
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
 					<input type="hidden" class="form-control" name='regDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}"/>' readonly="readonly">
 					<input type="hidden" class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updatedate}"/>' readonly="readonly">
 					<c:if test="${result == 'fail'}"><h3 style="color:red">비밀번호를 확인해주세요</h3></c:if>
 					<button type="submit" data-oper='modify' class="btn btn-primary">글수정</button>
 					<button type="submit" data-oper='remove' class="btn btn-primary">삭제</button>
 					<button type="submit" data-oper='list' class="btn btn-primary">메인으로</button>
 				</form>
 			</div>
 		</div>
 	</div>
 </div>
 <script type="text/javascript">
 	$(document).ready(function(){
 		var formObj = $("form");
 		$('button').on("click",function(e){
 			e.preventDefault();
 			var operation = $(this).data("oper");
 			console.log(operation);
 			
 			if(operation === 'remove'){
 				formObj.attr("action","/board/remove");
 			}else if(operation === 'list'){
 				self.location="/board/list";
 				return;
 			}
 			formObj.submit();
 		});
 	});
 </script>
<%@ include file="../includes/footer.jsp"%>