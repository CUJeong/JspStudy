<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        
        <!-- Favicon-->
        <!-- 파비콘은 head 태그 안에 있어야 정상동작한다. -->
		<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/assets/favicon.ico" />
        
        <title>채팅</title>
        
        <style>
			.chat-containerK {
				/* overflow: hidden; */
				width : 100%;
				/* max-width : 200px; */
			}
			
			.chatcontent {
				height: 700px;
				width : 100%;
				/* width:300px; */
				overflow-y: scroll;
			}
			
			.chat-fix {
				position: fixed;
				bottom: 0;
				width: 100%;
			}
			
			#alertK{
				display : none;
			}
			#msgi{	
				resize: none;
			}
			.myChat{
				background-color : #E0B1D0;
			}
			li{
				list-style-type:none;
			}
			.chatBox{
				display : inline-block;
			}
			.chatBox dateK{
				vertical-align: text-bottom;
			} 
			.me{
				text-align : right;
				/* text-align:center; */
			}
			.chat-box{
				max-width : 200px;
				display: inline-block;
				border-radius: 15px;
			}
		</style>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<%@include file="/WEB-INF/inc/top.jsp"%>
        
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
                <div id="chat-containerK">

					<div class="chatWrap">
				
						<div class="main_tit">
							<h1>방 정보: [ ${room.roomNo}번방 ${room.roomName } ] </h1>
						</div>
						<div class="content chatcontent border border-secondary" data-room-no="${room.roomNo}" >
							<div id="list-guestbook" class="">
								<c:forEach items="${chatList}" var="chat">
									<!-- 내 채팅일 경우 -->
									<c:if test="${sessionScope.login.memId  eq chat.memId}">
										<li data-no="${chat.chatNo}" class="me pr-2">
											<strong class="">${chat.memName}</strong>
											<div class="me">
												<strong style="display : inline;" class="align-self-end">${chat.sendDate }</strong>
												<p class='myChat chat-box text-left p-3'>${chat.chatMsg }</p>
											</div>
										</li>
									</c:if>
									<!-- 다른사람의 채팅일 경우 -->
									<c:if test="${sessionScope.login.memId ne chat.memId}">
										<li data-no="${chat.chatNo}" class="pl-2">
											<strong>${chat.memName}</strong>
											<div>
												<p class='chat-box bg-light p-3'>${chat.chatMsg }</p>
												<strong style="display : inline;" class="align-self-center">${chat.sendDate }</strong>
											</div>
										</li>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<div>
							<div class="d-flex justify-content-center" style="height: 60px">
								<input type="text" id="msgi" name="msg" class="form-control" style="width: 75%; height: 100%">
								<button type="button" id="btnSend" class="send btn btn-secondary " style="width: 25%; height: 100%">보내기</button>
							</div>
						</div>
				
					</div>
				</div>
				
            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<%@include file="/WEB-INF/inc/bottom.jsp"%>
		
		<!-- moment()함수, 제거해보기 -->
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/dist/sockjs.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
		
		<script>
			var client;
			
			// 페이지 로드 완료시 실행
			$(document).ready(function() {
				// 채팅창 스크롤 내리기
				$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
				
				var isEnd = false;
				var isScrolled = false;
			
				// 채팅으로 전달받은 데이터를 화면에 그려줌
				function renderList(vo){
					// 날짜 포맷
					var date = vo.sendDate;
					var html = "";
					var content ="";
					
					//내가 보낸 채팅일 경우
					if(vo.memId=="${sessionScope.login.memId }"){
						content = "<p class='myChat chat-box text-left p-3'>"+vo.chatMsg+"</p>";
					
						html = 	"<li class='me pr-2'>"
							+ "<strong>" + vo.memName + "</strong>"
							+"<div class='me'>"
							+ "<strong style='display : inline;' class='align-self-end'>" + date + "</strong>"
							+ content
							+"</div>"
							+ "</li>";
					}else{
						// 다른 사람의 채팅
						content = "<p class='chat-box bg-light p-3'>"+vo.chatMsg+"</p>";
						
						html = "<li class='pl-2'>"
							+ "<strong>" + vo.memName + "</strong>"
							+"<div>"
							+ content
							+ "<strong style='display : inline;' class='align-self-center'>" + date + "</strong>"
							+"</div>"
							+ "</li>";
					}
					return html;
				}
				
			
				// socket 관련
				var chatBox = $('.box');
				var messageInput = $('#msgi');
				var roomNo = "${room.roomNo}";
				var member = $('.content').data('member');
				
				// 소켓 통신 객체 생성
				var sock = new SockJS("${pageContext.request.contextPath}/endpoint");
				client = Stomp.over(sock);
		
				// 메시지 전송
				function sendmsg() {
					var message = messageInput.val();

					if (message == "") {
						return false;
					}
				
					// 실질적으로 메시지 전달하는 시점과 그 데이터
					client.send('/app/hello/' + roomNo, {}, 
							JSON.stringify({
								chatMsg : message,
								memId : "${sessionScope.login.memId }",
								memName : "${sessionScope.login.memName }",
								roomNo : "${room.roomNo}"
							}));
		
					messageInput.val('');
				}
				
				// 연결이 맺어지면 실행
				client.connect({},function() {
					// 상대방이 보낸 메세지 전달 받을 시 실행         
					client.subscribe('/subscribe/chat/'+ roomNo, function(chat) {
						// 받은 데이터
						var content = JSON.parse(chat.body);
						
						// 받은 데이터를 그려줄 html 코드
						var html = renderList(content);
						$("#list-guestbook").append(html);
						$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
					});
		
				});
				
				// 메시지 전송 버튼 클릭시
				$('#btnSend').click(function() {
					sendmsg();
				}); 
				
				// 채팅 입력하다 엔터 쳤을 때
				$('#msgi').keydown(function(e) {
					// 엔터키 keyCode = 13
					if(e.keyCode == 13){
						sendmsg();
					}
				}); 
		
				//채팅창 떠날시 소켓 통신 종료
				function disconnect() {
					if (client != null) {
						client.disconnect();
					}
				}
				
				// 현재 창을 벗어나기 직전에 실행됨
				window.onbeforeunload = function(e) {
					disconnect();
				}
				
				// 소켓 닫는거같은데 실제로 사용이 되는지는 모르겠음
				function closeConnection() {
					sock.close();
				}
			
			
			});
			
		</script>
		
    </body>
</html>


