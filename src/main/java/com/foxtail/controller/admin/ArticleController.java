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
import com.foxtail.filter.ArticleFilter;
import com.foxtail.model.admin.Article;
import com.foxtail.service.admin.ArticleService;


@Controller
@RequestMapping("admin/information/article")
@AppModelMap("部门")
public class ArticleController extends BaseMybatisController{

	@Autowired
	ArticleService articleService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", articleService.getById(id));
		return jsp;
	}
	
	@RequestMapping("toinfo") 
	public String toinfo(String sysModule,String id,ModelMap modelMap){
		String jsp= getInfoJsp(sysModule);
		
		modelMap.put("vo", articleService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,ArticleFilter filter,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult(articleService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(articleService.findForPage(getPagination(request),filter));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Article article) {
		
		article.setAuthor(ServiceManager.securityService.getUname());
		
		articleService.save(article);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		articleService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Article article) {
		
		articleService.update(article);

		return JsonResult.getSuccessResult();
	}
	
}
