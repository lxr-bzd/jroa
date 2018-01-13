package com.foxtail.service.sys;

import java.util.List;

import com.foxtail.common.base.BaseMybatisService;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysRole;
import com.foxtail.model.sys.SysRoleResource;
import com.foxtail.vo.sys.SysRoleVo;

public interface SysRoleService extends BaseMybatisService<SysRole,Integer> {	
    
    public void deleteIds(String ids);
    
     public void deleteIds(String[] ids);
    
    public List<SysRole> selectList(SysRole sysRole);
    
    public Pagination findListByPage(int rows, int page,SysRoleVo vo);
   
    /**
     * 授权
    * Description:    
    * @Title: setRoleResources  

     */
    public void setRoleResources(SysRoleResource[] resources);
    
    /**
     * 
    * Description:根据用户id查找角色    
    * @Title: findRoleTypesByUserId  
     */
    public List<String> findRoleTypesByUserId(Integer userId);
}

