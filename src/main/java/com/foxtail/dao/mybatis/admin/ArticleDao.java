package com.foxtail.dao.mybatis.admin;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.ArticleFilter;
import com.foxtail.model.admin.Article;

public interface ArticleDao {

	void save(@Param("model")Article article);
	
	void update(@Param("model")Article article);
	
	Article getById(@Param("id")String id);
	
	List<Article> findForPage2(@Param("ft")ArticleFilter filter);
}

