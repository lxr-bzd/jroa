package com.foxtail.dao.mybatis.sys;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysRoleResource;
import com.foxtail.vo.sys.SysRoleResourceVo;

public interface SysRoleResourceDao extends BaseMybatisDao<SysRoleResource,Integer> {	
    
    public void deleteByIds(@Param("ids") List<Integer> ids);
    
    public List<SysRoleResource> selectList(SysRoleResource sysRoleResource);
  
    List<SysRoleResourceVo> findListByPage(@Param("vo") SysRoleResourceVo vo,@Param("page")Pagination page);
    
    public void deleteByRoleId(Integer roleId);
    
    public void deleteByResources(@Param("ids") List<Integer> ids);

}
