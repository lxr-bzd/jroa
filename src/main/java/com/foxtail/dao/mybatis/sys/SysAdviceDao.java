package com.foxtail.dao.mybatis.sys;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysAdvice;
import com.foxtail.vo.sys.SysAdviceVo;

public interface SysAdviceDao extends BaseMybatisDao<SysAdvice,Integer> {	
    
    public void deleteByIds(@Param("ids") List<Integer> ids);
    
    public List<SysAdvice> selectList(SysAdvice sysAdvice);
  
    List<SysAdviceVo> findListByPage(@Param("vo") SysAdviceVo vo,@Param("page")Pagination page);

}
