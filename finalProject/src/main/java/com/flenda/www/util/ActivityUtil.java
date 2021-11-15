package com.flenda.www.util;

import java.util.Date;

public class ActivityUtil {
	
	public static String getNewFileName(String f) {
		String newfilename = "";
		String fpost = "";
		
		if(f.indexOf('.') >= 0) {	// 확장자 명이 있음
			fpost = f.substring(f.indexOf('.'));		//abc.txt -> .txt
			newfilename = new Date().getTime() + fpost;	// 시스템 타임 milesecond단위 -> 3242343242.txt
		}else {
			newfilename = new Date().getTime() + ".tmp";	// 324234324.tmp
		}
		return newfilename;
	}
}
