package com.flenda.www.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flenda.www.dao.BbsDao;
import com.flenda.www.dto.BbsDto;
import com.flenda.www.dto.BbsParam;
import com.flenda.www.dto.LikecheckDto;
import com.flenda.www.dto.ReplyDto;

@Service
public class BbsService {
	
	@Autowired
	BbsDao dao;
	
	
	/* 커뮤니티 사용자 페이지 */	
	// 게시글 작성
	public String writeBbs(BbsDto bbs) {
		return dao.writeBbs(bbs)>0?"success":"fail";
	}
	// 게시글 전체 목록
	public List<BbsDto> getBbsList(BbsParam param) {
		return dao.getBbsList(param);
	}
	// 게시글 총 수
	public int getBbsCount(BbsParam param) {		
		return dao.getBbsCount(param);
	}
	// 하나의 게시글 읽기
	public BbsDto getBbs(int seq) {
		return dao.getBbs(seq);
	}
	// 조회수
	public void readCount(int seq) {
		dao.readCount(seq);
	}
	// 좋아요 클릭
	public void likeCountUp(int seq) {
		dao.likeCountUp(seq);
	}
	// 좋아요 취소
	public void likeCountDown(int seq) {
		dao.likeCountDown(seq);
	}

	// 댓글 수 (댓글 추가 시 +1)
	public void commentCountUp(int seq) {
		dao.commentCountUp(seq);
	}
	// 댓글 수 (댓글 삭제 시 -1)
	public void commentCountDown(int seq) {
		dao.commentCountDown(seq);
	}
	// 게시글 수정
	public String updateBbs(BbsDto bbs) {
		return dao.updateBbs(bbs)>0?"success":"fail";
	}
	// 게시글 삭제
	public String deleteBbs(int seq) {
		return dao.deleteBbs(seq)>0?"success":"fail";
	}
	// 메인 > 베스트 여행기
	public List<BbsDto> main_refer_bbs(){
		return dao.main_refer_bbs();
	}
	
	
	
	
	
	/* 게시글 좋아요 기능 */
	// 좋아요 누른 개수
	public String checkLikecheck(LikecheckDto likecheck) {	// selectOne이 맞는지?
		return dao.checkLikecheck(likecheck)>0?"success":"fail";
	}
	
	// 좋아요 추가
	public List<LikecheckDto> getLikecheck(int seq_bbs) {
		return dao.getLikecheck(seq_bbs);
	}
	
	// 좋아요 삭제
	public String delLikecheck(LikecheckDto likecheck) {
		return dao.delLikecheck(likecheck)>0?"success":"fail";
	}
	
	
	
	
	
	
	/* 댓글 기능 */
	//전체댓글가져오기
	public List<ReplyDto> getReplyList(int seq_bbs) {
		return dao.getReplyList(seq_bbs);
	}
	//댓글작성
	public String writeReply(ReplyDto reply) {
		// <form>태그 안에 <textarea>는 \r\n으로 인식되고
		// form태그 안에 있지않으면 \n 으로 인식됨
		reply.setReply(reply.getReply().replace("\n", "<br>"));
		
		return dao.writeReply(reply)>0?"success":"fail";	// -> 댓글쓰기 ajax의 str로 보냄 (controller에서 msg로 반환해서 보냄)
	}
	//댓글가져오기
	public ReplyDto selectReply(int rseq) {
		return dao.selectReply(rseq);
	}
	//댓글수정
	public String updateReply(ReplyDto reply) {
		return dao.updateReply(reply)>0?"success":"fail";
	}
	//댓글삭제
	public String deleteReply(int rseq) {
		return dao.deleteReply(rseq)>0?"success":"fail";
	}
}
