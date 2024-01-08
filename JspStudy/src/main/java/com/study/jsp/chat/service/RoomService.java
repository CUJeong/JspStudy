package com.study.jsp.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.jsp.chat.dao.IRoomDAO;
import com.study.jsp.chat.dto.RoomDTO;

@Service
public class RoomService {

	@Autowired
	IRoomDAO dao;
	
	public List<RoomDTO> getRoomList(){
		return dao.getRoomList();
	};
	
	public RoomDTO getRoom(int roomNo) {
		return dao.getRoom(roomNo);
	};
	
	public void createRoom(RoomDTO room) {
		dao.createRoom(room);
	};
	
	
	public void deleteRoom(int roomNo) {
		dao.deleteRoom(roomNo);
	};
}
