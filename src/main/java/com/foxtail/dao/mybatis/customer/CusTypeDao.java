package com.foxtail.dao.mybatis.customer;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.customer.CusType;

public interface CusTypeDao {

	void save(@Param("model")CusType cusType);
	
	void update(@Param("model")CusType cusType);
	
	CusType getById(@Param("id")String id);
	
	List<CusType> findForPage(@Param("page")Pagination page);
	List<CusType> findAll();
	
	Integer countCus(@Param("ids")String[] ids);
}

