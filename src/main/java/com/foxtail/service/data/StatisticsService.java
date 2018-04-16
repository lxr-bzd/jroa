package com.foxtail.service.data;


import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.common.util.DateUtils;
import com.foxtail.dao.mybatis.data.StatisticsDao;
import com.foxtail.model.data.Sale;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class StatisticsService {

	@Autowired
	StatisticsDao statisticsDao;
	
	
	public List<Map> findYearEmp(long starttime,long endtime) {
		
		return statisticsDao.findYearEmp(starttime, endtime);
		

	}
	
	

	public List<Map> findYearPrj(long starttime,long endtime) {
		
		return statisticsDao.findYearPrj(starttime, endtime);
		

	}
	
	public List<Map> statisticsEmp(Integer cmonth) {
		
		return statisticsDao.statisticsDept(new Date().getTime(), cmonth);

	}

	public List<Map> statisticsPrj(){
		return statisticsDao.statisticsPrj();
	}
	
	
	public List<Map> statisticsOvtime(Long mtime) {
		if(mtime==null)mtime = System.currentTimeMillis();
		Long stime = DateUtils.getSpecficMonthStart(new Date(mtime), 0).getTime();
		Long etime = DateUtils.getSpecficMonthEnd(new Date(mtime), 0).getTime();
		return statisticsDao.statisticsOvtime(stime, etime);

	}
}


