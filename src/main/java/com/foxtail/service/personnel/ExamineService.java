package com.foxtail.service.personnel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.personnel.ApplyDao;
import com.foxtail.dao.mybatis.personnel.ExamineDao;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;
import com.foxtail.model.personnel.Examine;
import com.lxr.commons.exception.ApplicationException;


@Service
public class ExamineService {

	@Autowired
	ExamineDao examineDao;
	
	@Autowired
	ApplyDao applyDao;
	
	
	public void save(Examine examine,boolean isend) {
		
		Apply apply = applyDao.getById(examine.getApplyid());
		if(apply==null)throw new ApplicationException("审核对象不存在");
		if(apply.getUid().equals(examine.getExaid()))
			throw new ApplicationException("不能审核自己");
		
		int state = 4;//不通过
		
		if(examine.getResult()!=null&&examine.getResult()==1)
			state = 2;//通过
		if(!isend)state = 3;//审核中
		
		examineDao.save(examine);
		examineDao.setApplyState(examine.getApplyid(), state);

	}
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("man_examine", ids);

	}
	
	
	public void update(Examine examine) {
	
		examineDao.update(examine);

	}
	
	public Pagination findForPage(Pagination page,ApplyFilter filter) {
		switch (filter.getSysView()) {
		case "all":filter.setDeptids(null);
			break;
		case "below":filter.setDeptids(null);
		break;
		case "def":filter.setDeptids(null);
		break;
		default:filter.setDeptids(new String[0]);
			break;
		} 
		
		
		return page;

	}
	
	
	public Examine getById(String id) {
		
		return examineDao.getById(id);

	}
	
	public List<Examine> findByApplyid(String id) {
		
		return examineDao.findByApplyid(id);

	}

	
}


