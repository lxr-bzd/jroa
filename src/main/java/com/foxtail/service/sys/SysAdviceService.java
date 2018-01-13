package com.foxtail.service.sys;

import java.util.List;

import com.foxtail.common.base.BaseMybatisService;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.sys.SysAdvice;
import com.foxtail.vo.sys.SysAdviceVo;

public interface SysAdviceService extends BaseMybatisService<SysAdvice,Integer> {	
    
    public void deleteIds(String ids);
    
    public List<SysAdvice> selectList(SysAdvice sysAdvice);
    
    public Pagination findListByPage(int rows, int page,SysAdviceVo vo);
   
}

