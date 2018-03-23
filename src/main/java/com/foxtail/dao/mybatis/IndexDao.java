package com.foxtail.dao.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.foxtail.filter.PrjCollectFilter;

public interface IndexDao {

	Map<String, Object> getStatistics(@Param("cmonthTime")Long cmonthTime,@Param("cmonthEndTime")Long cmonthEndTime,@Param("cmonth")Integer cmonth);
	List<Map<String, Object>> findSale(@Param("starttime")Long starttime,@Param("endtime")Long endtime);

	
	Map<String, Object> prjMoney(@Param("yearstart")Long yearstart,@Param("yearend")Long yearend,@Param("ft")PrjCollectFilter filter);

}