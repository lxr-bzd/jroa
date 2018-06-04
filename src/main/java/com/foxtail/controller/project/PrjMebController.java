package com.foxtail.controller.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foxtail.bean.ServiceManager;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.service.project.ProjectService;
import com.thoughtworks.xstream.mapper.Mapper.Null;

@Controller
@RequestMapping("project/project/prjMeb")
@AppModelMap()
public class PrjMebController extends BaseMybatisController{

	@Autowired
	ProjectService projectService;
	
	@RequestMapping()
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object viewDev(String prjid,String type,HttpServletRequest request) {
		
		String uid = ServiceManager.securityService.getUid();
		
		if("state".equals(type)) {
			return JsonResult.getSuccessResult(projectService.getUserState(prjid,uid));
		}
			
		Map<String, Object> ret = new HashMap<>();
		//ret.put("mebs", projectService.findMebs(prjid));
		ret.put("uid", uid);
		ret.put("prj", projectService.getById(prjid));
		
		return JsonResult.getSuccessResult(ret);
	}
	
	
	
	
	@RequestMapping("doDev")
	@ResponseBody
	public Object doDev(String prjid,String type) {
		String uid = ServiceManager.securityService.getUid();
		
		if("start".equals(type))
			projectService.doStart(prjid,uid);
		else if("end".equals(type))
			projectService.doEnd(prjid,uid);
		else return JsonResult.getFailResult("error");
		
		return JsonResult.getSuccessResult((Object)projectService.getUserState(prjid,uid));

	}
	
	@RequestMapping("setTime")
	@ResponseBody
	public Object setAlltime(String prjid,Double alltime) {
		String uid = ServiceManager.securityService.getUid();
		projectService.setAlltime(prjid, uid, alltime);
		
		return JsonResult.getSuccessResult();
	}
	
	
	
	
	@RequestMapping("viewRate")
	@ResponseBody
	public Object viewRate() {
		return null;

	}
	
	@RequestMapping("updateRate")
	@ResponseBody
	public Object updateRate() {
		return null;

	}
	
	@RequestMapping("saveRate")
	@ResponseBody
	public Object saveRate(HttpServletRequest request) {
		
		Map<String, String> model = getMapModel(request, new String[]{"prjid","name","progress"});
		
		return null;

	}
	
	
	
}
