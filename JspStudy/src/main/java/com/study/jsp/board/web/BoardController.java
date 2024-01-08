package com.study.jsp.board.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.study.jsp.board.dto.BoardDTO;
import com.study.jsp.board.dto.ReplyDTO;
import com.study.jsp.board.service.BoardService;
import com.study.jsp.commons.Search;
import com.study.jsp.member.dto.MemberDTO;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@ExceptionHandler(Exception.class)
	public String errorView(Exception e) {
		e.printStackTrace();
		return "errorView";
	}
	
	@RequestMapping("/boardView")
	public String boardView(Model model, HttpSession session) {
		
		List<BoardDTO> boardList = boardService.getBoardList();
		 
		model.addAttribute("boardList", boardList);
		
		Gson gson = new Gson();
		model.addAttribute("gsonboardList", gson.toJson(boardList));
		
		return "board/boardView";
	}
	
	
	@RequestMapping("/boardWriteView")
	public String boardWriteView(HttpSession session) {
		
		if(session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		
		return "board/boardWriteView";	
	}
	
	
	@RequestMapping("/boardWriteDo")
	public String boardWriteDo(BoardDTO board, HttpSession session) throws Exception {
		
		// input 태그를 통해 회원이 아이디를 가져오지는 못하므로
		// 세션 객체로부터 로그인 된 회원의 아이디를 꺼내서 board 객체에 담는다.
		MemberDTO login = (MemberDTO) session.getAttribute("login");
		board.setMemId(login.getMemId());
		
		boardService.writeBoard(board);
		
		return "redirect:/boardView";	
	}
	
	// 아래부분 참고
	@RequestMapping("/boardDetailView")
	public String boardDetailView(int boardNo, Model model) throws Exception {
		
		BoardDTO board = boardService.getBoard(boardNo);
		List<ReplyDTO> replyList = boardService.getReplyList(boardNo);
		
		model.addAttribute("board", board);
		model.addAttribute("replyList", replyList);
		
		return "board/boardDetailView";
	}
	
	// css 불러오는 경로가 잘 안먹힘. css경로를 href="${pageContext.request.contextPath }/css/ 로 해야함
	@RequestMapping("/boardDetailView/{boardNo}")
	public String boardDetailView2(@PathVariable("boardNo") int boardNo, Model model) throws Exception {
									// request 객체로부터 받아오는게 아닌, URL 패턴의 boardNo로부터 가져옴
		BoardDTO board = boardService.getBoard(boardNo);
		List<ReplyDTO> replyList = boardService.getReplyList(boardNo);
		
		model.addAttribute("board", board);
		model.addAttribute("replyList", replyList);
		
		return "board/boardDetailView";
	}
	
	@RequestMapping(value="/boardEditView", method=RequestMethod.POST)
	public String boardEditView(int boardNo, Model model) throws Exception {
		
		BoardDTO board = boardService.getBoard(boardNo);
		
		model.addAttribute("board", board);
		
		return "board/boardEditView";
	}
	 
	@PostMapping("/boardEditDo")
	public String boardEditDo(BoardDTO board) throws Exception {
		
		boardService.updateBoard(board);
		
		return "redirect:/boardView";
	}
	
	@PostMapping("/boardDelDo")
	public String boardDelDo(int boardNo) throws Exception {
		
		boardService.deleteBoard(boardNo);
		
		return "redirect:/boardView";
	}
	
	@ResponseBody
	@PostMapping("/delRepleDo")
	public String delRepleDo(@RequestBody ReplyDTO reply) throws Exception {
		System.out.println(reply);
		String result = "fail";
		
		boardService.delReply(reply.getReplyNo());
		
		result = "success";
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/writeRepleDo")
//	public String boardRepleDo(@RequestBody String replyContent) {   // 바닐라로 {replyContent:aaa, memId:b001}로 보낸거 고대로 받음 (xhr.setRequestHeader("Content-Type", "application/json") / 보낼때 JSON.stringify(v_json) 로 JsonString 으로 보냄)
	public ReplyDTO boardRepleDo(@RequestBody ReplyDTO reply) throws Exception {   // 바닐라로 {replyContent:aaa, memId:b001}로 보낸거 매핑 (xhr.setRequestHeader("Content-Type", "application/json") / 보낼때 JSON.stringify(v_json) 로 JsonString 으로 보냄)
//	public ReplyDTO writeRepleDo(ReplyDTO reply) throws Exception {   // ajax j쿼리로 form.serialize() 로 만든 데이터 전송시 받음 (내부 필드 변수 알아서 매핑됨), 바닐라로 replyContent=aaa&memId=b001 로 보내면 받음 (xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"), 그냥 문자열로 보냄)
//	public String boardRepleDo(String replyContent) {	// ajax j쿼리로 form.serialize() 로 만든 데이터 전송시 받음, 바닐라로 replyContent=aaa&memId=b001 로 보내면 받음 (xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"), 그냥 문자열로 보냄)
	// 파라미터에 @RequestParam 을 써서 매핑하는건 ajax 통신시 url 에 쿼리스트링으로 붙인 데이터를 가져올 수 있는 방법임
		System.out.println(reply);
		
		// 유니크 아이디 생성
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssSSS");
		String uniqueId = sdf.format(date);
		for(int i = 0; i < 3; i++) {
			int randNum = (int)(Math.random() * 10);  // 0~9
			uniqueId += randNum;
		}
		System.out.println(uniqueId);
//		uniqueId = UUID.randomUUID().toString();
		reply.setReplyNo(uniqueId);
		
		boardService.writeReply(reply);
		
		ReplyDTO result = boardService.getReply(uniqueId);
		
		
//		Map<String, Object> result = new HashMap<>();
//		result.put("reply", new ReplyDTO("내용", "b001", "2020"));
//		result.put("state", "success");
//		result.put("isSuccess", true);
		
		// return 타입이 List 면 JSON.parse(xhr.response) 로 했을때 배열 내에 json 객체가 담겨서 온다.
		// return 타입이 Map<String, Object> 면 JSON.parse(xhr.response) 로 했을때 json 객체가 담겨서 온다. (key값으로 꺼내서 씀)
		// return 타입이 ReplyDTO 면 JSON.parse(xhr.response) 로 했을때 json 객체가 담겨서 온다. (바로 꺼내서 씀)
		return result;
	}
	
	@RequestMapping("/searchBoard")
	public String searchBoard(Search search, Model model) {
		
		System.out.println(search);
		
		List<BoardDTO> boardList = boardService.searchBoardList(search);
		
		model.addAttribute("boardList", boardList);
		
		return "board/boardView";
	}
	
	
	
} 













