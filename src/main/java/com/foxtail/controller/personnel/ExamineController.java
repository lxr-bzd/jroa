package com.foxtail.controller.personnel;

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
import com.foxtail.model.personnel.Examine;
import com.foxtail.service.personnel.ApplyService;
import com.foxtail.service.personnel.ExamineService;


@Controller
@RequestMapping("personnel/examine/examine")
@AppModelMap("部门")
public class ExamineController extends BaseMybatisController{

	@Autowired
	ExamineService examineService;
	
	@Autowired
	ApplyService applyService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit")
	public String toEdit(String sysModule,String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp(sysModule);
		
		if("edit".equals(sysAction))modelMap.put("vo", applyService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(examineService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(examineService.findForPage(getPagination(request)));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Examine examine) {
		
		examineService.save(examine);

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
