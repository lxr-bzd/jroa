package com.foxtail.core.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.foxtail.common.util.SpringContextUtils;
import com.foxtail.dao.mybatis.sys.SysRoleResourceDao;
import com.foxtail.service.sys.SysResourceService;

import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;

public class DataInterceptor extends HandlerInterceptorAdapter{

	
	@Autowired
	private SysResourceService sysResourceService;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String uri = request.getServletPath();
		uri = uri.substring(1,uri.length());
		
		request.setAttribute("resName",sysResourceService.queryUriName(uri));
		
		
		return super.preHandle(request, response, handler);
	} 
}
