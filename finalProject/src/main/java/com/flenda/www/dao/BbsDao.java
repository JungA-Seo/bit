package com.flenda.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.BbsDto;
import com.flenda.www.dto.BbsParam;
import com.flenda.www.dto.LikecheckDto;
import com.flenda.www.dto.ReplyDto;

@Repository
public class BbsDao {
	
	@Autowired
	SqlSession session;
	
	String namespace = "Bbs.";
	
	/* 커뮤니티 사용자 페이지 */	
	// 게시글 전체 목록
	public List<BbsDto> getBbsList(BbsParam param) {		
		return session.selectList(namespace + "getBbsList", param);
	}
	// 게시글 총 수
	public int getBbsCount(BbsParam param) {
		return session.selectOne(namespace + "getBbsCount", param);
	}
	// 게시글 작성
	public int writeBbs(BbsDto bbs) {
		return session.insert(namespace + "writeBbs", bbs);
	}
	// 하나의 게시글 읽기
	public BbsDto getBbs(int seq) {
		return session.selectOne(namespace + "getBbs", seq);
	}
	// 조회수
	public void readCount(int seq) {
		session.update(namespace + "readCount", seq);
	}
	// 좋아요 클릭
	public void likeCountUp(int seq) {
		session.update(namespace + "likeCountUp", seq);
	}
	// 좋아요 취소
	public void likeCountDown(int seq) {
		session.update(namespace + "likeCountDown", seq);
	}
	// 댓글 수 (댓글 추가 시 +1)
	public void commentCountUp(int seq) {
		session.update(namespace + "commentCountUp", seq);
	}
	// 댓글 수 (댓글 삭제 시 -1)
	public void commentCountDown(int seq) {
		session.update(namespace + "commentCountDown", seq);
	}
	// 게시글 수정
	public int updateBbs(BbsDto bbs) {
		return session.update(namespace + "updateBbs", bbs);
	}
	// 게시글 삭제
	public int deleteBbs(int seq) {
		return session.delete(namespace + "deleteBbs", seq);
	}
	// 메인 > 베스트 여행기
	public List<BbsDto> main_refer_bbs(){
		return session.selectList(namespace + "main_refer_bbs");
	}
	
	
	
	
	
	
	
	/* 게시글 좋아요 기능 */
	// 좋아요 누른 개수
	public int checkLikecheck(LikecheckDto likecheck) {	// selectOne이 맞는지?
		return session.insert(namespace + "checkLikecheck", likecheck);
	}
	
	// 좋아요 추가
	public List<LikecheckDto> getLikecheck(int seq_bbs) {
		return session.selectList(namespace + "getLikecheck", seq_bbs);
	}
	
	// 좋아요 삭제
	public int delLikecheck(LikecheckDto likecheck) {
		return session.delete(namespace + "delLikecheck", likecheck);
	}
	
	
	
	
	
	
	
	/* 댓글 기능 */
	// 전체 댓글 목록 불러오기
	public List<ReplyDto> getReplyList(int seq_bbs) {
		return session.selectList(namespace + "getReplyList", seq_bbs);
	}
	
	// 댓글 작성
	public int writeReply(ReplyDto reply) {
		return session.insert(namespace + "writeReply", reply);
	}
	
	// 수정할 댓글 불러오기
	public ReplyDto selectReply(int rseq) {
		return session.selectOne(namespace + "selectReply", rseq);
	}
	
	// 댓글 수정
	public int updateReply(ReplyDto reply) {
		return session.update(namespace + "updateReply", reply);
	}
	
	// 댓글 삭제
	
	public int deleteReply(int rseq) {
		return session.delete(namespace + "deleteReply", rseq);
	}
}
