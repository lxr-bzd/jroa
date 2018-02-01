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
import com.foxtail.model.project.Progress;
import com.foxtail.service.project.ProgressService;


@Controller
@RequestMapping("project/setting/progress")
@AppModelMap("部门")
public class ProgressController extends BaseMybatisController{

	@Autowired
	ProgressService progressService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", progressService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult(progressService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(progressService.findForPage(getPagination(request)));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Progress progress) {
		
		progressService.save(progress);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		progressService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Progress progress) {
		
		progressService.update(progress);

		return JsonResult.getSuccessResult();
	}
	
}
