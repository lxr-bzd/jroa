package com.foxtail.dao.mybatis.project;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.PrjCollectFilter;
import com.foxtail.model.project.PrjCollect;

public interface PrjCollectDao {

	void save(@Param("model")PrjCollect prjCollect);
	
	void update(@Param("model")PrjCollect prjCollect);
	
	PrjCollect getById(@Param("id")String id);
	
	List<PrjCollect> findForPage2(@Param("ft")PrjCollectFilter filter);
	
	List<PrjCollect> findBySalesman(@Param("empid")String empid,@Param("startTime")Long startTime,@Param("endTime") Long endTime);
}

