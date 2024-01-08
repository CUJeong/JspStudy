package com.study.jsp.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.jsp.board.dao.IBoardDAO;
import com.study.jsp.board.dto.BoardDTO;
import com.study.jsp.board.dto.ReplyDTO;
import com.study.jsp.commons.Search;

@Service
public class BoardService {

	@Autowired
	IBoardDAO dao;
	
	public List<BoardDTO> getBoardList(){
		
		List<BoardDTO> result = dao.getBoardList();
		
		return result;
	}
	
	public void writeBoard(BoardDTO board) throws Exception {
		int result = dao.writeBoard(board);
		
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public BoardDTO getBoard(int boardNo) throws Exception {
		BoardDTO result = dao.getBoard(boardNo);
		
		if(result == null) {
			throw new Exception();
		}
		
		return result;
	}
	
	
	public void updateBoard(BoardDTO board) throws Exception {
		int result = dao.updateBoard(board);
		
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public void deleteBoard(int boardNo) throws Exception {
		int result = dao.deleteBoard(boardNo);
		
		if(result == 0) {
			throw new Exception();
		}
	}
	
	
	public void writeReply(ReplyDTO reply) throws Exception {
		int result = dao.writeReply(reply);
		
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public ReplyDTO getReply(String replyNo) throws Exception {
		ReplyDTO result = dao.getReply(replyNo);
		
		if(result == null) {
			throw new Exception();
		}
		return result;
	}
	
	public List<ReplyDTO> getReplyList(int boardNo){
		List<ReplyDTO> result = dao.getReplyList(boardNo);
		return result;
	}
	
	public void delReply(String replyNo) throws Exception {
		int result = dao.delReply(replyNo);
		
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public List<BoardDTO> searchBoardList(Search search){
		List<BoardDTO> result = dao.searchBoardList(search);
		
		return result;
	}
	
	
}
























