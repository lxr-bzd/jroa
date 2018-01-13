package com.foxtail.dao.mybatis.customer;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.CustomerFilter;
import com.foxtail.model.customer.Customer;

import net.sf.jsqlparser.statement.delete.Delete;

public interface CustomerDao {

	void save(@Param("model")Customer customer);
	
	void update(@Param("model")Customer customer);
	
	Customer getById(@Param("id")String id);
	
	List<Customer> findForPage(@Param("page")Pagination page,@Param("ft")CustomerFilter filter);
	
	void saveProduct(@Param("id")String id,@Param("pid")String pid);
	
	void deleteAllProduct(@Param("id")String id);
}

