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
import com.foxtail.model.customer.Visit;
import com.foxtail.service.customer.VisitService;


@Controller
@RequestMapping("customer/customer/visit")
@AppModelMap("部门")
public class VisitController extends BaseMybatisController{

	@Autowired
	VisitService visitService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", visitService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(visitService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(visitService.findForPage(getPagination(request),request.getParameter("cusid")));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Visit visit) {
		
		visitService.save(visit);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		visitService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Visit visit) {
		
		visitService.update(visit);

		return JsonResult.getSuccessResult();
	}
	
}
