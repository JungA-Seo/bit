package com.flenda.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.ChatDto;
import com.flenda.www.dto.ChatMemberDto;
import com.flenda.www.dto.MsgDto;

@Repository
public class ChatDao {
	
	@Autowired
	SqlSession sqlSession;
	
	String ns = "Chat.";

	
	public ChatMemberDto getRoomMember(ChatMemberDto dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(ns + "getRoomMember", dto);
	}

	
	public void addRoomMember(ChatMemberDto dto) {
		// TODO Auto-generated method stub
		sqlSession.insert(ns + "addRoomMember", dto);
	}

	
	public void updateRoomMember(ChatMemberDto dto) {
		// TODO Auto-generated method stub
		sqlSession.update(ns + "updateRoomMember", dto);
	}

	
	public ChatDto checkRoom(String cname) {
		// TODO Auto-generated method stub
		ChatDto dto = sqlSession.selectOne(ns+"getRoom", cname);
		return dto;
	}

	
	public void createChatRoom(ChatDto chat) {
		sqlSession.insert(ns+"createChatRoom", chat);
	}
	
	public List<ChatDto> getRoomList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(ns+"getRoomList");
	}

	
	public List<ChatMemberDto> sameRoomList(ChatMemberDto mem) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(ns+"sameRoomList",mem);
	}

	
	public void deleteRoomMember(ChatMemberDto mem) {
		sqlSession.delete(ns+"deleteRoomMember", mem);
	}

	
	public void updateChatCountInc(ChatDto dto) {
		sqlSession.update(ns+"updateChatCountInc", dto);
	}

	
	public void updateChatCountDec(ChatDto dto) {
		sqlSession.update(ns+"updateChatCountDec", dto);
	}
	
	public void ChatCountDec(String roomId) {
		sqlSession.update(ns+"ChatCountDec", roomId);
	}
	
	public void deleteChat() {
		sqlSession.delete(ns+"deleteChat");
	}

	
	public List<ChatDto> searchRoomList(ChatDto dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(ns+"searchRoomList", dto);
	}
	
	public boolean addMsg(MsgDto dto) {
		int check =	sqlSession.insert(ns+"addMsg", dto);
		return check>0?true:false;
	}
	
	public List<MsgDto> getMsg(String roomId){
		List<MsgDto> list = sqlSession.selectList(ns+"getMsg", roomId);
		return list;
	}
	
	public void deleteMsg(String roomId) {
		sqlSession.delete(ns+"deleteMsg",roomId);
	}	
}
