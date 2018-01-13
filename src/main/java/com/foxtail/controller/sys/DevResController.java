package com.foxtail.controller.sys;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import com.foxtail.common.AppModelMap;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.controller.LoginController;
import com.foxtail.core.sys.NodeBean;
import com.foxtail.model.sys.SysUser;
import com.foxtail.service.sys.SysUserService;

@RequestMapping("sys/dev/res")
@Controller
public class DevResController extends BaseMybatisController{

	@Autowired(required=false) 
	private SysUserService sysUserService; 
	
	@Autowired
	RequestMappingHandlerMapping requestMappingHandlerMapping;
	
	@RequestMapping()
	public String list() {
		
		return "sys/dev/res_list";
	}
	
	@RequestMapping("info")
	@ResponseBody
	private Object info(Integer id) {
		
		return this.sysUserService.selectByPrimaryKey(id);
	}
	
	@RequestMapping("scan")
	@ResponseBody
	private Object scan(Integer id) {
		
		List<NodeBean> list = new ArrayList<>();
		
		 Map<RequestMappingInfo, HandlerMethod> map = requestMappingHandlerMapping.getHandlerMethods();  
	        for(RequestMappingInfo info : map.keySet()){  
	        	String url= info.getPatternsCondition().getPatterns().toArray(new String[]{})[0];
	        	HandlerMethod handlerMethod = map.get(info);
	        	if(url.startsWith("/sys"))continue;
	        	if(handlerMethod.getBeanType().equals(LoginController.class))continue;
	        	NodeBean bean = new NodeBean();
	        	bean.setUrl(url);
	        	AppModelMap appMap = map.get(info).getBeanType().getAnnotation(AppModelMap.class);
	        	String mUrlName = (appMap==null)?handlerMethod.getBeanType().getAnnotation(RequestMapping.class).value()[0]:appMap.value();
	        	appMap = map.get(info).getMethodAnnotation(AppModelMap.class);
	        	
	        	
	        	String mName = (appMap==null)?handlerMethod.getMethodAnnotation(RequestMapping.class).value()[0]:appMap.value();
	        	bean.setNameUrl((mUrlName+"/"+mName).replaceAll("//", "/"));
	        	
	          list.add(bean);
	        }  
		
		
		return list;
	}
	
	
	
}
