package com.wpk.changeFee.web;

import java.io.ByteArrayOutputStream;

import javax.annotation.Resource;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.PumpStreamHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wpk.changeFee.vo.ArgsVO;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @class   : ChangeFeeController
 * @file    : ChangeFeeController.java
 * @package : com.wpk.changeFee.web
 * @author  : user
 * @date    : 2017. 12. 10.
 * @see <pre>
 * 
 *  == 개정이력 ==
 * 
 *  수정일         수정자         수정내용
 *  -------        --------       ---------------------------
 *  2017. 12. 10.  user           최초 생성
 * 
 * </pre>
 *  Copyright (C) by WilsonParkingKorea All right reserved.
 */

@Controller
public class ChangeFeeController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChangeFeeController.class);
	private final String PL_SCRIPT_NAME_PREFIX = "plScriptName";
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * 요금변경 화면 표시
	 * @return parkList
	 * @exception Exception
	 */
	@RequestMapping(value="/parkList.do")
	public String parkList() throws Exception {
		return "parkList";
	}
	
	@RequestMapping(value="/callChange.do", produces="application/json;charset=utf8", method=RequestMethod.POST)
	@ResponseBody
	public ArgsVO callChange(@ModelAttribute ArgsVO argsVO) {
		logger.info("Call Change Fee.({}, {}, {})", argsVO.getCallType(), argsVO.getArgs_01(), argsVO.getArgs_02());
		
		String strCmd = "";
		if (argsVO.getCallType().equals(argsVO.CALL_TYPE_PERM)) {
			strCmd = propertiesService.getString("pyAppPath") + ' ' + propertiesService.getString("pyScriptPathPerm")
				+ propertiesService.getString("pyScriptNamePerm") + ' ' + argsVO.getArgs_02() + ' ' + argsVO.getArgs_01();
		}
		else if (argsVO.getCallType().equals(argsVO.CALL_TYPE_DAY_WEEK)) {
			strCmd = propertiesService.getString("plAppPath") + ' ' + propertiesService.getString("plScriptPathDayWeek")
			+ propertiesService.getString(this.PL_SCRIPT_NAME_PREFIX + argsVO.getArgs_01());
		}
		else {
			argsVO.setMessage(argsVO.MESSAGE_FAIL);
			logger.error("Failed to Change Fee.(Parameter Call-Type is empty.)");
			return argsVO;
		}
		
		logger.debug("Command line : {}", strCmd);
		
		DefaultExecutor executor = new DefaultExecutor();
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		PumpStreamHandler streamHandler = new PumpStreamHandler(baos);
		executor.setStreamHandler(streamHandler);
		CommandLine cmdLine = CommandLine.parse(strCmd);
		
		argsVO.setMessage(argsVO.MESSAGE_SUCCESS);
		
		try {
			int retVal = executor.execute(cmdLine);
			if (retVal != 0) {
				argsVO.setMessage(argsVO.MESSAGE_FAIL);
			}
			logger.info(baos.toString());
		} catch (Exception e) {
			argsVO.setMessage(argsVO.MESSAGE_FAIL);
			logger.error("Failed to Change Fee.({}, {}, {})", argsVO.getCallType(), argsVO.getArgs_01(), argsVO.getArgs_02());
			logger.info(baos.toString());
			logger.error(e.getMessage(), e);
		}
		
		return argsVO;
	}
}
