package com.foxtail.service;

import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.foxtail.common.util.DateUtils;
import com.foxtail.dao.mybatis.IndexDao;
import com.foxtail.model.BaseModel;
import com.lxr.commons.exception.ApplicationException;

@Service
public class IndexService {
	
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	IndexDao indexDao;
	
	
	public Map<String, Object> getStatistics() {
		Long cmonthTime = DateUtils.getSpecficMonthStart(new Date(), 0).getTime();
		Long cmonthEndTime = DateUtils.getSpecficMonthEnd(new Date(), 0).getTime();
		return indexDao.getStatistics(cmonthTime,cmonthEndTime, new Date().getMonth());

	}
	
	
	
	public List<Map<String, Object>> findSale(Long starttime,Long endtime) {
		
		return indexDao.findSale(starttime,endtime);
		
	}
	
	

}
