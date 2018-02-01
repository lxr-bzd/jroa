package com.foxtail.controller.personnel;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.model.personnel.Place;
import com.foxtail.service.personnel.PlaceService;


@Controller
@RequestMapping("personnel/organize/place")
@AppModelMap("部门")
public class PlaceController extends BaseMybatisController{

	@Autowired
	PlaceService placeService;
	
	@RequestMapping() 
	public String toMain(){
		return getMainJsp();
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String id,String action,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(action))
		modelMap.put("vo", placeService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,String deptStr,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(placeService.getById(request.getParameter("id")));
		else if("bydeptid".equals(type))
			return JsonResult.getSuccessResult(placeService.findByDeptid(request.getParameter("deptid")));
		
		String[] deptids = null;
		if(!StringUtils.isEmpty(deptStr))
			deptids = deptStr.split(",");
		return DataGridResult.getResult(placeService.findForPage(getPagination(request),deptids,request.getParameter("kw")));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Place place) {
		
		placeService.save(place);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		placeService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Place place) {
		
		placeService.update(place);

		return JsonResult.getSuccessResult();
	}
	
	
	
}
