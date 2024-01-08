<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>회원 수정</title>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<%@include file="/WEB-INF/inc/top.jsp"%>
        
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
                <!-- Contact Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">회원수정</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Contact Section Form-->
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-xl-7 mb-3">
                        <form action="<c:url value="/editDo" />" method="post">
                            <!-- id input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="id" name="memId" type="text" value="${sessionScope.login.memId }" readonly="readonly"/>
                                <label for="id">ID</label>
                            </div>
                            <!-- password input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="pw" name="memPw" type="password" placeholder="변경할 비밀번호를 입력해주세요" />
                                <label for="pw">Password</label>
                            </div>
                            <!-- name input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="name" name="memName" type="text" placeholder="변경할 이름을 입력해주세요"  />
                                <label for="name">Name</label>
                            </div>
                            <!-- Submit Button-->
                            <button class="btn btn-primary btn-xl" type="submit">수정 하기</button>
                        </form>
                    </div>
                    <div class="d-flex justify-content-center">
                        <form id="delForm" action="<c:url value="/delDo" />" method="post">
                            <input class="form-control" name="memId" type="hidden" value="${sessionScope.login.memId }" />
                            <button class="btn btn-danger btn-xl" type="button" onclick="f_del()">회원탈퇴</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<%@include file="/WEB-INF/inc/bottom.jsp"%>
		
		<script type="text/javascript">
			function f_del(){
				if(confirm("정말 탈퇴하시겠습니까?")){
					document.getElementById("delForm").submit();
				}
			}
		
		</script>
    </body>
</html>


