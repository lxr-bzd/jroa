package com.foxtail.dao.mybatis.customer;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.customer.Visit;

public interface VisitDao {

	void save(@Param("model")Visit visit);
	
	void update(@Param("model")Visit visit);
	
	Visit getById(@Param("id")String id);
	
	List<Visit> findForPage(@Param("page")Pagination page,@Param("cusid")String cusid);
}

