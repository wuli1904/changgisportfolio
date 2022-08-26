<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../includes/header.jsp" %>
 
 <div class="container-fluid">
 	<div class="card shadow mb-4">
 		<div class="card-header py-3">
 			<div class="m-0 font-weight-bold text-primary"><c:out value="${board.bno}"/>:  <c:out value="${board.title}"/><br>
 			<c:choose>
 			<c:when test="${board.uno > 0}"><p style="color:blue;">작성자: <c:out value="${board.writer}"/></p></c:when>
 			<c:otherwise>작성자: <c:out value="${board.writer}"/></c:otherwise>
 			</c:choose>
 			</div>
 			
 			<hr>
 			<div class="card-body">
 					<div class="form-group">
 							<c:out value="${board.content}"/>
 					</div>
 					<c:set var="buno" value="${board.uno }"/>
 					<c:set var="muno" value="${sessionScope.uno }"/>
 					<c:choose>
 						<c:when test="${board.uno > 0}">
 							<c:choose>
 								<c:when test="${buno eq muno}">
 									<div style="float:left;"><button data-oper='modify' class="btn btn-primary" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'" >수정하기</button></div>
 									<form role="form1" action="/board/remove" method="post">
 										    <input type="hidden" name='bno' value='<c:out value="${board.bno}"/>'>
                            				<input type="hidden" name='passwd' value='<c:out value="${sessionScope.passwd}"/>'>
 										<div style="float:left;"><button type="submit" data-oper='remove' class="btn btn-primary">삭제하기</button></div>
 									</form>
 								</c:when>
 								<c:otherwise></c:otherwise>
 							</c:choose>
 						</c:when>
 						<c:otherwise>
 							<button data-oper='modify' class="btn btn-primary" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">수정/삭제</button>
 						</c:otherwise>
 					</c:choose>
 					<div style="float:left;"><button data-oper='list' class="btn btn-info" onclick="location.href='/board/list'">메인페이지로</button></div>
 					<hr>
 					<c:choose>
                        	<c:when test="${sessionScope.idinfo == null}">
                        		<h3 style="color:red">댓글은 로그인 후 작성하실 수 있습니다.</h3>
                            </c:when>
                            <c:otherwise>
                            	<form role="form" action="/board/cinsert" method="post">
                            		<input type="hidden" name='bno' value='<c:out value="${board.bno}"/>'>
                            		<input type="hidden" name='writer' value='<c:out value="${sessionScope.idinfo}"/>'>
                               		<textarea class="form-control" rows="3" name='comnt'></textarea>
                               		<button type="submit">입력</button>
                               	</form>
                           	</c:otherwise>
                    </c:choose>
 					<c:forEach items="${commentList}" var="commentList">
 					<c:set var="str1" value="${fn:trim(sessionScope.idinfo)}"/>
        			<c:set var="str2" value="${commentList.writer}"/>
 						<p>
 						${commentList.writer } || ${commentList.comnt} <br />
 						</p>
 						<c:choose>
 							<c:when test="${str1 eq str2}">
                                <form role="form" action="/board/cdel" method="post">
 									<input type="hidden" name='bno' value='<c:out value="${commentList.bno}"/>'>
 									<input type="hidden" name='cno' value='<c:out value="${commentList.cno}"/>'>
 									<button type="submit">삭제</button>
 								</form>
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
                        <hr>
 					</c:forEach>
 			</div>
 		</div>
 	</div>
 </div>
<%@ include file="../includes/footer.jsp"%>