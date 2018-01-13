package com.foxtail.service.sys;

import java.util.List;

import com.foxtail.common.base.BaseMybatisService;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysUserRole;
import com.foxtail.vo.sys.SysUserRoleVo;

public interface SysUserRoleService extends BaseMybatisService<SysUserRole,Integer> {	
    
    public void deleteIds(String ids);
    
    public List<SysUserRole> selectList(SysUserRole sysUserRole);
    
    public Pagination findListByPage(int rows, int page,SysUserRoleVo vo);
    
    public List<SysUserRoleVo> selectByUserId(Integer userId);
    
    /**
     * 
    * Description:根据用户id删除关系    
    * @Title: deleteByUserId  
 
     */
    public void deleteByUserId(Integer userId);
    
    /**
     * 
    * Description:根据角色id删除关系    
    * @Title: deleteByRoleId  

     */
    public void deleteByRoleId(Integer roleId);
}

