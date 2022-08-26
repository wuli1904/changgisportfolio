<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">자유게시판</h1>
                    모든것을 자유롭게 즐기셔도 됩니다.하지만
                    <h3 style="color:red; bold:true;">선</h3>
                    을 지켜주십시오.

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                          <div style="float:left;"><h4 class="m-0 font-weight-bold text-primary">글목록</h4></div>
                          <div style="float:right;"><button id="regBtn" type="button" class="btn btn-primary">글쓰기</button></div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>수정일</th>
                                        </tr>
                                    </thead>
                                    <c:forEach items="${list}" var="board">
                                    	<tr>
                                    		<td><c:out value="${ board.bno }"/></td>
                                    		<td><a href='/board/get?bno=<c:out value="${board.bno }"/>'><c:out value="${board.title }"/></a></td>
                                    		<td><c:choose>
 											<c:when test="${board.uno > 0}"><span style="color:blue;"><c:out value="${board.writer}"/></span></c:when>
 											<c:otherwise><c:out value="${board.writer}"/></c:otherwise>
 											</c:choose></td>
                                    		<td><fmt:formatDate pattern="yyyy-MM-dd"
                                    		value="${board.regdate }"/></td>
                                    		<td><fmt:formatDate pattern="yyyy-MM-dd"
                                    		value="${board.updatedate }"/></td>
                                    	</tr>
                                    </c:forEach>
                                </table>
								<div class='row'>
									<div class="col-lg-12">
										<form id='searchForm' action="/board/list" method='get'>
											<div  style="float:left;"><select name='type'>
												<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
												<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
												<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
												<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
												<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
												<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
												<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>
											</select></div>
											<div  style="float:left;"><input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /></div>
											<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' />
											<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
											<div  style="float:left;"><button class='btn btn-primary'>검색</button></div>
										</form>
									</div>
								</div>
                                <div class='pull-right' style="float:right;">
                                	<ul class="pagination">
                                		<c:if test="${pageMaker.prev}">
                                			<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">이전</a>| 
                                			</li>
                                		</c:if>
                                		
                                		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                                			<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num }">${num}</a>|</li>
                                		</c:forEach>
                                		
                                		<c:if test="${pageMaker.next}">
                                			<li class="paginate_button next"><a href="${pageMaker.endPage +1 }">다음</a></li>
                                		</c:if>
                                	</ul>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
            <form id='actionForm' action="/board/list" method='get'>
                 <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
                 <input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
                 <input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>' />
                 <input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' />
            </form>
            <script type="text/javascript">
            	$(document).ready(function(){
            		var result = '<c:out value="${result}"/>';
            		$("#regBtn").on("click",function(){
            			self.location = "/board/register";
            		});
            		var actionForm = $("#actionForm");
            		$(".paginate_button a").on("click",function(e){
            			e.preventDefault();
            			console.log("click");
            			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            			actionForm.submit();
            		});
            		var searchForm = $("#searchForm");
            		$("#searchForm button").on("click",function(e){
            			if(!searchForm.find("option:selected").val()){
            				alert("검색종류를 알려주세요");
            				return false;
            			}
            			
            			if(!searchForm.find("input[name='keyword']").val()){
            				alert("키워드를 입력하세요.");
            				return false;
            			}
            			searchForm.find("input[name='pageNum']").val("1");
            			e.preventDefault();
            			searchForm.submit();
            		});
            	});
            </script>
            <%@ include file="../includes/footer.jsp" %>