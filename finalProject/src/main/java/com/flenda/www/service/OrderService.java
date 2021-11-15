package com.flenda.www.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flenda.www.dao.OrderDao;
import com.flenda.www.dto.MemberDto;
import com.flenda.www.dto.Odr_SearchDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.RefundDto;

@Service
public class OrderService {
	
	@Autowired
	OrderDao dao;
	
	public String addOrder(OrdersDto order) {
		return dao.addOrder(order)>0?"success":"fail";
	}
	
	public List<OrdersDto> getList(Odr_SearchDto dto){
		return dao.getList(dto);
	}
	
	public OrdersDto getOrder(String seq) {
		return dao.getOrder(seq);
	}
	
	public boolean addRefund(OrdersDto dto) {
		return dao.addRefund(dto);
	}
	
	public List<RefundDto> refundList(Odr_SearchDto dto) {
		return dao.refundList(dto);
	}
	
	public boolean conUpdate(RefundDto dto) {
		return dao.conUpdate(dto);
	}
	
	public RefundDto getRefund(RefundDto dto) {
		return dao.getRefund(dto);
	}
	
	public boolean updateBal(RefundDto dto) {
		return dao.updateBal(dto);
	}
	public boolean updatePay(RefundDto dto) {
		return dao.updatePay(dto);
	}
	
	public boolean updateRsn(RefundDto dto) {
		return dao.updateRsn(dto);
	}
	public boolean delRefund(RefundDto dto) {
		return dao.delRefund(dto);
	}
	
	public boolean delOrder(OrdersDto dto) {
		return dao.delOrder(dto);
	}
	
	public boolean updateFinishdate(RefundDto dto) {
		return dao.updateFinishdate(dto);
	}
	
	public int getOrderPageCount(Odr_SearchDto dto) {
		return dao.getOrderPageCount(dto);
	}
	public int getRefundPageCount(Odr_SearchDto dto) {
		return dao.getRefundPageCount(dto);
	}
}
