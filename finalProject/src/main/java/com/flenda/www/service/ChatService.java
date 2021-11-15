package com.flenda.www.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flenda.www.dao.ChatDao;
import com.flenda.www.dto.ChatDto;
import com.flenda.www.dto.ChatMemberDto;
import com.flenda.www.dto.MsgDto;

@Service
public class ChatService  {

	@Autowired
	ChatDao projectChatDao;	
	
	
	public int checkRoom(String name) {
		
		ChatDto dto =  projectChatDao.checkRoom(name);
			int msg = 0;
			if(dto==null) {
				msg = 1;
			}
		return msg;
	}

	
	public void createChatRoom(ChatDto dto) {
		projectChatDao.createChatRoom(dto);
	}

	
	public List<ChatDto> getRoomList() {
		return projectChatDao.getRoomList();
	}

	
	public void addRoomMember(ChatMemberDto mem) {
		projectChatDao.addRoomMember(mem);
	}

	
	public ChatMemberDto getRoomMember(ChatMemberDto mem) {
		return projectChatDao.getRoomMember(mem);
	}

	
	public List<ChatMemberDto> sameRoomList(ChatMemberDto mem) {
		return projectChatDao.sameRoomList(mem);
	}

	
	public void updateRoomMember(ChatMemberDto mem) {
		projectChatDao.updateRoomMember(mem);
	}

	
	public void deleteRoomMember(ChatMemberDto mem) {
		projectChatDao.deleteRoomMember(mem);
	}

	
	public void updateChatCountInc(ChatDto dto) {
		projectChatDao.updateChatCountInc(dto);
	}

	
	public void updateChatCountDec(ChatDto dto) {
		projectChatDao.updateChatCountDec(dto);
	}
	public void ChatCountDec(String roomId) {
		projectChatDao.ChatCountDec(roomId);
	}

	
	public void deleteChat() {
		projectChatDao.deleteChat();
	}

	
	public List<ChatDto> searchRoomList(ChatDto dto) {
		return projectChatDao.searchRoomList(dto);
	}
	
	public boolean addMsg(MsgDto dto) {
		return projectChatDao.addMsg(dto);
	}
	
	public List<MsgDto> getMsg(String roomId){
		return projectChatDao.getMsg(roomId);
	}
	
	public void deleteMsg(String roomId) {
		 projectChatDao.deleteMsg(roomId);
	}
}