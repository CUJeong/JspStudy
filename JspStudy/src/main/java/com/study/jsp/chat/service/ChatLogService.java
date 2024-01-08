package com.study.jsp.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.jsp.chat.dao.IChatLogDAO;
import com.study.jsp.chat.dto.ChatLogDTO;

@Service
public class ChatLogService {

	@Autowired
	IChatLogDAO dao;
	
	public List<ChatLogDTO> getChatList(int roomNo){
		
		return dao.getChatList(roomNo);
	}
	
	public void insertChat(ChatLogDTO chatLog) {
		
		dao.insertChat(chatLog);
		
	}
	
}
