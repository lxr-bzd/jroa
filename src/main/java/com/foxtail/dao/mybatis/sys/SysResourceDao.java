package com.foxtail.dao.mybatis.sys;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysResource;
import com.foxtail.vo.sys.SysResourceVo;

public interface SysResourceDao extends BaseMybatisDao<SysResource,Integer> {	
    
    public void deleteByIds(@Param("ids") List<Integer> ids);
    
    public void deleteByParentId(Integer parent_id);
    
    public List<SysResource> selectList(SysResource sysResource);
  
    List<SysResourceVo> findListByPage(@Param("vo") SysResourceVo vo,@Param("page")Pagination page);
    
    public List<SysResource> selectListByParentId(Integer parentId);
    
    public SysResourceVo selectVoByPrimaryKey(Integer id);
    
    public List<SysResourceVo> findAuthorizationAll(Integer roleId);
   
    public List<SysResource> findAllByUserId(Integer userId);
    
    public Integer selectCountByParentId(Integer parentId);
    
    List<SysResource> queryUriName(@Param("uri") String uri);
    
    
    public Integer selectResourceReference(Integer resourceId);


}
