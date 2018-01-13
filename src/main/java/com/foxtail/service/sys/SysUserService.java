package com.foxtail.service.sys;

import java.util.List;

import com.foxtail.common.base.BaseMybatisService;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysUser;
import com.foxtail.model.sys.SysUserRole;
import com.foxtail.vo.sys.SysUserVo;

public interface SysUserService extends BaseMybatisService<SysUser,Integer> {	
    
    public void deleteIds(String ids);
    
    public List<SysUser> selectList(SysUser sysUser);
    
    public Pagination findListByPage(int rows, int page,SysUserVo vo);
    /**
     * Description:    
     * @Title: findSingleUser  根据账户，电子邮件，电话号码或者身份证号查找用户
      */
     public SysUser findSingleUser(String account);
     
     public void setUserRole(SysUserRole[] sysUserRoles);
     
     /**
      * 检查是否重复
     * Description:    
     * @Title: findExist  
      */
     public boolean findIsExist(String name,String type);
     
     
     boolean updateByAccount(SysUser sysUser);
     
     
     void deleteByAccouts(String[] accounts);
   
}

