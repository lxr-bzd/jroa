package com.foxtail.dao.mybatis;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface IndexDao {

	Map<String, Object> getStatistics(@Param("cmonthTime")Long cmonthTime,@Param("cmonth")Integer cmonth);
}