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
	
	
	
	public List<Map<String, Object>> findSale(Long starttime,Long endtime) {
		
		return indexDao.findSale(starttime,endtime);
		
	}
	
	

}
