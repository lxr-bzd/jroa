package com.foxtail.dao.mybatis.project;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

public interface PrjRateDao {

	void save(@Param("mo")Map<String, Object> prjRes);
	
	void update(@Param("mo")Map<String, Object> prjRes);
	
	Map<String, Object> getById(@Param("id")String id);
	
	List<Map> findAll();
}

