package com.foxtail.service.sys;

import java.util.List;

import com.foxtail.common.base.BaseMybatisService;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysReleaseUser;
import com.foxtail.vo.sys.SysReleaseUserVo;

public interface SysReleaseUserService extends BaseMybatisService<SysReleaseUser,Integer> {	
    
    public void deleteIds(String ids);
    
    public List<SysReleaseUser> selectList(SysReleaseUser sysReleaseUser);
    
    public Pagination findListByPage(int rows, int page,SysReleaseUserVo vo);
    
    public void saveSysReleaserUser(SysReleaseUserVo sysReleaseUserVo);
    
    public void editSysReleaserUser(SysReleaseUserVo sysReleaseUserVo);
    
    /**
    * Description:根据id设置为无权限发布方    
    * @Title: setLimited  
 
     */
    public void setLimited(String ids);
    
    /**
    * Description:根据id设置为 普通发布方   
    * @Title: setCommon  

     */
    public void setCommon(String ids);
    
    /**
    * Description:根据id设置为高级发布方    
    * @Title: setWhite  
     */
    public void setWhite(String ids);
   
}

