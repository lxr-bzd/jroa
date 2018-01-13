package com.foxtail.service.sys;

import java.util.List;

import com.foxtail.common.base.BaseMybatisService;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysResource;
import com.foxtail.vo.sys.SysResourceVo;

public interface SysResourceService extends BaseMybatisService<SysResource,Integer> {	
    
    public void deleteIds(String ids);
    
    public List<SysResource> selectList(SysResource sysResource);
    
    public Pagination findListByPage(int rows, int page,SysResourceVo vo);
    
    public List<SysResource> selectListByParentId(Integer parentId);
    
 	public void saveAndCreateRes(SysResource po,boolean createButton);
 	//生成按钮资源
 	public void createButtonRes (SysResource po);
 	
 	public SysResourceVo selectVoByPrimaryKey(Integer id);
 	
 	public List<SysResourceVo> findAuthorizationAll(Integer roleId);
 	
	public List<SysResource> findAllByUserId(Integer userId);
	
	 public String queryUriName(String uri);
	
	public Integer selectResourceReference(Integer resourceId);
 	
 	
}

