package com.foxtail.dao.mybatis.sys;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysReleaseUser;
import com.foxtail.vo.sys.SysReleaseUserVo;

public interface SysReleaseUserDao extends BaseMybatisDao<SysReleaseUser,Integer> {	
    
    public void deleteByIds(@Param("ids") List<Integer> ids);
    
    public List<SysReleaseUser> selectList(SysReleaseUser sysReleaseUser);
  
    List<SysReleaseUserVo> findListByPage(@Param("vo") SysReleaseUserVo vo,@Param("page")Pagination page);

}
