package com.foxtail.controller.sys;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.common.page.Pagination;
import com.foxtail.common.web.DataGrid;
import com.foxtail.common.web.JsonData;
import com.foxtail.core.util.PageUtils;
import com.foxtail.model.sys.SysRole;
import com.foxtail.model.sys.SysUserRole;
import com.foxtail.service.sys.SysRoleService;
import com.foxtail.service.sys.SysUserRoleService;
import com.foxtail.vo.sys.SysRoleVo;
import com.foxtail.vo.sys.SysUserRoleVo;
import com.foxtail.vo.tree.TreeNode;

@Controller
@RequestMapping("sys/auth/role") 
public class SysRoleController extends BaseMybatisController {
	
	private final static Logger log= Logger.getLogger(SysRoleController.class);

	@Autowired(required=false) 
	private SysRoleService sysRoleService; 
	
	@Autowired
	private SysUserRoleService sysUserRoleService;
	
	@RequestMapping() 
	public String toMain(String sysModule){
		
		return getMainJsp(sysModule);
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
	public DataGrid list (SysRoleVo vo) throws Exception{
		int pageNo=PageUtils.getPage();
		int pageSize=PageUtils.getRows();
		DataGrid dataGrid = new DataGrid();
		Pagination pagination = sysRoleService.findListByPage(pageSize, pageNo, vo);
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
		
		ModelAndView mv = new ModelAndView("sys/sysrole/sysrole_add");
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
	public JsonData  add(@ModelAttribute SysRole po) {
		JsonData json = new JsonData();
		try {
			this.sysRoleService.insert(po);
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
			this.sysRoleService.deleteIds(ids.split(","));
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
	public ModelAndView findById(@ModelAttribute SysRoleVo vo)throws Exception{
		ModelAndView mv = new ModelAndView("sys/sysrole/sysrole_view");
		SysRole po = this.sysRoleService.selectByPrimaryKey(vo.getId());
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
	public ModelAndView editById(@ModelAttribute SysRole po)throws Exception{
		ModelAndView mv = new ModelAndView("sys/sysrole/sysrole_edit");
		po = this.sysRoleService.selectByPrimaryKey(po.getId());
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
	public JsonData editSubmit(@ModelAttribute SysRole po)throws Exception{
		JsonData json = new JsonData();
		try {
			this.sysRoleService.updateByPrimaryKeySelective(po);
			json.setSuccess(true);
			json.setMsg("修改成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping("/toUserRoleTree") 
	public ModelAndView toUserRoleTree(Integer userId)throws Exception{
		ModelAndView mv = new ModelAndView("sys/sysrole/sysrole_userroles_tree");
		if(null!=userId){
			mv.addObject("userId",userId);
 			StringBuffer roleId =new StringBuffer();
 
			List<SysUserRoleVo> list = sysUserRoleService.selectByUserId(userId);
			if(null!=list&&list.size()>0){
				for(SysUserRole ur:list){
					roleId.append(ur.getRoleId()+",");
				}
			}
			mv.addObject("roleId", roleId.toString());
		}
 
		return mv;
	}
	
	@RequestMapping("/loadRoleTree") 
	@ResponseBody
	public List<TreeNode> loadGenerlRoleTree(String roleId){
	   
		List<TreeNode> treenodes = new ArrayList<TreeNode>();
		//只读取通用角色
		SysRole po = new SysRole(); 
		List<SysRole> list = this.sysRoleService.selectList(po);
		for(SysRole sysRole :list){
			TreeNode treeNode = new TreeNode(); 
			treeNode.setId(sysRole.getId()+"");
			treeNode.setText(sysRole.getRoleName());
			treeNode.setpId("0");
			treeNode.setIsParent(false);
			if(roleId.indexOf(sysRole.getId()+"")>=0){
				treeNode.setChecked(true);
			} 
			treenodes.add(treeNode);
		}
		return treenodes;
	}
	
	@RequestMapping("/toAuthorization") 
	@ResponseBody
	public JsonData toAuthorization(String roleid, String resids){
		JsonData jsonData = new JsonData();
		try {
			
			String[] residArr = null;
			if(StringUtils.isEmpty(resids))residArr = new String[0];
			else residArr = resids.split(",");
			this.sysRoleService.setRoleResources(roleid,residArr);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setSuccess(false);
		}
	
		return jsonData;
	}
	
	@RequestMapping("/copyRes") 
	@ResponseBody
	public Object copyRes(String roleid,String copyRoleid){
		
			this.sysRoleService.copyResources(roleid, copyRoleid);;
			
		return JsonResult.getSuccessResult();
	}
	
	
	
}