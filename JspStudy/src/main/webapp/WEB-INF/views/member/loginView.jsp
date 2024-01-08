<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>로그인</title>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<%@include file="/WEB-INF/inc/top.jsp"%>
        
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
                <!-- Contact Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">로그인</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Contact Section Form-->
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-xl-7">
                        <form action="<c:url value="/loginDo" />" method="post">
                            <!-- id input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="id" name="memId" type="text" placeholder="아이디를 입력해주세요" value="${cookie.rememberId.value }"/>
                                <label for="id">ID</label>
                            </div>
                            <!-- password input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="pw" name="memPw" type="password" placeholder="비밀번호를 입력해주세요" />
                                <label for="pw">Password</label>
                            </div>
                            <!-- password remember -->
                            <div class="form-floating mb-3">
                                아이디 기억하기 <input class="form-check-input" id="remember" name="remember" type="checkbox" ${cookie.rememberId.value == null ? "" : "checked" } />
                            </div>
	
							<!-- 어느 페이지에서 로그인 페이지로 이동해온건지 기록 -->
							<input class="form-control" name="fromUrl" type="hidden" value="${fromUrl }" />
                            <!-- Submit Button-->
                            <button class="btn btn-primary btn-xl" type="submit">로그인</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<%@include file="/WEB-INF/inc/bottom.jsp"%>
    </body>
</html>












