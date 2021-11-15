package com.flenda.www.aop;

import java.util.Date;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class LogAop {
	
	@Around("within(con.flenda.www.controller.*)") // dto패키지 안에 있는 모든클래스 객체가 실행되면, 아래 메소드에 모두 들어옴
	public Object loggerAop(ProceedingJoinPoint joinpoint) throws Throwable {
		/*호출되기전*/
		
		//신호 받는다
		String signatureStr = joinpoint.getSignature().toShortString();
		
		System.out.println(signatureStr + " 시작");

		try {
		/* 호출된 후*/
			Object obj = joinpoint.proceed();	// 실행시
			
			System.out.println("loggerAop:" + signatureStr + " 메소드가 실행 " + new Date());
			
			return obj;
			
		}finally {
		//	System.out.println("실행 후:" + System.currentTimeMillis());
		//	System.out.println(signatureStr + " 종료");
		}
	}
}
