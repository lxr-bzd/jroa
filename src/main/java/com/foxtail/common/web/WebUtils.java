package com.foxtail.common.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

public class WebUtils {

	public static boolean isAjax(HttpServletRequest request) {
		   String requestedWith = request.getHeader("X-Requested-With");
           return (StringUtils.isNotEmpty(requestedWith) && StringUtils.equals(requestedWith, "XMLHttpRequest"))
        		   ;//如果是ajax返回指定数据
              

	}
	
	
}
