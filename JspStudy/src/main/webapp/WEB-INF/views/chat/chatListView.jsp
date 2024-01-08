<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
        
        <title>채팅방 목록</title>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<%@include file="/WEB-INF/inc/top.jsp"%>
        
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
                <table class="table table-hover">
                	<thead>
                		<tr>
                			<th>방번호</th>
                			<th>방제목</th>
                			<th>방장</th>
                			<th>생성일</th>
                		</tr>
                	</thead>
                	<tbody>
                		<!-- 데이터의 수만큼 반복되는 부분 -->
                		<c:forEach items="${roomList }" var="room">
							<tr>
								<td>${room.roomNo }</td>
								<td><a href="<c:url value="/chatView?roomNo=${room.roomNo }"/>">${room.roomName }</a></td>
								<td>${room.memName }</td>
								<td>${room.regDate }</td>
							</tr>    
                		</c:forEach>
                	</tbody>
                </table>
               	<a href="<c:url value="/roomCreateView"/>" >
                	<button type="button" class="btn btn-primary">채팅방 생성</button>
               	</a>

            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<%@include file="/WEB-INF/inc/bottom.jsp"%>
    </body>
</html>


