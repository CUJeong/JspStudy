package com.study.jsp.board.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.study.jsp.board.dto.BoardDTO;
import com.study.jsp.board.dto.ReplyDTO;
import com.study.jsp.commons.Search;

@Mapper
public interface IBoardDAO {
	public List<BoardDTO> getBoardList();
	public int writeBoard(BoardDTO board);
	public BoardDTO getBoard(int boardNo);
	public int updateBoard(BoardDTO board);
	public int deleteBoard(int boardNo);
	
	public int writeReply(ReplyDTO reply);
	public ReplyDTO getReply(String replyNo);
	public List<ReplyDTO> getReplyList(int boardNo);
	public int delReply(String replyNo);
	
	public List<BoardDTO> searchBoardList(Search search);
}




