package com.foxtail.dao.mybatis.customer;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.customer.Product;

public interface ProductDao {

	void save(@Param("model")Product product);
	
	void update(@Param("model")Product product);
	
	Product getById(@Param("id")String id);
	
	List<Product> findForPage(@Param("page")Pagination page);
	
	int customerCount(@Param("ids")String[] id);
	
	Product[] findByCus(@Param("cusid")String cusid);
}

