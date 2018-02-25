package com.foxtail.controller.personnel;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;
import com.foxtail.model.personnel.Examine;
import com.foxtail.service.personnel.ApplyService;
import com.foxtail.service.personnel.EmpService;
import com.foxtail.service.personnel.ExamineService;


@Controller
@RequestMapping("personnel/examine/examine")
@AppModelMap("部门")
public class ExamineController extends BaseMybatisController{

	@Autowired
	ExamineService examineService;
	
	@Autowired
	ApplyService applyService;
	
	@Autowired
	EmpService  empService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		String rString = getMainJsp(sysModule);
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit")
	public String toEdit(String sysModule,String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp(sysModule);
		
		if("edit".equals(sysAction)) {
			Apply apply = applyService.getById(id);
			modelMap.put("vo", apply);
			modelMap.put("exaJson", JSONObject.toJSONString(examineService.findByApplyid(apply.getId())));
		}
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,ApplyFilter filter,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(examineService.getById(request.getParameter("id")));
		else 
			resolveSysView(filter);
		filter.setUdeptid(empService.getById(ServiceManager.securityService.getUid()).getDeptid());
		return DataGridResult.getResult(applyService.findForPage(getPagination(request),filter));
	}
	
	
	 private void resolveSysView(ApplyFilter filter) {
		 String pString = null;
		switch (filter.getApplytype()) {
		case 1:pString ="personnel/examine/examine?module=leave";
			
			break;
		case 2:pString ="personnel/apply/examine?module=overtime";
		
		break;
		case 3:pString ="personnel/apply/examine?module=goout";
		
		break;
		case 4:pString ="personnel/apply/examine?module=quit";
		
		break;

		default:
			break;
		}
		
		
		
		if (pString==null)return;
		
		filter.setSysView("def");
	
		
		if(SecurityUtils.getSubject().isPermitted(pString+"&$sysView=all")) {
			filter.setSysView("all");
			return;
		}
		
		if(SecurityUtils.getSubject().isPermitted(pString+"&$sysView=below")) {
			filter.setSysView("below");
			return;
		}
		

	}
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Examine examine,String isend) {
		examine.setExatime(System.currentTimeMillis()+"");
		examine.setExaid(ServiceManager.securityService.getUid());
		
		examineService.save(examine,("true".equals(isend))?true:false);
		
		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		examineService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Examine examine) {
		
		examineService.update(examine);

		return JsonResult.getSuccessResult();
	}
	
}
