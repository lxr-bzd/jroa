package com.foxtail.controller.personnel;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.common.util.DateUtils;
import com.foxtail.filter.EmpFilter;
import com.foxtail.model.personnel.Emp;
import com.foxtail.service.personnel.EmpService;


@Controller
@RequestMapping("personnel/employee/emp")
@AppModelMap("部门")
public class EmpController extends BaseMybatisController{

	@Autowired
	EmpService empService;
	
	
	@RequestMapping() 
	public String toMain(String module){
		
		return getMainJsp(module);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String id,String action,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(action))
		modelMap.put("vo", empService.getById(id));
		return jsp;
	}
	
	@RequestMapping("toinfo") 
	public String toinfo(String id,ModelMap modelMap){
		String jsp= getInfoJsp(null);

		modelMap.put("vo", empService.getById(id));
		return jsp;
	}
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,EmpFilter filter,String deptStr,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(empService.getById(request.getParameter("id")));
		else {
			if(!StringUtils.isEmpty(deptStr))
				filter.setDeptids(deptStr.split(","));
			if(filter.getMonth()!=null) {
				filter.setMonth(new Date().getMonth());
				
			}
			
			return DataGridResult.getResult(empService.findForPage(getPagination(request),filter));
		}
		
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Emp emp) {
		
		empService.save(emp);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		empService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Emp emp) {
		
		empService.update(emp);

		return JsonResult.getSuccessResult();
	}
	
}
