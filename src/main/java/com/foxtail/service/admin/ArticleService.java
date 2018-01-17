package com.foxtail.service.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.admin.ArticleDao;
import com.foxtail.filter.ArticleFilter;
import com.foxtail.model.admin.Article;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class ArticleService {

	@Autowired
	ArticleDao articleDao;
	
	
	public void save(Article article) {
		
		articleDao.save(article);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("adm_article", ids);

	}
	
	
	public void update(Article article) {
	
		articleDao.update(article);

	}
	
	public Pagination findForPage(Pagination page,ArticleFilter filter) {
		
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)articleDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public Article getById(String id) {
		
		return articleDao.getById(id);

	}

	
}


