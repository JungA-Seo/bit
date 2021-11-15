package com.flenda.www.websocket;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.flenda.www.dto.ChatDto;
import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.MsgDto;
import com.flenda.www.dto.ChatMemberDto;
import com.flenda.www.service.ChatService;

public class WebSocket extends TextWebSocketHandler{
	
	//Service접근 (db 처리를 하기위해 )
		@Autowired
		ChatService ChatService;

		//서버에 연결된 사용자들을 저장하기위해 선언
		private List<WebSocketSession> sessionList = new ArrayList<>(); //메세지를 날려주기위한 웹소켓전용 세션
		private Map<WebSocketSession, String> mapList = new HashMap<>(); //실제session의 아이디정보, web소켓정보
		private Map<WebSocketSession,String> roomList = new HashMap<>(); //실제 session의 아이디정보,  room정보
		private Map<WebSocketSession,MsgDto> msgList = new HashMap<>(); // room num , 카테고리 
		private List<String> userList = new ArrayList<>(); //접속자 명단을 개개인별로 뿌려주기위해 선언한 일반리스트
		
	    //연결되었을때
	    @Override
	    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    	System.out.println(session);
	    	//1. 들어온 사람의 실제 로그인 아이디 정보를 가져온다.
	    	Map<String, Object> map = session.getAttributes();
	    	MemberDto mem = (MemberDto)map.get("login");
	    	String userId = mem.getId();
	    	
	    	//2. 들어온 아이디로 어느 방에 있는 지 확인한다.
	    	ChatMemberDto userRoom = ChatService.getRoomMember(new ChatMemberDto(0, userId, "",""));
	    	//3. 들어온 아이디로 찾은 방이름을 웹소켓 세션에 추가
	    	roomList.put(session, userRoom.getRoom());
	    	System.out.println(userId+"님이 "+userRoom.getRoom()+" 방에 들어왔습니다.");
	    	
	    	//4. 이전 방 정보 DB에서 수정하기
	    	String priroom = userRoom.getRoom();
	    	ChatService.updateRoomMember(new ChatMemberDto(0, userId, "", priroom));
	     	
	    	//4. mapList(해당세션의 실제아이디 값을 저장하기위해 map으로 저장)
	    	mapList.put(session,userId); //세션:key, 유저아이디:value
	    	
	    	//5. map을 사용하지않아도 될경우를 위해서 session값도 넣도록함
	    	sessionList.add(session); //세션의 값 넣기(session : id=0~ , url:/ 주소/ echo.do)
	    	
	    	//6. 입장 시 해당 방 인원 수를 증가시킨다.
	    	ChatService.updateChatCountInc(new ChatDto(0, userRoom.getRoom(),0, 0,""));


