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
        
        <title>${board.boardTitle }</title>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<%@include file="/WEB-INF/inc/top.jsp"%>
        
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
                <!-- Contact Section Form-->
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-xl-7">
                        <!-- title input-->
                        <div class="mb-3">
                        	<!-- label을 일반 다른 태그에 붙이는건 이상하니 차라리 p로 변경 -->
                            <label for="title">제목</label>
                            <h6 id="title">${board.boardTitle }</h6>
                        </div>
                        <div class="mb-3">
                            <label for="name">작성자</label>
                            <h6 id="name">${board.memName }</h6>
                        </div>
                        <div class="mb-3">
                            <label for="date">날짜</label>
                            <h6 id="date">${board.boardDate }</h6>
                        </div>
                        <!-- content input-->
                        <div class="mb-3">
                        	<textarea class="form-control bg-white" style="height: 20rem" readonly>${board.boardContent }</textarea>
                        </div>
                    </div>
	                <c:if test="${sessionScope.login.memId == board.memId }">
	                	<div class="col-lg-8 col-xl-7 d-flex justify-content-end">
	                		<form action="<c:url value="/boardEditView" />" method="post">
								<input type="hidden" name="boardNo" value="${board.boardNo}" >
				                <button type="submit" class="btn btn-warning me-2" >수정</button>
							</form>
							<form action="<c:url value="/boardDelDo" />" method="post" id="delForm">
								<input type="hidden" name="boardNo" value="${board.boardNo}" >
				                <button type="button" class="btn btn-danger me-2" onclick="f_boardDel()">삭제</button>
							</form>
	                	</div>
	                </c:if>
                </div>
                
              	<form id="replyForm" action="<c:url value="/writeRepleDo" />" method="post">
          		    <div class="row justify-content-center">
          		    	<div class="row col-lg-8 col-xl-7">
	           		    	<div class="col-9">
								<input class="form-control" type="text" id="replyInput" name="replyContent">
								<input type="hidden" name="memId" value="${sessionScope.login.memId }">
	           		    	</div>
	           		    	<div class="col-3">
					              <button type="button" class="btn btn-warning me-2" onclick="f_reple()">등록</button>
	           		    	</div>
          		    	</div>
               		</div>
				</form>
                
                <div class="row justify-content-center">
     		    	<div class="col-lg-8 col-xl-7">
     		    		<table class="table">
     		    			<thead>
							    <tr>
							      <th style="width: 65%"></th>
							      <th style="width: 15%"></th>
							      <th style="width: 10%"></th>
							      <th style="width: 10%"></th>
							    </tr>
							  </thead>
							  <tbody id="replyBody">
							  	<c:forEach items="${replyList }" var="reply">
							  		<tr id="${reply.replyNo }">
							  			<td>${reply.replyContent }</td>
							  			<td>${reply.memName }</td>
							  			<td>${reply.replyDate }</td>
							  			<c:if test="${sessionScope.login.memId == reply.memId }">
							  				<!-- 차라리 f_del(this)로 하고 부모 tr에 접근해서 id를 빼다 쓰는 방식으로 변경하기 -->
							  				<td><a onclick="f_del('${reply.replyNo}')">X</a></td>
							  			</c:if>
							  		</tr>
							  	</c:forEach>
							  </tbody>
     		    		</table>
     		    	</div>
          		</div>
            </div>
        </section>

        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<%@include file="/WEB-INF/inc/bottom.jsp"%>
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script type="text/javascript">
		
			function f_boardDel(){
				if(confirm("정말로 삭제하시겠습니까?")){
					document.getElementById("delForm").submit();
				}
			}
			
			// ajax 통신으로 서버에 요청
			function f_del(p_no){
				if(confirm("정말로 삭제하시겠습니까?")){
					// XMLHttpRequest 객체 생성
					const v_ajax = new XMLHttpRequest();
					
					// HTTP 요청 준비
					v_ajax.open('POST', '<c:url value="/delRepleDo" />');
					
					// 요청 헤더 설정
					v_ajax.setRequestHeader('Content-Type', 'application/json');
					
					// 전송할 데이터 생성
					const v_data = {
						replyNo : p_no
					};
					
					const strData = 'replyNo=' + p_no;
					
					// 응답 처리
					v_ajax.onload = function() {
					  if (v_ajax.status === 200) {
					    console.log(v_ajax.responseText);
					    
					    if(v_ajax.responseText == 'success'){
						    // 성공이면 해당 댓글 태그 삭제
						    document.getElementById(p_no).remove();
					    }
					  } else {
					    console.log('Error!');
					  }
					};
	
					// 요청 전송 (뭐가 되었든 객체 자체가 요청/응답 데이터로 전달되는 경우는 없다.)
					v_ajax.send(JSON.stringify(v_data));
					//v_ajax.send(strData);
				}
				
			}
			
			function f_reple(){
				
				let v_id = '${sessionScope.login.memId }';
				console.log("v_id: " + v_id);
				
				if(!v_id){
					alert('댓글은 로그인 후 작성 가능합니다.');
					location.href = '<c:url value="/loginView" />';
				}
				
			    var xhr = new XMLHttpRequest();
			    const form = document.getElementById("replyForm");
			    
			    xhr.open("POST", form.action);
			    //xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");  // 기본값
			    xhr.setRequestHeader("Content-Type", "application/json");
			    
			    const replyVal = document.getElementById("replyInput").value;
			    console.log(replyVal);
			    
				// 전송할 데이터를 이렇게 하면 잘 들어감 (매핑도 잘됨)
 				const v_data = "replyContent=" + replyVal + "&memId=" + '${sessionScope.login.memId}';  // '' 안붙이면 memId인 b001 튀어나온거 문자열로 인식 못함
				console.log(v_data);
 				
				// 전송할 데이터 생성
				const v_json = {
					replyContent : replyVal,
					memId : '${sessionScope.login.memId}',
					boardNo : '${board.boardNo}'
				};
				console.log(v_json);
			    
			    xhr.onload = function() {
			      if (xhr.status === 200) {
			        console.log(xhr.responseText);
			        console.log(xhr.response);
/* 			        console.log(JSON.parse(xhr.response));
			        console.log(JSON.parse(xhr.response).reply);
			        console.log(JSON.parse(xhr.response).reply.replyContent);
			        console.log(JSON.parse(xhr.response).state);
			        console.log(JSON.parse(xhr.response).isSuccess); */
			        
			        console.log(JSON.parse(xhr.response).replyContent);
/* 			        if(JSON.parse(xhr.response).isSuccess){
			        	console.log('성공');
			        } */
			        const v_resp = JSON.parse(xhr.response);
			        
			        // tr의 id를 추가해주어야 함
			        let v_tr = document.createElement("tr");
			        let tdContent = document.createElement("td");
			        tdContent.innerHTML = v_resp.replyContent;
			        v_tr.appendChild(tdContent);
			        
			        let tdMemName = document.createElement("td");
			        tdMemName.innerHTML = v_resp.memName;
			        v_tr.appendChild(tdMemName);
			        
			        let tdDate = document.createElement("td");
			        tdDate.innerHTML = v_resp.replyDate;
			        v_tr.appendChild(tdDate);
			        
			        let tdDel = document.createElement("td");
			        tdDel.innerHTML = `<a onclick='f_del(this)'>X</a>`;
			        v_tr.appendChild(tdDel);
			        
			        document.getElementById("replyBody").prepend(v_tr);
			        
			      }
			    };
			    //xhr.send(v_data);
			    console.log(JSON.stringify(v_json));
			    xhr.send(JSON.stringify(v_json));   
			    
			    // 위와 같은 동작
/*   				var form = $('#replyForm');
			      var url = form.attr('action');
			      var formData = form.serialize();  // 문자열로 replyContent=dfdfdf&memId=b001 형태로 담김
			      
			      $.ajax({
			        type: 'POST',
			        url: url,
			        data: formData,
			        success: function(data) {
			          console.log(data);
			        }
			      });   */

				
			}
		
			//let v_response = JSON.parse(v_ajax.responseText);
		    //console.log(v_response);
		</script>
    </body>
</html>


