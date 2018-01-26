package com.foxtail.core.shiro;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;

import com.alibaba.fastjson.JSONObject;
import com.foxtail.common.JsonResult;
import com.foxtail.common.web.WebUtils;


public class ShiroPermsFilter extends AuthorizationFilter {
  

	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue)
			throws Exception {
		
		  	HttpServletRequest httpRequest = (HttpServletRequest) request;
	        HttpServletResponse httpResponse = (HttpServletResponse) response;
	        
	        String url = getPermsUrl(httpRequest);
	        
	        if(url.startsWith("sys"))return true;
	        
	        if(SecurityUtils.getSubject().isPermitted(url))return true;
	       
	        return false;
	}
	
	
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response, Object mappedValue)
			throws Exception {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		if(WebUtils.isAjax(httpRequest)){
        	response.getWriter().print(JSONObject.toJSONString(JsonResult.getResult(JsonResult.STATUS_UN_PERMS, "无权限！")));
        }else
        	org.apache.shiro.web.util.WebUtils.issueRedirect(request, response, getUnauthorizedUrl(), null, true);
        
		return false;
	}
	
	private String getPermsUrl(HttpServletRequest httpRequest) {
		String url = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length(),httpRequest.getRequestURI().length() );
        
		if(url.startsWith("/"))
			return url.substring(1,url.length()-3);
		
		return url;

	}
}
