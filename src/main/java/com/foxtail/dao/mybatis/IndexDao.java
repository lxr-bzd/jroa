package com.foxtail.dao.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface IndexDao {

	Map<String, Object> getStatistics(@Param("cmonthTime")Long cmonthTime,@Param("cmonthEndTime")Long cmonthEndTime,@Param("cmonth")Integer cmonth);
	List<Map<String, Object>> findSale(@Param("starttime")Long starttime,@Param("endtime")Long endtime);


}