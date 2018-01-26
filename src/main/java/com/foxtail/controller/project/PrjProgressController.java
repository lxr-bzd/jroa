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
import com.foxtail.model.project.PrjProgress;
import com.foxtail.service.project.PrjProgressService;


@Controller
@RequestMapping("project/project/prjProgress")
@AppModelMap("部门")
public class PrjProgressController extends BaseMybatisController{

	@Autowired
	PrjProgressService prjProgressService;
	
	
	@RequestMapping()
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", prjProgressService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult(prjProgressService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(prjProgressService.findForPage(getPagination(request),request.getParameter("prjid")));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(PrjProgress prjProgress) {
		
		prjProgressService.save(prjProgress);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		prjProgressService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(PrjProgress prjProgress) {
		
		prjProgressService.update(prjProgress);

		return JsonResult.getSuccessResult();
	}
	
}
