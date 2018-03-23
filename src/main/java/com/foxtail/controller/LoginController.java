package com.foxtail.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.LoggerUtils;
import com.foxtail.common.SpringFileupload;
import com.foxtail.common.util.VerifyCodeUtils;
import com.foxtail.core.shiro.IncorrectCaptchaException;
import com.foxtail.core.shiro.ShiroUser;
import com.foxtail.model.sys.SysResource;
import com.foxtail.service.sys.SysResourceService;
import com.foxtail.vo.sys.SysUserActiveVo;

@Controller
public class LoginController {
	
	@Autowired
	private SysResourceService sysResourceService;
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, ModelMap model) throws Exception{
		Subject subject = SecurityUtils.getSubject();
		if(subject.isAuthenticated()){ //已经登录，重新登录
			SecurityUtils.getSecurityManager().logout(subject);
		}
		SysUserActiveVo user = (SysUserActiveVo) subject.getPrincipal();
		//String loginName = request.getParameter("loginName");
    	if(user != null){
    		model.addAttribute("loginName",user.getLoginName());
    	}
		String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
		if(exceptionClassName!=null){
			if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
				model.addAttribute("warn","账号不存在");
			} else if (IncorrectCredentialsException.class.getName().equals(
					exceptionClassName)) {
				String msg="用户名/密码错误";
				model.addAttribute("warn",msg);
			}else if (IncorrectCaptchaException.class.getName().equals(exceptionClassName)){
				model.addAttribute("warn","验证码错误");
			}else if (LockedAccountException.class.getName().equals(exceptionClassName)) {
				model.addAttribute("warn","账户被禁用");
			}else {
				model.addAttribute("warn","登录异常");
			}
		}
		return "/login";
	}
	
	/**
	 * 
	* Description:加载验证码    
	* @Title: loadPasskey  
	* @since 2016年5月31日 下午2:27:30
	* @param request
	* @param response
	* @throws Exception
	 */
	@RequestMapping("/loadPasskey") 
	public void loadPasskey(HttpServletRequest request,HttpServletResponse response) throws Exception{
		response.setContentType("image/jpeg");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		HttpSession session = request.getSession();
		int width = 80, height = 30;
		ServletOutputStream responseOutputStream = null;
		try {
			 ServletOutputStream outputStream = response.getOutputStream();
			String codeKey= VerifyCodeUtils.outputVerifyImage(width, height, outputStream, 4);
			session.setAttribute("CodeKey", codeKey);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(null != responseOutputStream){
				responseOutputStream.flush();
				responseOutputStream.close();
			}
		}
	}

	/**
	* Description:授权成功    
	* @since 2016年5月31日 下午2:27:54
	* @return
	 */
	@RequestMapping(value = "/loadAuthorization/pass")
    public ModelAndView pass()
    {
    	ModelAndView mv = new ModelAndView("layout/main");
    	SysUserActiveVo user = ShiroUser.getUser();
    	mv.addObject("user", user);
    	List<SysResource> resList = sysResourceService.findAllByUserId(ShiroUser.getUserId());
    	mv.addObject("resList", resList);
    	return mv;
    }
	
	@RequestMapping(value = "/upload")
	@ResponseBody
    public Object upload(HttpServletRequest request,HttpServletResponse response)
    {
		String path = null;
		
		try {
				path = SpringFileupload.upload(request, "imgFile");
			} catch (MultipartException e) {
				return getError(e.getMessage());
			} 
		
		
		

				JSONObject obj = new JSONObject();
				obj.put("error", 0);
				obj.put("url", path);
				
			return obj;
		
    }
	
	private String getError(String message) {
		JSONObject obj = new JSONObject();
		obj.put("error", 1);
		obj.put("message", message);
		return obj.toJSONString();
	}
	
}
