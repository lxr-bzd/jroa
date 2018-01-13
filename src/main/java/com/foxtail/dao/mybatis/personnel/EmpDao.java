package com.foxtail.dao.mybatis.personnel;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.EmpFilter;
import com.foxtail.model.personnel.Emp;

public interface EmpDao {

	void save(@Param("model")Emp emp);
	
	void update(@Param("model")Emp emp);
	
	Emp getById(@Param("id")String id);
	
	List<Emp> findForPage(@Param("page")Pagination page,@Param("ft")EmpFilter filter);
	
	String[] getAccountsByIds(@Param("ids")String[] ids);
	
}

