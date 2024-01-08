package com.study.jsp.member.dao;

import org.apache.ibatis.annotations.Mapper;
import com.study.jsp.member.dto.MemberDTO;

@Mapper
public interface IMemberDAO {
	public int registMember(MemberDTO member);
	public MemberDTO loginMember(MemberDTO member);
	public int editMember(MemberDTO member);
	public int delMember(String id);
}



