package com.study.jsp.board.dto;

public class ReplyDTO {
	private String replyNo;
	private int boardNo;
	private String replyContent;
	private String memId;
	private String memName;
	private String replyDate;
	
	public ReplyDTO() {}

	public ReplyDTO(String replyNo, int boardNo, String replyContent, String memId, String memName, String replyDate) {
		super();
		this.replyNo = replyNo;
		this.boardNo = boardNo;
		this.replyContent = replyContent;
		this.memId = memId;
		this.memName = memName;
		this.replyDate = replyDate;
	}

	@Override
	public String toString() {
		return "ReplyDTO [replyNo=" + replyNo + ", boardNo=" + boardNo + ", replyContent=" + replyContent + ", memId="
				+ memId + ", memName=" + memName + ", replyDate=" + replyDate + "]";
	}

	public String getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(String replyNo) {
		this.replyNo = replyNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	
}	
