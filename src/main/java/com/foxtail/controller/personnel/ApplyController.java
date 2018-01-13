package com.foxtail.controller.personnel;

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
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;
import com.foxtail.service.personnel.ApplyService;


@Controller
@RequestMapping("personnel/apply/apply")
@AppModelMap("部门")
public class ApplyController extends BaseMybatisController{

	@Autowired
	ApplyService applyService;
	
	
	@RequestMapping() 
	public String toMain(String module){
		return getMainJsp(module);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String module,String id,String action,ModelMap modelMap){
		String jsp= getEditJsp(module);
		
		if("edit".equals(action))
		modelMap.put("vo", applyService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,ApplyFilter filter,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(applyService.getById(request.getParameter("id")));
		else {
			filter.setUid(ServiceManager.securityService.getUid());
			return DataGridResult.getResult(applyService.findForPage(getPagination(request),filter));
			
		}
		
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Apply apply) {
		
		apply.setUid(ServiceManager.securityService.getUid());
		
		applyService.save(apply);
		
		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		applyService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Apply apply) {
		
		applyService.update(apply);

		return JsonResult.getSuccessResult();
	}
	
}
