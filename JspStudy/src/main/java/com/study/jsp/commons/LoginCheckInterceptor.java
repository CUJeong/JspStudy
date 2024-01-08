package com.study.jsp.commons;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.study.jsp.member.dto.MemberDTO;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	// 클라이언트로부터 요청올 시 컨트롤러의 메소드보다 우선적으로 실행됨
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session= request.getSession();
		
		MemberDTO login = (MemberDTO) session.getAttribute("login"); 
		
		if(login == null) {
			// 앞에 request.getContextPath() 안붙여주면 localhost:8080/loginView로 요청 들어가버림 
			response.sendRedirect(request.getContextPath()+"/loginView");
			// 로그인 상태가 아니라면 false를 리턴해서 요청에 대한 컨트롤러단 메소드가 실행되지 않도록 함
			return false;
		}
		
		// 로그인 상태일시 true를 리턴해서 요청에 대한 컨트롤러단 메소드가 실행되도록 함
		return true;
	}
	
}
