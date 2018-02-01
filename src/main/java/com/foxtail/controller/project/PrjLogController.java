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
import com.foxtail.model.project.PrjLog;
import com.foxtail.service.project.PrjLogService;


@Controller
@RequestMapping("project/project/prjLog")
@AppModelMap("部门")
public class PrjLogController extends BaseMybatisController{

	@Autowired
	PrjLogService prjLogService;
	
	
	@RequestMapping()
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", prjLogService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult(prjLogService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(prjLogService.findForPage(getPagination(request),request.getParameter("prjid")));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(PrjLog prjLog) {
		prjLog.setEmpid(ServiceManager.securityService.getUid());
		prjLogService.save(prjLog);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		prjLogService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(PrjLog prjLog) {
		prjLog.setEmpid(ServiceManager.securityService.getUid());
		prjLogService.update(prjLog);

		return JsonResult.getSuccessResult();
	}
	
}
