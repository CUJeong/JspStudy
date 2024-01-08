package com.study.jsp.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.jsp.chat.dto.RoomDTO;

@Mapper
public interface IRoomDAO {
	
	public List<RoomDTO> getRoomList();

	public RoomDTO getRoom(int roomNo);
	
	public int createRoom(RoomDTO room);
	
	public int deleteRoom(int roomNo);
	
}
