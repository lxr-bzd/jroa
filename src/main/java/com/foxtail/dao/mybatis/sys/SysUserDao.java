package com.foxtail.dao.mybatis.sys;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysUser;
import com.foxtail.vo.sys.SysUserVo;

public interface SysUserDao extends BaseMybatisDao<SysUser,Integer> {	
    
    public void deleteByIds(@Param("ids")String[] ids);
    
    public List<SysUser> selectList(SysUser sysUser);
  
    List<SysUserVo> findListByPage(@Param("vo") SysUserVo vo,@Param("page")Pagination page);

    /**
    * Description:    
    * @Title: findSingleUser  根据账户，电子邮件，电话号码或者身份证号查找用户
     */
    public SysUser findSingleUser(String account);
    
    /**
     * Description:查询账户是否存在    
     * @Title: selectCountIsExist  

      */
     public Integer selectCountIsExist(Map<String, String> map);
    
     
     public boolean updateByAccount(SysUser sysUser);
     
     
     public void deleteByAccounts(@Param("accounts") String[] accounts);
}
