package com.flenda.www.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flenda.www.dto.ActivityDto;
import com.flenda.www.dto.OptionDto;
import com.flenda.www.dto.OrdersDto;
import com.flenda.www.dto.PicturesDto;
import com.flenda.www.dto.ThemeDto;
import com.flenda.www.service.ActivityService;
import com.flenda.www.service.MainService;
import com.flenda.www.service.OptionService;
import com.flenda.www.service.ThemeService;

@Controller
public class OptionController {

	@Autowired
	OptionService service;
	
	@Autowired
	ThemeService tService;
	
	@ResponseBody
	@RequestMapping(value = "addOption.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String addOption(OptionDto option, String daterange) {
		System.out.println("OptionController addOption");
		System.out.println(daterange);
		String msg = "";
		msg = service.addOption(option,daterange);
		return msg;
	}
	
	@ResponseBody
	@RequestMapping(value = "addthemeOption.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String addthemeOption(OptionDto option) {
		System.out.println("OptionController addthemeOption");
		
		//'-' 를 '' 빈값으로 치환 
		option.setStartDate(option.getStartDate().replace("-", ""));
		option.setEndDate(option.getEndDate().replace("-", ""));
		System.out.println("addoption:"+ option.toString());
		
		String msg = "";
		msg = service.addthemeOption(option);
		
		int highprice = service.getMaxprice(option.getSellSeq());
		int lowprice = service.getMinprice(option.getSellSeq());
		
		tService.addhighprice(new ThemeDto(option.getSellSeq(), 0, "", highprice, 0));
		tService.addlowprice(new ThemeDto(option.getSellSeq(), 0, "", 0, lowprice));
		
		return msg;
	}
	
	@ResponseBody
	@RequestMapping(value = "getOptionList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public List<OptionDto> getOptionList(int seq) {
		System.out.println("OptionController getOptionList");
		return service.getOptionList(seq);
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteOption.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteOption(int seq) {
		System.out.println("OptionController deleteOption");
		return service.deleteOption(seq);
	}
	
	@ResponseBody
	@RequestMapping(value = "getPriceRange.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String getPriceRange(int seq) {
		System.out.println("OptionController getPriceRange");	
		return service.getMinMaxPrice(seq);
	}
}
