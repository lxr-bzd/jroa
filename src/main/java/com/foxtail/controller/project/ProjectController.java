package com.foxtail.controller.project;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foxtail.bean.ServiceManager;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.filter.ProjectFilter;
import com.foxtail.model.project.Project;
import com.foxtail.service.project.ProjectService;


@Controller
@RequestMapping("project/project/project")
@AppModelMap("部门")
public class ProjectController extends BaseMybatisController{

	@Autowired
	ProjectService projectService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", projectService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,ProjectFilter filter,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult(projectService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(projectService.findForPage(getPagination(request),filter));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Project project) {
		project.setOrdertime(System.currentTimeMillis());
		project.setOrderempid(ServiceManager.securityService.getUid());
		projectService.save(project);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		projectService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Project project) {
		
		projectService.update(project);

		return JsonResult.getSuccessResult();
	}
	
}
