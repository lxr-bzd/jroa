package com.foxtail.dao.mybatis.data;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

public interface StatisticsDao {

	List<Map>  findYearPrj(@Param("starttime")long starttime,@Param("endtime")long endtime);
	List<Map>  findYearEmp(@Param("starttime")long starttime,@Param("endtime")long endtime);
	
	List<Map> statisticsDept(@Param("ctime")long ctime,@Param("cmonth")Integer cmonth);
	
	List<Map> statisticsPrj();
	List<Map>  statisticsOvtime(@Param("starttime")long starttime,@Param("endtime")long endtime);
	
}

