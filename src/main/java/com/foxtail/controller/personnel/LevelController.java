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
import com.foxtail.common.page.Pagination;
import com.foxtail.model.personnel.Level;
import com.foxtail.service.personnel.LevelService;


@Controller
@RequestMapping("personnel/organize/level")
@AppModelMap("部门")
public class LevelController extends BaseMybatisController{

	@Autowired
	LevelService levelService;
	
	
	@RequestMapping() 
	public String toMain(){
		return getMainJsp();
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String id,String action,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(action))
		modelMap.put("vo", levelService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(levelService.getById(request.getParameter("id")));
		else if("all".equals(type))
			return JsonResult.getSuccessResult(levelService.findForPage(new Pagination(1, 100, 100), null).getList());
		return DataGridResult.getResult(levelService.findForPage(getPagination(request),request.getParameter("kw")));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Level level) {
		
		levelService.save(level);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		levelService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Level level) {
		
		levelService.update(level);

		return JsonResult.getSuccessResult();
	}
	
}