	    	//7. 모든유저들에게 서로다른 메시지를 전달하기위해 전체적으로 for문을 돌리도록한다.
	    	for(int i=0; i<sessionList.size(); i++) { 
	    		
	    		//8. 해당 i번째 사람(sessionList.get(i) 의 방이름정보를 가져온다.
	    		// 웹소켓세션아이디가 저장된 sessionList를 이용해서 방정보를 가져옴
	    		String roomName = roomList.get(sessionList.get(i));
	    		
	    		//9. 접속자가 속한 방에만 접속했음을 알린다.
				/*
				 * if(userRoom.getRoom().equals(roomName)) { sessionList.get(i).sendMessage(new
				 * TextMessage(""+JsonDataOpen(userId))); }
				 */
	    		
	    		//12. 방리스트를 모든 사람들에게 보내줌
	    		String roomNames = getRoomName();
	    		sessionList.get(i).sendMessage(new TextMessage(JsonRoom(roomNames)));
	    		}
	    	//13. 없는방에대해서 삭제처리를 한다.
	    	ChatService.deleteChat();
	    }
	    
	  //통신 연결끊었을때실행
	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	  
	    	//1. 현재 접속한 사람의 로그인한 id정보를 가져온다.
	        Map<String, Object> map = session.getAttributes();
	     	MemberDto mem = (MemberDto)map.get("login");
	     	String userId = mem.getId();
	     	
	    	//2. 접속을끊을 때 해당 아이디로 DB에서 어느 방에 존재하는지 확인한다.
	     	ChatMemberDto member = ChatService.getRoomMember(new ChatMemberDto(0, userId, "", ""));
	     	  
	    	//System.out.println("접속 끊기 이전 방:"+member.getPriroom()+"끊은 사람 아이디 :"+userId);
	    	
	    	//3. 해당유저의 roomList, mapList, sessionList를 제거한다( 미리 제거를 해야만 본인 제외한 모든사람들에게 본인의 정보를 날려줄수있기때문)
	    	roomList.remove(session);
	    	mapList.remove(session); //세션:key, 유저아이디:value
	    	sessionList.remove(session); // 실제 websocket 세션명 		
	    	//4. 이전 방에서 인원수를 감소시킨다. (이전방정보로 지우기)
	    	ChatService.updateChatCountDec(new ChatDto(0, member.getPriroom(), 0, 0,""));
	    	
	 	
	    	//4. 본인 제외하고 본인이 있던방의 모든사람들에게 나갔음을 알림
	    	// 이유 : 해당 아이디가 이전의 있던 방에만 데이터를 전달할경우, 해당아이디가 없었던 방의 데이터는 전달이 안되고 아무정보도 들어오지않기때문
	    	for(int i=0; i<sessionList.size(); i++) {
	    		
	    		//5. 해당 i번째 사람(sessionList.get(i) 의 방이름정보를 가져온다.
//	    		String roomName = roomList.get(sessionList.get(i)); //i번째사람의 방이름이 저장되어있다.

	    		//6. sesionList.get(i).getId() 사람이 속한 방에만 전달하도록 설정한다.
	    		Iterator<WebSocketSession> roomIds = roomList.keySet().iterator(); //현재 존재하는 roomList를 가져온다.
	    		//map이기때문에 iterator를 사용하여 while문을 동작시킨다.
	    		while(roomIds.hasNext()) { 
	        		WebSocketSession roomId = roomIds.next(); //roomId : 실제 세션명
	        		String value = roomList.get(roomId); // value : 방이름
	        		
	        		//7. 같은 방에 있었던사람에게만 ~님이 퇴장했습니다 라고 데이터를 날려주도록한다.
	        		if(member.getPriroom().equals(value)) {
	        			roomId.sendMessage(new TextMessage(JsonDataClose(userId)));
	        		}
	        	}

	    		//9. 방리스트를 모든 사람들에게 보내줌
	    		String roomNames = getRoomName();
	    		sessionList.get(i).sendMessage(new TextMessage(JsonRoom(roomNames)));
	    	}
	    }
	  //서버가 클라이언트로부터 메시지를 받았을때
	    @Override //WebSocketMessage<?>
	    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    	
	    	//1. 회원정보 가져오기
	    	Map<String, Object> map = session.getAttributes();
	    	MemberDto mem = (MemberDto)map.get("login");
	    	String userId = mem.getId();
	    	
	    	
				//2. 문자열 형태 : 문자 !%/ 대상 !%/ 방이름
				System.out.println(message.getPayload());
				
				//3. 배열선언(split을 이용해서 문자열을 자른다)
				String msgArr[] = message.getPayload().split("!%/"); // %!로 문자를 잘라서 배열에저장
				
				//4. [0]: 유저가 보낸 메시지, [1]:방의 이름
				System.out.println("보낸메시지:"+msgArr[0]+", 방의이름:"+msgArr[1]+"user인지 admin인지"+msgArr[2]);
				MsgDto save = new MsgDto(0,msgArr[1],msgArr[0],msgArr[2],"");
				boolean check = ChatService.addMsg(save);
					if(check) {
						System.out.println("저장 성공");
						}
					List<MsgDto> getMsg = ChatService.getMsg(msgArr[1]);
					for(int i =0; i<getMsg.size(); i++) {
						MsgDto msg = getMsg.get(i);
						msgList.put(session,msg);
					}
					
					for (WebSocketSession wst : sessionList) {
						//같은방일때만 보냄
						if(msgArr[1].equals(roomList.get(wst))) {
							//만약 자신의 세션아이디와 다르다면 메세지를 아래와같이 전달(자기자신한테는 보낼필요가없기때문)
			        		if(!session.getId().equals(wst.getId())) {
			        			wst.sendMessage(new TextMessage(JsonData(userId, msgArr[0])));
			        		}
			        		
						}  		
					}
	    	}
	  //json형태로 메세지 변환(일반 메세지 보낼 때)
	    public String JsonData(String id, Object msg) {
	    	JsonObject jsonObject = Json.createObjectBuilder().add("message", 
	    			"<div class='chat__response'><p class='chat__response__text'>"+msg+"</p></div>").build();
	    	StringWriter write = new StringWriter();
	    	
	    	try(JsonWriter jsonWriter = Json.createWriter(write)){
	    		jsonWriter.write(jsonObject);
	    	};
	    	return write.toString();
	    }
	    
	    public String JsonData(MsgDto dto) {
	    	System.out.println("JsonData Message 확인 : "+dto.getMsg());
	    	JsonObject jsonObject = Json.createObjectBuilder().add("firstMsg", 
	    			"<div class='chat__response'><p class='chat__response__text'>"+dto.getMsg()+"</p></div>").build();
	    	StringWriter write = new StringWriter();
	    	
	    	try(JsonWriter jsonWriter = Json.createWriter(write)){
	    		jsonWriter.write(jsonObject);
	    	};
	    	return write.toString();
	    }
	    
	    //json형태로 메세지 변환2( 접속했음을 알릴때)
