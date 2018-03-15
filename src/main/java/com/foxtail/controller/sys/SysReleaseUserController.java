package com.foxtail.controller.sys;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.common.page.Pagination;
import com.foxtail.common.util.DateUtils;
import com.foxtail.common.web.DataGrid;
import com.foxtail.common.web.JsonData;
import com.foxtail.core.shiro.ShiroUser;
import com.foxtail.core.util.PageUtils;
import com.foxtail.model.sys.SysReleaseUser;
import com.foxtail.service.sys.SysReleaseUserService;
import com.foxtail.vo.sys.SysReleaseUserVo;

/**

 */
/*@Controller
@RequestMapping("/sysReleaseUserController") */
public class SysReleaseUserController extends BaseMybatisController {
	
	private final static Logger log= Logger.getLogger(SysReleaseUserController.class);

	@Autowired(required=false) 
	private SysReleaseUserService sysReleaseUserService; 
	
	/**
	 * 列表页面
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	
	@RequestMapping("/toList") 
	public ModelAndView toList()throws Exception{
		ModelAndView mv = new ModelAndView("sys/sysreleaseuser/sysreleaseuser_list");
		return mv;
	}

	/**
	 * 请求列表数据
	 * @param request
	 * @param vo 查询对象
	 * @param rows  每页显示多少行
	 * @param page  当前页码
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/list") 
	@ResponseBody
	public DataGrid list (SysReleaseUserVo vo) throws Exception{
		int pageNo=PageUtils.getPage();
		int pageSize=PageUtils.getRows();
		DataGrid dataGrid = new DataGrid();
		Pagination pagination = sysReleaseUserService.findListByPage(pageSize, pageNo, vo);
		dataGrid.setTotal(pagination.getTotalCount());
		dataGrid.setRows(pagination.getList());
		return dataGrid;
	}
		
	/**
	 * 打开新增页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toAdd") 
	public ModelAndView  toAdd() throws Exception{
		log.debug("打开新增页面");
		ModelAndView mv = new ModelAndView("sys/sysreleaseuser/sysreleaseuser_add");
		return mv;
	}
	
	/**
	 * 新增方法
	 * @param request
	 * @param po
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/add") 
	@ResponseBody
	public JsonData  add(@ModelAttribute SysReleaseUserVo po) {
		JsonData json = new JsonData();
		try {
			this.sysReleaseUserService.saveSysReleaserUser(po);
			json.setSuccess(true);
			json.setMsg("添加成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	/**
	 * 根据ID删除对象
	 * @param request
	 * @param vo
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/deleteById")
	@ResponseBody
	public JsonData deleteById(String  ids) {
		JsonData json = new JsonData();
		try {
			this.sysReleaseUserService.deleteIds(ids);
			json.setSuccess(true);
			json.setMsg("删除成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	/**
	 * 根据ID找到对象
	 * @param request
	 * @param vo
	 * @return
	 */
	@RequestMapping("/findById")
	public ModelAndView findById(@ModelAttribute SysReleaseUserVo vo)throws Exception{
		ModelAndView mv = new ModelAndView("sys/sysreleaseuser/sysreleaseuser_view");
		SysReleaseUserVo po = (SysReleaseUserVo)this.sysReleaseUserService.selectByPrimaryKey(vo.getId());
		mv.addObject("vo", po);
		return mv;
	}

	/**
	 * 跳转到更新页面
	 * @param request
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editById")
	public ModelAndView editById(@ModelAttribute SysReleaseUserVo po)throws Exception{
		ModelAndView mv = new ModelAndView("sys/sysreleaseuser/sysreleaseuser_edit");
		po = (SysReleaseUserVo)this.sysReleaseUserService.selectByPrimaryKey(po.getId());
		mv.addObject("vo", po);
		return mv;
	}
	
	/**
	 * 更新提交
	 * @param request
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/editSubmit")
	@ResponseBody
	public JsonData editSubmit(@ModelAttribute SysReleaseUserVo po)throws Exception{
		JsonData json = new JsonData();
		try {
			this.sysReleaseUserService.editSysReleaserUser(po);
			json.setSuccess(true);
			json.setMsg("修改成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping("/openMeituUpload")
	public ModelAndView openMeituUpload(@ModelAttribute SysReleaseUser po,HttpServletRequest request,String path)throws Exception{
		String httpPath =request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath(); 
		ModelAndView mv = new ModelAndView("sys/sysreleaseuser/sysreleaseuser_upload");
		mv.addObject("imagesPath",path);
		System.out.println("");
		mv.addObject("httpPath",httpPath);
		return mv;
	}
	
	@RequestMapping(value="/uploadImages")
	@ResponseBody
	public JsonData uploadImages(@RequestParam(value = "Filedata", required = false) MultipartFile file,HttpServletRequest request){
		// 上传的网站文件夹
		String path = request.getServletContext().getRealPath("/uploadPath/");
		String moudleName = "meituxiuxiu";
		String fileName=ShiroUser.getUserId()+DateUtils.formatDate(new Date(), DateUtils.YMDHMSS);
		//创建文件夹
		File folder = new File(path+"/"+moudleName);
	    if (!folder.exists()) {    
		     folder.mkdirs();    
	     }  
        String type = request.getParameter("type");
        File uploadFile = new File(path+"/"+moudleName+"/"+fileName+"."+type);  
        try {
			FileCopyUtils.copy(file.getBytes(), uploadFile);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		JsonData jsonData=new JsonData();
	    jsonData.setSuccess(true);
	    String dbPath = "/uploadPath/"+moudleName+"/"+fileName+"."+type;
	    jsonData.setMsg(dbPath);
	    jsonData.setMsg(dbPath);
	    return jsonData;
	}
	
	
	@RequestMapping("/common_list")
	public ModelAndView common_list(){
		ModelAndView mv = new ModelAndView("sys/sysreleaseuser/common_list");
		return mv;
	}
	
	@RequestMapping("/getOrgTypeList")
	@ResponseBody
	public DataGrid getOrgTypeList (SysReleaseUserVo vo) throws Exception{
		int pageNo=PageUtils.getPage();
		int pageSize=PageUtils.getRows();
		DataGrid dataGrid = new DataGrid();
		Pagination pagination = sysReleaseUserService.findListByPage(pageSize, pageNo, vo);
		dataGrid.setTotal(pagination.getTotalCount());
		dataGrid.setRows(pagination.getList());
		return dataGrid;
	}
	
}