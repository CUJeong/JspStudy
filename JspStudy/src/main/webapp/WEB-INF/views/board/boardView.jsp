<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- model에 담긴 리스트 자바스크립트단에서 불러오기 위함  -->
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        
        <!-- Favicon-->
        <!-- 파비콘은 head 태그 안에 있어야 정상동작한다. -->
		<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/assets/favicon.ico" />
        
        <title>회원게시판</title>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<%@include file="/WEB-INF/inc/top.jsp"%>
        
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
            	<!-- 검색창 -->
            	<div class="d-flex justify-content-end" style="height: 40px">
            		<form class="d-flex" action="<c:url value="/searchBoard" />" method="GET">
            			<select class="form-select me-1" name="searchOption" aria-label="Default select example" style="width: 100px">
						  <option value="title" selected>제목</option>
						  <option value="content">내용</option>
						  <option value="name">작성자</option>
						</select>
            			<input class="form-control me-1" type="text" name="keyword" value="" style="width: 200px">
            			<button class="btn btn-primary" type="submit">
            				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
							  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
							</svg>
						</button>
            		</form>
            	</div>
            	
            	<!-- 게시글 목록 -->
            	<div>
	                <table class="table table-hover">
	                	<thead>
	                		<tr>
	                			<th>번호</th>
	                			<th>제목</th>
	                			<th>작성자</th>
	                			<th>날짜</th>
	                		</tr>
	                	</thead>
	                	<tbody>
	                		<!-- 데이터의 수만큼 반복되는 부분 -->
	                		<c:forEach items="${boardList }" var="board">
								<tr>
									<td>${board.boardNo }</td>
									<td><a href="<c:url value="/boardDetailView?boardNo=${board.boardNo }"/>">${board.boardTitle }</a></td>
									<td>${board.memName }</td>
									<td>${board.boardDate }</td>
								</tr>    
	                		</c:forEach>
	                	</tbody>
	                </table>
            	</div>
           		<!-- 페이징 화면 -->
            	<div>
            	
            	</div>
            	<!-- 글쓰기 버튼 -->
            	<div>
	               	<a href="<c:url value="/boardWriteView"/>" >
	                	<button type="button" class="btn btn-primary">글쓰기</button>
	               	</a>
            	</div>
            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<%@include file="/WEB-INF/inc/bottom.jsp"%>
		
		<script type="text/javascript">
			// Controller 에서 ArrayList를 json객체로 만들어서 보낸걸 가져와서 사용 
			let v_list = '${gsonboardList}';
			v_list = JSON.parse(v_list);
			console.log(v_list);
			console.log(v_list.length);
			console.log(v_list[0]);
			
			// 일단 ES6의 템플릿 리터럴과 EL문을 병행하는 것은 쉽지 않아보인다.
			let p_list = `\${v_list[0]}`;
			console.log(p_list);
			console.log(p_list);
		</script>
    </body>
</html>


