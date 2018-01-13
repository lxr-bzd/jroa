package com.foxtail.dao.mybatis.sys;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysUserRole;
import com.foxtail.vo.sys.SysUserRoleVo;

public interface SysUserRoleDao extends BaseMybatisDao<SysUserRole,Integer> {	
    
    public void deleteByIds(@Param("ids") List<Integer> ids);
    
    public List<SysUserRole> selectList(SysUserRole sysUserRole);
  
    List<SysUserRoleVo> findListByPage(@Param("vo") SysUserRoleVo vo,@Param("page")Pagination page);
    
    List<SysUserRoleVo> selectByUserId(Integer userId);
    
    /**
    * Description:根据角色id删除关系
    * @Title: deleteByRoleId  
     */
    public void deleteByRoleId(Integer roleId);
    
    /**
     * 根据用户id删除角色
     */
    public void deleteByUserId(Integer userId);
    
    /**
     * 
    * Description:根据角色id查找绑定的总数    
    * @Title: selectCountByRoleId  
     */
    public Integer selectCountByRoleId(Integer roleId);
    
    
    void deleteByAccounts(@Param("accounts")String[] accounts);

}
