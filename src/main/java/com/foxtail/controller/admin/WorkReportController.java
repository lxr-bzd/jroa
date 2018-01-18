package com.foxtail.controller.admin;

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
import com.foxtail.filter.WorkReportFilter;
import com.foxtail.model.admin.ReportExamine;
import com.foxtail.model.admin.WorkReport;
import com.foxtail.service.admin.WorkReportService;


@Controller
@RequestMapping("admin/work/workReport")
@AppModelMap("部门")
public class WorkReportController extends BaseMybatisController{

	@Autowired
	WorkReportService workReportService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String sysModule,String id,ModelMap modelMap){
		String jsp= getEditJsp(sysModule);
		
		if("edit".equals(sysAction))
		modelMap.put("vo", workReportService.getById(id));
		return jsp;
	}
	
	@RequestMapping("toinfo")
	public String toinfo(String sysModule,String id,ModelMap modelMap){
		String jsp= getInfoJsp(sysModule);
		
		modelMap.put("vo", workReportService.getById(id));
		return jsp;
	}
	
	@RequestMapping("toexamine")
	public String toExamine(String sysModule,String id,ModelMap modelMap){
		String jsp= getBaseJsp()+"_examine@"+sysModule;
		
		modelMap.put("vo", workReportService.getById(id));
		return jsp;
	}
	
	
	@RequestMapping("examine")
	@ResponseBody
	public Object examine(String sysModule,ReportExamine examine,ModelMap modelMap){
		
		examine.setTheid(ServiceManager.securityService.getUid());
		
		workReportService.doExamine(examine);
		
		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,WorkReportFilter filter,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult(workReportService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(workReportService.findForPage(getPagination(request),filter));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(WorkReport workReport) {
		workReport.setEmpid(ServiceManager.securityService.getUid());
		workReportService.save(workReport);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		workReportService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(WorkReport workReport) {
		
		workReportService.update(workReport);

		return JsonResult.getSuccessResult();
	}
	
}
