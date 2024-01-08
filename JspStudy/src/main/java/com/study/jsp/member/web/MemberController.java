package com.study.jsp.member.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.study.jsp.member.dto.MemberDTO;
import com.study.jsp.member.service.MemberService;

@Controller		
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	// 일일히 try/catch를 쓰지 않아도 된다.
	// web.xml에 설정한 error-page보다 우선순위로 동작함
	@ExceptionHandler(Exception.class)
	public String errorView(Exception e, Model model) {
		e.printStackTrace();
		model.addAttribute("errMsg", e.getMessage());
		return "errorView";
	}

	@RequestMapping("/registView")
	public String registView() {
		
		return "member/registView";
	}
	
	
	@RequestMapping("/registDo")
	public String registDo(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		
		System.out.println("id = " + id);
		System.out.println("pw = " + pw);
		System.out.println("name = " + name);
		
		MemberDTO member = new MemberDTO(id, pw, name);
		try {
			memberService.registMember(member);
		} catch (Exception e) {
			e.printStackTrace();
			return "errorView";
		}
		
		// 이후 로그인 화면 구현 후 거기로 이동시키기
		return "redirect:/";
	}
	
	
	@RequestMapping("/loginView")
	public String loginView(HttpServletRequest request, Model model) {
		
        // 현재 request 객체의 요청이 어느 URL로부터 요청되었는지
        String requestFromUrl = request.getHeader("Referer");
        model.addAttribute("fromUrl", requestFromUrl);
		
		return "member/loginView";
	}
	
	
//	public String loginDo(HttpServletRequest request)
//	public String loginDo(String id, String pw, String name)
	@RequestMapping("/loginDo")
	public String loginDo(MemberDTO member, HttpSession session, boolean remember, String fromUrl
			, HttpServletResponse response) throws Exception {
		
		System.out.println(member);
		System.out.println(remember);
		
		MemberDTO login = memberService.loginMember(member);
		
		session.setAttribute("login", login);
		
		if(remember) {
			// 쿠키 생성
			Cookie cookie = new Cookie("rememberId", member.getMemId());
			// 응답하는 객체에 붙여준다.
			response.addCookie(cookie);
		}else {
			// 쿠키 삭제 (동일한 key값을 가지는 쿠키를 생성 후 유효기간을 0으로 만든다)
			Cookie cookie = new Cookie("rememberId", "");
			cookie.setMaxAge(0);
			
			// 유효기간 0짜리인 쿠키를 응답하는 객체에 붙여준다.
			response.addCookie(cookie);
		}
		
		System.out.println(login);
		// 로그인시 해당 페이지로 들어가기
		return "redirect:" + fromUrl;
	}
	
	@RequestMapping("/logoutDo")
	public String logoutDo(HttpSession session, HttpServletRequest request) {
		
		// 세션 종료
		session.invalidate();
		
		// 현재 request 객체의 요청이 어느 URL을 바라보는지
        String requestToUrl = request.getRequestURL().toString();
        // 현재 request 객체의 요청이 어느 URL로부터 요청되었는지
        String requestFromUrl = request.getHeader("Referer");
        System.out.println("requestToUrl : " + requestToUrl);  // http://localhost:8080/jsp/logoutDo
        System.out.println("requestFromUrl : " + requestFromUrl); // 회원게시판에서 로그아웃을 했다면 http://localhost:8080/jsp/boardView
		
        // 로그아웃시 해당 페이지에 머무르기
		return "redirect:" + requestFromUrl;
	}
	
	@RequestMapping("/editView")
	public String editView() {
		return "member/memberEditView";
	}
	
	@PostMapping("/editDo")
	public String editDo(MemberDTO member, HttpSession session) throws Exception {
		
		memberService.editMember(member);
		
		// 세션 종료
		session.invalidate();
		
		return "redirect:/";
	}
	
	@PostMapping("/delDo")
	public String delDo(String memId, HttpSession session) throws Exception {
		
		memberService.delMember(memId);
		
		// 세션 종료
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	
	
	
}












