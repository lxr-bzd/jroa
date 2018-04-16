package com.foxtail.controller.personnel;

import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

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
import com.foxtail.common.SpringFileupload;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;
import com.foxtail.service.personnel.ApplyService;
import com.foxtail.service.personnel.ExamineService;


@Controller
@RequestMapping("personnel/apply/apply")
@AppModelMap("部门")
public class ApplyController extends BaseMybatisController{

	@Autowired
	ApplyService applyService;
	
	@Autowired 
	ExamineService examineService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysModule,String id,String action,ModelMap modelMap){
		String jsp= getEditJsp(sysModule);
		
		if("edit".equals(action)) {
			Apply apply = applyService.getById(id);
		modelMap.put("vo", apply);
		
		}
		return jsp;
	}
	
	
	@RequestMapping("toinfo")
	public String toinfo(String sysModule,String id,String action,ModelMap modelMap){
		String jsp= getInfoJsp(sysModule);
		Apply apply =  applyService.getById(id);
		modelMap.put("vo", apply);
		if(apply.getState()!=null&&(apply.getState()==2||apply.getState()==4)) {
			Object exas = examineService.findByApplyid(apply.getId());
			modelMap.put("exasJson", JSONObject.toJSONString(exas));
		}
			
		return jsp; 
	}
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,ApplyFilter filter,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(applyService.getById(request.getParameter("id")));
		else {
			filter.setUid(ServiceManager.securityService.getUid());
			filter.setSysView("self");
			return DataGridResult.getResult(applyService.findForPage(getPagination(request),filter));
			
		}
		
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Apply apply,HttpServletRequest request) {
		
		if(SpringFileupload.isFile(request, "imgFile")) {
			String[] files = SpringFileupload.uploadFiles(request,"imgFile");
			apply.setVouchers(files);
		}
			
		
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
	public Object update(Apply apply,HttpServletRequest request) {
		String[] files = null;
		if(SpringFileupload.isFile(request, "imgFile")) {
			files = SpringFileupload.uploadFiles(request,"imgFile");
			
		}
		
		apply.setVouchers(joinArray(apply.getVouchers(), files));
		
		applyService.update(apply);

		return JsonResult.getSuccessResult();
	}
	
	
	private String[] joinArray(String[] arr1,String[] arr2) {
		if(arr1==null||arr1.length<1)return arr2;
		if(arr2==null||arr2.length<1)return arr1;
       String[] narr = new String[arr1.length+arr2.length];
       for (int i = 0; i < arr1.length; i++) {
		narr[i] = arr1[i];
	}
       
       for (int i = 0; i < arr2.length; i++) {
   		narr[i+arr1.length] = arr2[i];
   	}
         return narr;

	}
	
	
	
}
