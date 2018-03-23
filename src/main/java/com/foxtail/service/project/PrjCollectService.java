package com.foxtail.service.project;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.common.util.DateUtils;
import com.foxtail.dao.mybatis.project.PrjCollectDao;
import com.foxtail.filter.PrjCollectFilter;
import com.foxtail.model.project.PrjCollect;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class PrjCollectService {

	@Autowired
	PrjCollectDao prjCollectDao;
	
	
	public void save(PrjCollect prjCollect) {
		
		prjCollectDao.save(prjCollect);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("prj_collect", ids);

	}
	
	
	public void update(PrjCollect prjCollect) {
	
		prjCollectDao.update(prjCollect);

	}
	
	public Pagination findForPage(Pagination page,PrjCollectFilter filter) {
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)prjCollectDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
	}
	
	public List<PrjCollect> findBySalesman(String empid) {
		Long cmonthTime = DateUtils.getSpecficMonthStart(new Date(), 0).getTime();
		Long cmonthEndTime = DateUtils.getSpecficMonthEnd(new Date(), 0).getTime();
		return prjCollectDao.findBySalesman(empid, cmonthTime, cmonthEndTime);

	}
	
	
	public PrjCollect getById(String id) {
		
		return prjCollectDao.getById(id);

	}

	
}


