package com.foxtail.controller.customer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.model.customer.CusType;
import com.foxtail.service.customer.CusTypeService;


@Controller
@RequestMapping("customer/customer/cusType")
@AppModelMap("部门")
public class CusTypeController extends BaseMybatisController{

	@Autowired
	CusTypeService cusTypeService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", cusTypeService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(cusTypeService.getById(request.getParameter("id")));
		else if("all".equals(type))
			return JsonResult.getSuccessResult(cusTypeService.findAll());
		return DataGridResult.getResult(cusTypeService.findForPage(getPagination(request)));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(CusType cusType) {
		
		cusTypeService.save(cusType);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		cusTypeService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(CusType cusType) {
		
		cusTypeService.update(cusType);

		return JsonResult.getSuccessResult();
	}
	
}
