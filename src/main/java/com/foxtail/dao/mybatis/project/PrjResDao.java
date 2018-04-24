package com.foxtail.dao.mybatis.project;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.project.PrjRes;

public interface PrjResDao {

	void save(@Param("mo")PrjRes prjRes);
	
	void update(@Param("mo")PrjRes prjRes);
	
	PrjRes getById(@Param("id")String id);
	
	List<PrjRes> findForPage2(@Param("kw")String kw);
}

