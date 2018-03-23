package com.foxtail.controller.my;


import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.filter.PrjCollectFilter;
import com.foxtail.model.personnel.Emp;
import com.foxtail.service.IndexService;
/**
 * 
 * @author Administrator
 *
 */
import com.foxtail.service.personnel.EmpService;

@Controller
@RequestMapping("")
public class IndexControler extends BaseMybatisController{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	EmpService empService;
	
	@Autowired
	IndexService indexService;
	

	@RequestMapping("my/main/index") 
	public String toMain(String sysModule){
		if(!SecurityUtils.getSubject().isPermitted("my/main/index?$sysView=admin"))
		return "my/main/user_index";
		return "my/main/admin_index";
	}
	
	
	@RequestMapping("index/statistics")
	@ResponseBody
	public Object statistics() {
		
		return JsonResult.getSuccessResult(indexService.getStatistics());
	}
	
	
	@RequestMapping("index/prjMoney")
	@ResponseBody
	public Object prjMoney(PrjCollectFilter filter) {
		
		return JsonResult.getSuccessResult(indexService.prjMoney(filter));
	}
	
	
	@RequestMapping("index/sale")
	@ResponseBody
	public Object getResult(Long starttime,Long endtime) {
		
		return JsonResult.getSuccessResult(indexService.findSale(starttime, endtime));
		
	}
	
	@RequestMapping("index/user/toedit")
	public String userToedit() {
		
		return "user_edit";

	}
	
	
	@RequestMapping("index/user/update")
	@ResponseBody
	public Object userUpdate(Emp emp,String newpwd) {
		
		if(!ServiceManager.securityService.equestPwd(emp.getPwd()))
			return JsonResult.getFailResult("密码不正确");
		
		if(StringUtils.isBlank(newpwd))
			return JsonResult.getFailResult("新密码不能为空");
		
		emp.setPwd(newpwd);
		emp.setAccount(ServiceManager.securityService.getAccount());
		emp.setId(ServiceManager.securityService.getUid());
		empService.updateEmp(emp);
		return JsonResult.getSuccessResult();
		
	}
	
	


}
