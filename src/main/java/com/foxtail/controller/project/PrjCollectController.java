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
import com.foxtail.filter.PrjCollectFilter;
import com.foxtail.model.project.PrjCollect;
import com.foxtail.service.project.PrjCollectService;
import com.lxr.commons.exception.ApplicationException;


@Controller
@RequestMapping("project/project/prjCollect")
@AppModelMap("部门")
public class PrjCollectController extends BaseMybatisController{

	@Autowired
	PrjCollectService prjCollectService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", prjCollectService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,PrjCollectFilter filter,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult(prjCollectService.getById(request.getParameter("id")));
		else if("bysalesman".equals(sysType)) {
			String empid = request.getParameter("empid");
			if(empid==null)throw new ApplicationException("参数错误");
			return JsonResult.getSuccessResult(prjCollectService.findBySalesman(empid));
			
		}
		else
		return DataGridResult.getResult(prjCollectService.findForPage(getPagination(request),filter));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(PrjCollect prjCollect) {
		prjCollect.setEmpid(ServiceManager.securityService.getUid());
		if(prjCollect.getTime()==null)
		prjCollect.setTime(System.currentTimeMillis());
		prjCollectService.save(prjCollect);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		prjCollectService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(PrjCollect prjCollect) {
		
		prjCollectService.update(prjCollect);

		return JsonResult.getSuccessResult();
	}
	
}
