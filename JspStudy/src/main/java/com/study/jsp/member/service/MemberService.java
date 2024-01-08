package com.study.jsp.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.jsp.member.dao.IMemberDAO;
import com.study.jsp.member.dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired
	IMemberDAO dao;
	
	public void registMember(MemberDTO member) throws Exception {
		int result = dao.registMember(member);
		
		if(result == 0) {
			throw new Exception("회원등록 중 에러가 발생하였습니다.");
		}
	}
	
	public MemberDTO loginMember(MemberDTO member) throws Exception {
		MemberDTO result = dao.loginMember(member);
		
		System.out.println(result);
		
		// WHERE 절에 잡히는게 없으면 그냥 null이 들어오고 에러는 발생하지 않기 때문에
		// 수동으로 에러를 발생시켜준다.
		if(result == null) {
			throw new Exception("아이디 혹은 비밀번호가 틀립니다.");
		}
		
		return result;
	}
	
	
	public void editMember(MemberDTO member) throws Exception {
		int result = dao.editMember(member);
		
		if(result == 0) {
			throw new Exception();
		}
	}
	
	
	public void delMember(String memId) throws Exception {
		int result = dao.delMember(memId);
		
		if(result == 0) {
			throw new Exception();
		}
	}
}










