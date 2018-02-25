package com.foxtail.controller;


import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foxtail.bean.ServiceManager;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.common.util.MD5Util;
import com.foxtail.model.personnel.Emp;
import com.foxtail.service.IndexService;
/**
 * 
 * @author Administrator
 *
 */
import com.foxtail.service.personnel.EmpService;

@Controller
@RequestMapping("index")
public class IndexControler extends BaseMybatisController{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	EmpService empService;
	
	@Autowired
	IndexService indexService;
	
	
	@RequestMapping("statistics")
	@ResponseBody
	public Object statistics() {
		
		return JsonResult.getSuccessResult(indexService.getStatistics());
	}
	
	
	
	@RequestMapping("sale")
	@ResponseBody
	public Object getResult(Long starttime,Long endtime) {
		
		return JsonResult.getSuccessResult(indexService.findSale(starttime, endtime));
		
	}
	
	@RequestMapping("user/toedit")
	public String userToedit() {
		
		return "user_edit";

	}
	
	
	@RequestMapping("user/update")
	@ResponseBody
	public Object userUpdate(Emp emp,String newpwd) {
		
		if(!ServiceManager.securityService.equestPwd(emp.getPwd()))
			return JsonResult.getFailResult("密码不正确");
		
		if(StringUtils.isEmpty(newpwd))
			return JsonResult.getFailResult("新密码不能为空");
		
		emp.setPwd(newpwd);
		emp.setAccount(ServiceManager.securityService.getAccount());
		emp.setId(ServiceManager.securityService.getUid());
		empService.updateEmp(emp);
		return JsonResult.getSuccessResult();
		
	}
	
	
	

}
