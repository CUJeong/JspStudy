package com.study.jsp.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.jsp.chat.dto.ChatLogDTO;

@Mapper
public interface IChatLogDAO {
	
	public List<ChatLogDTO> getChatList(int roomNo);
	
	public int insertChat(ChatLogDTO chatLog);

}
