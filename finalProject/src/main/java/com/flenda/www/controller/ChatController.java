package com.flenda.www.controller;

import java.io.StringWriter;
import java.util.List;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flenda.www.dto.ChatDto;
import com.flenda.www.dto.ChatMemberDto;
import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.MsgDto;
import com.flenda.www.service.ChatService;



@Controller
public class ChatController {
	
	@Autowired
	ChatService ChatService;

	//전체채팅룸으로 이동
	@RequestMapping(value="chat.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String chat (Model model,HttpServletRequest req) throws Exception{
		System.out.println("1");
		MemberDto login = (MemberDto)req.getSession().getAttribute("login");
		System.out.println("login 확인 : " + login);
		ChatMemberDto chatM = ChatService.getRoomMember(new ChatMemberDto(0, login.getId(), "",""));
		if(chatM ==null) {
			ChatService.addRoomMember(new ChatMemberDto(0, login.getId(), "all", "all"));
			chatM = ChatService.getRoomMember(new ChatMemberDto(0, login.getId(), "",""));
		}
		else {
			ChatService.updateRoomMember(new ChatMemberDto(0,  login.getId(), "all", "")); //room 변경
		}
		//현재 방이름 넣기(전체채팅방이니 all)
		model.addAttribute("room", "all");

		return "chating.tiles";

	}
	//방이동
	@RequestMapping(value="MoveChatRoom.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MoveChatRoom (Model model, HttpServletRequest req, String roomName) throws Exception{

		MemberDto login = (MemberDto)req.getSession().getAttribute("login");
		
		//이동하게 될 방 이름으로 수정
		ChatService.updateRoomMember(new ChatMemberDto(0, login.getId(), roomName, ""));

		List<MsgDto> list =	ChatService.getMsg(roomName);
		
		if(list.size()>0) {
			model.addAttribute("list", list);
		}
		
		//방이동 처리
		model.addAttribute("room", roomName);
		return "chating.tiles";
	}

	
	///////////////////////////////////////////////USeR////////////////////////////////////////////////////////////
	@ResponseBody
	@RequestMapping(value="chatUser.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String chatUser (Model model,HttpServletRequest req,String roomName) throws Exception{
		
		MemberDto login = (MemberDto)req.getSession().getAttribute("login");
		System.out.println("User Room Name : "+roomName);
		ChatMemberDto chatM = ChatService.getRoomMember(new ChatMemberDto(0, login.getId(), "",""));
		if(chatM ==null) {
			ChatService.addRoomMember(new ChatMemberDto(0, login.getId(),roomName,roomName));
			//추가를 한다음 chatM을 다시 받아오도록한다.
			chatM = ChatService.getRoomMember(new ChatMemberDto(0, login.getId(), "",""));
		}
		else {
			ChatService.updateRoomMember(new ChatMemberDto(0,  login.getId(),roomName, ""));
			chatM = ChatService.getRoomMember(new ChatMemberDto(0, login.getId(), "",""));
		}
		return chatM.getRoom();
	}
	
	@ResponseBody
	@RequestMapping(value="createRoom.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void createChatRoomUser (Model model, HttpServletRequest req, ChatDto chat) throws Exception{

		MemberDto login = (MemberDto)req.getSession().getAttribute("login");
		System.out.println("chat : "+ chat);
		//해당 정보로 방을 DB에 생성( 이미 방이 존재한다면 생성하지 않는다 )
		String[] cate = chat.getCategory().split("-");
		System.out.println("category : "+cate[0]);
		chat.setCategory(cate[0]);
		int check = ChatService.checkRoom(chat.getName());
		if(check == 1) {
			ChatService.createChatRoom(chat);
		}

		//현재 아이디로 만든 방의 이름으로 정보를 수정한다.
		ChatService.updateRoomMember(new ChatMemberDto(0, login.getId(), chat.getName(), ""));
	}
	
	@ResponseBody
	@RequestMapping(value="searchRoom.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String searchRoom(ChatDto dto) {

		System.out.println("dto : "+dto);

		List<ChatDto> list = ChatService.searchRoomList(dto);
		String room="0";
		for(int i=0; i<list.size(); i++) {
			room += ",";
			room += list.get(i).getName()+"/";
			room += list.get(i).getRemaincount()+"/";
			room +=	list.get(i).getTotalcount()+"/";	
			room +=	list.get(i).getCategory();
		}
		String msg = JsonRoom(room);
		return msg;
		
	}
	
	@ResponseBody
	@RequestMapping(value="delData.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void delData(String roomId) {

		System.out.println("del roomId : "+ roomId);

		ChatService.deleteMsg(roomId);
		ChatService.ChatCountDec(roomId);
		System.out.println("삭제 완료");
		
		
	}
	
    public String getRoomName(ChatDto dto) throws Exception{
    	
    	List<ChatDto> roomList =  ChatService.getRoomList();
    	String room = "0";
    	
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
	
	public String JsonRoom(String roomNames) {
		JsonObject jsonObject = Json.createObjectBuilder().add("room", roomNames).build();
		StringWriter write = new StringWriter();
		
		try(JsonWriter jsonWriter = Json.createWriter(write)){
			jsonWriter.write(jsonObject);
		};
		return write.toString();
	}
}