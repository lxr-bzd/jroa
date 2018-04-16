package com.foxtail.service;

import java.net.URLDecoder;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import com.foxtail.common.util.DateUtils;
import com.foxtail.dao.mybatis.IndexDao;
import com.foxtail.filter.PrjCollectFilter;


@Service
public class IndexService {
	
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	IndexDao indexDao;
	
	
	public Map<String, Object> getStatistics() {
		Long cmonthTime = DateUtils.getSpecficMonthStart(new Date(), 0).getTime();
		Long cmonthEndTime = DateUtils.getSpecficMonthEnd(new Date(), 0).getTime();
		
		Integer month = Calendar.getInstance().get(Calendar.MONTH)+1;    //获取东八区时间
		return indexDao.getStatistics(cmonthTime,cmonthEndTime,month);

	}
	
	public Map<String, Object> prjMoney(PrjCollectFilter filter) {
		
			
		Date date = new Date();
		if(filter.getStartTime()!=null)date = new Date(filter.getStartTime());
		
		Long cmonthTime = DateUtils.getSpecficMonthStart(date, 0).getTime();
		Long cmonthEndTime = DateUtils.getSpecficMonthEnd(date, 0).getTime();
		filter.setStartTime(cmonthTime);
		filter.setEndTime(cmonthEndTime);
		long yearstart = DateUtils.getSpecficYearStart(date , 0).getTime();
		long yearend= DateUtils.getSpecficYearEnd(date , 0).getTime();
		return indexDao.prjMoney(yearstart,yearend,filter);

	}
	
	
	
	public List<Map<String, Object>> findSale(Long starttime,Long endtime) {
		
		return indexDao.findSale(starttime,endtime);
		
	}
	
	

}
