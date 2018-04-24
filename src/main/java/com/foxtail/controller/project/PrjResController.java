package com.foxtail.controller.project;

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
import com.foxtail.model.project.PrjRes;
import com.foxtail.service.project.PrjResService;


@Controller
@RequestMapping("project/project/prjRes")
@AppModelMap("部门")
public class PrjResController extends BaseMybatisController{
	
	@Autowired
	PrjResService prjResService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		if("edit".equals(sysAction))
		modelMap.put("vo", prjResService.getById(id));
		return jsp;
	}
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult(prjResService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(prjResService.findForPage(getPagination(request),request.getParameter("kw")));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(PrjRes prjRes) {
		
		prjResService.save(prjRes);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		prjResService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(PrjRes prjRes) {
		
		prjResService.update(prjRes);

		return JsonResult.getSuccessResult();
	}
	
}
