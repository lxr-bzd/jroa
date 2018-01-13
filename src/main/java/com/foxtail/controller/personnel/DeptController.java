package com.foxtail.controller.personnel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foxtail.common.AppModelMap;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.model.personnel.Dept;
import com.foxtail.service.personnel.DeptService;


@Controller
@RequestMapping("personnel/organize/dept")
@AppModelMap("部门")
public class DeptController extends BaseMybatisController{

	@Autowired
	DeptService deptService;
	
	
	@RequestMapping() 
	public String toMain(){
		return getMainJsp();
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String id,String action,ModelMap modelMap){
		String jsp= getEditJsp();
		if("edit".equals(action))
			modelMap.put("vo", deptService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(deptService.findAll());
		else 
		return JsonResult.getSuccessResult(deptService.findAll());
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Dept dept) {
		
		deptService.save(dept);
		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		deptService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Dept dept) {
		
		deptService.update(dept);

		return JsonResult.getSuccessResult();
	}
	
}
