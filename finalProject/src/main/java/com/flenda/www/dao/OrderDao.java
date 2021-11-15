package com.flenda.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.flenda.www.dto.Odr_SearchDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.RefundDto;

@Repository
public class OrderDao {
	
	@Autowired
	SqlSession session;
	
	String ns = "Order.";
	
	public int addOrder(OrdersDto order) {
		return session.insert(ns + "addOrder", order);
	}
	
	public List<OrdersDto> getList(Odr_SearchDto dto){
		return session.selectList(ns+"getList", dto);
	}

	public OrdersDto getOrder(String seq) {
		return session.selectOne(ns+"getOrder", seq);
	}
	
	public boolean addRefund(OrdersDto dto) {
		int check =  session.insert(ns+"addRefund", dto);
		return check>0?true:false;
	}
	
	public List<RefundDto> refundList(Odr_SearchDto dto) {
		return session.selectList(ns+"refundList",dto);
	}
	
	public boolean conUpdate(RefundDto dto) {
		int check = session.update(ns+"conUpdate", dto);
		
		return check>0?true:false;
	}
	
	public RefundDto getRefund(RefundDto dto) {
		return session.selectOne(ns+"getRefund", dto);
	}
	
	public boolean updateBal(RefundDto dto) {
		int check = session.update(ns+"updateBal", dto);
		return check>0?true:false;
	}
	
	public boolean updatePay(RefundDto dto) {
		int check = session.update(ns+"updatePay", dto);
		return check>0?true:false;
	}
	
	public boolean updateRsn(RefundDto dto) {
		int check = session.update(ns+"updateRsn", dto);
		return check>0?true:false;
	}
	
	public boolean delRefund(RefundDto dto) {
		int check = session.delete(ns+"delRefund", dto);
		return check>0?true:false;
	}
	
	public boolean delOrder(OrdersDto dto) {
		int check = session.delete(ns+"delOrder", dto);
		return check>0?true:false;
	}
	
	public boolean updateFinishdate(RefundDto dto) {
		int check = session.update(ns+"updateFinishdate", dto);
		return check>0?true:false;
	}
	
	public int getOrderPageCount(Odr_SearchDto dto) {
		int count = session.selectOne(ns+"getOrderPageCount", dto);
		return count;
	}
	public int getRefundPageCount(Odr_SearchDto dto) {
		int count = session.selectOne(ns+"getRefundPageCount",dto);
		return count;
	}
}