/*	    public StringWriter JsonDataOpen(String id) {
	    	JsonObject jsonObject = Json.createObjectBuilder().add("message",
	    			"<p>"+"<b>["+ 
	    id+"]</b> 님이 <b style='color:blue'>접속</b>하셨습니다.</p>").build();
	    	StringWriter write = new StringWriter();
	    	
	    	try(JsonWriter jsonWriter = Json.createWriter(write)){
	    		jsonWriter.write(jsonObject);
	    	};
	    	return write;
	    }*/
	    //json형태로 메세지 변환3( 나갔음을 알릴때)
	    public String JsonDataClose(String id) {
	    	JsonObject jsonObject = Json.createObjectBuilder().add("message","<b>["+ id+"]</b> 님이 채팅을 종료하셨습니다.").build();
	    	StringWriter write = new StringWriter();
	    	
	    	try(JsonWriter jsonWriter = Json.createWriter(write)){
	    		jsonWriter.write(jsonObject);
	    	};
	    	return write.toString();
	    	
	    }

	   	//json형태로 방 정보 날리기
	    public String JsonRoom(String roomNames) {
	    	JsonObject jsonObject = Json.createObjectBuilder().add("room", roomNames).build();
	    	StringWriter write = new StringWriter();
	    	
	    	try(JsonWriter jsonWriter = Json.createWriter(write)){
	    		jsonWriter.write(jsonObject);
	    	};
	    	return write.toString();
	    }
	    
	    
	    //DB로부터 존재하는 방정보 String 형태로 가져오기
	    public String getRoomName() throws Exception{
	    	
	    	List<ChatDto> roomList =  ChatService.getRoomList();
	    	String room = sessionList.size()+"";
	    	
	    	for(int i=0; i<roomList.size(); i++) {
	    		room += ",";
	    		room += roomList.get(i).getName() +"/";
	    		room += roomList.get(i).getRemaincount()+"/";
	    		room += roomList.get(i).getTotalcount()+"/";
	    		room += roomList.get(i).getCategory();
	    	}
	    	System.out.println("getRoomName : " + room);

	    	return room;
	    	
	    }
	    
	    public String getRoomName(ChatDto dto) throws Exception{
	    	
	    	List<ChatDto> roomList =  ChatService.searchRoomList(dto);
	    	
	    	String room = sessionList.size()+"";
	    	//검색했는데 방이 없을 경우
		    	for(int i=0; i<roomList.size(); i++) {
		    		room += ",";
		    		room += roomList.get(i).getName() +"/";
		    		room += roomList.get(i).getRemaincount()+"/";
		    		room += roomList.get(i).getTotalcount()+"/";
		    		room += roomList.get(i).getCategory();
	    		}

	    	System.out.println("getRoomName room : "+ room);
	    	return room;
	    	
	    }
	    

}