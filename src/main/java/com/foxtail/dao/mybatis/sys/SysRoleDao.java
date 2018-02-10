package com.foxtail.dao.mybatis.sys;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysRole;
import com.foxtail.vo.sys.SysRoleVo;

public interface SysRoleDao extends BaseMybatisDao<SysRole,Integer> {	
    
    public void deleteByIds(@Param("ids")String[] ids);
    
    public List<SysRole> selectList(SysRole sysRole);
  
    List<SysRoleVo> findListByPage(@Param("vo") SysRoleVo vo,@Param("page")Pagination page);

    List<String> findRoleTypesByUserId(Integer userId); 
}
