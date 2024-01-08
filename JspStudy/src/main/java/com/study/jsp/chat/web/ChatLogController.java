package com.study.jsp.chat.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.jsp.chat.dto.ChatLogDTO;
import com.study.jsp.chat.dto.RoomDTO;
import com.study.jsp.chat.service.ChatLogService;
import com.study.jsp.chat.service.RoomService;
import com.study.jsp.member.dto.MemberDTO;

@Controller
public class ChatLogController {
	
	@Autowired
	ChatLogService chatService;
	
	@Autowired
	RoomService roomService;

	// 채팅 화면으로 이동
	@RequestMapping("/chatView")
	public String chat(Model model, int roomNo, HttpSession session) {
		
		// 로그인 안했으면 보내버림
		// 이쯤되니 로그인 체크 일일히 다는것도 지겹다..
		// com.study.jsp.commons.LoginCheckInterceptor 작성 후 servlet-context에 인터셉터 추가함
//		MemberDTO login = (MemberDTO) session.getAttribute("login");
//		if(login == null) {
//			return "member/loginView";
//		}
		
		List<ChatLogDTO> chatList = chatService.getChatList(roomNo);
		RoomDTO room = roomService.getRoom(roomNo);
		
		model.addAttribute("room", room);
		model.addAttribute("chatList", chatList);
		
		return "chat/chatView";
	}
	
	//채팅 내역 가져오기 (ajax통신용)
	@RequestMapping("/getChatList")
	@ResponseBody
	public List<ChatLogDTO> selectChatList(int roomNo) {
		List<ChatLogDTO> result = chatService.getChatList(roomNo);
		System.out.println(result);
		return result;
	}
	
	// 채팅 메세지 전달
	// chatView에서 채팅 문구 입력 후 send 버튼 누를 시 실행됨
	// return 값은 "/subscribe/chat/{roomNo}" 링크를 subscribe 중인 클라이언트로 전달 (chatView.jsp 에 client.subscribe(~~~~~) 부분)
    @MessageMapping("/hello/{roomNo}")
    @SendTo("/subscribe/chat/{roomNo}")
    public ChatLogDTO broadcasting(ChatLogDTO chat) {

    	// 채팅 문구(chat)를 DB에 저장
        chatService.insertChat(chat);
        
        // 상대방에게 전달될 chat 객체 내부에 날짜도 채워준다.
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
        chat.setSendDate(sdf.format(new Date()));
        
        // 상대방에게 전달됨
        return chat;
    }
	
	
}
