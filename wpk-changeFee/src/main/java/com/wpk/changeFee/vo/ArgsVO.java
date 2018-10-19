package com.wpk.changeFee.vo;

/**
 * @class   : ArgsVO
 * @file    : ArgsVO.java
 * @package : wpk.changeFee.service
 * @author  : user
 * @date    : 2017. 12. 8.
 * @see <pre>
 * 
 *  == 개정이력 ==
 * 
 *  수정일         수정자         수정내용
 *  -------        --------       ---------------------------
 *  2017. 12. 8.   jeremy         최초 생성
 * 
 * </pre>
 *  Copyright (C) by WilsonParkingKorea All right reserved.
 */
public class ArgsVO {
	
	public final String MESSAGE_SUCCESS = "SUCCESS";
	public final String MESSAGE_FAIL = "FAIL";
	public final String CALL_TYPE_PERM = "P";
	public final String CALL_TYPE_DAY_WEEK = "D";
	
	/** 반환 메세지 */
	private String message = "";
	
	/** 정기권 요일별 구분 파라메터 */
	private String callType = "";
	
	/** 외부 프로그램 호출 파라메터 */
	protected String args_01 = "";
	
	/** 외부 프로그램 호출 파라메터 */
	private String args_02 = "";
	
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	
	/**
	 * @return the callType
	 */
	public String getCallType() {
		return callType;
	}
	
	/**
	 * @param callType the callType to set
	 */
	public void setCallType(String callType) {
		this.callType = callType;
	}
	
	/**
	 * @return the args_01
	 */
	public String getArgs_01() {
		return args_01;
	}
	
	/**
	 * @param args_01 the args_01 to set
	 */
	public void setArgs_01(String args_01) {
		this.args_01 = args_01;
	}
	
	/**
	 * @return the args_02
	 */
	public String getArgs_02() {
		return args_02;
	}
	
	/**
	 * @param args_02 the args_02 to set
	 */
	public void setArgs_02(String args_02) {
		this.args_02 = args_02;
	}
}
