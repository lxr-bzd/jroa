package com.foxtail.service.sys;

import java.util.List;

import com.foxtail.common.base.BaseMybatisService;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysRoleResource;
import com.foxtail.vo.sys.SysRoleResourceVo;

public interface SysRoleResourceService extends BaseMybatisService<SysRoleResource,Integer> {	
    
    public void deleteIds(String ids);
    
    public List<SysRoleResource> selectList(SysRoleResource sysRoleResource);
    
    public Pagination findListByPage(int rows, int page,SysRoleResourceVo vo);
    
    public void deleteByRoleId(Integer roleId);
   
}

