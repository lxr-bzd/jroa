package com.foxtail.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.sys.SysAdviceDao;
import com.foxtail.model.sys.SysAdvice;
import com.foxtail.service.sys.SysAdviceService;
import com.foxtail.vo.sys.SysAdviceVo;

@Transactional
@Service("sysAdviceService")
public class SysAdviceServiceImpl implements SysAdviceService{

	private final static Logger log= Logger.getLogger(SysAdviceServiceImpl.class);

	@Autowired
	private SysAdviceDao sysAdviceDao;

	
	public SysAdvice selectByPrimaryKey(Integer id){
	    return sysAdviceDao.selectByPrimaryKey(id);
	}

    public void deleteByPrimaryKey(Integer id){
    	this.sysAdviceDao.deleteByPrimaryKey(id); 
    }

    public void insert(SysAdvice model) {
    	this.sysAdviceDao.insert(model); 
    }
    
    public void insertSelective(SysAdvice model){
    	this.sysAdviceDao.insertSelective(model); 
    }
    
    public void updateByPrimaryKeySelective(SysAdvice model){
    	this.sysAdviceDao.updateByPrimaryKeySelective(model); 
    }

    public void updateByPrimaryKey(SysAdvice model) {
		this.sysAdviceDao.updateByPrimaryKey(model);
    }
    
    public List<SysAdvice> selectList(SysAdvice sysAdvice){
    	return sysAdviceDao.selectList(sysAdvice);
    }
    
    public List<SysAdvice> findAll() {
		return sysAdviceDao.findAll();
    }

    public void deleteAll() {
		this.sysAdviceDao.deleteAll();
    }

    @Override
    public void deleteIds(String ids){
    	String [] idArr=ids.split(",");
    	if (idArr.length>1) {
			List<Integer> idsList=new ArrayList<Integer>();
			for (int i = 0; i < idArr.length; i++) {
				idsList.add(Integer.valueOf(idArr[i]));
			}
			this.sysAdviceDao.deleteByIds(idsList);
		}else {
			this.sysAdviceDao.deleteByPrimaryKey(Integer.valueOf(ids));
		}
    }

    @Override
    public Pagination findListByPage(int rows, int page,SysAdviceVo vo) {
	    Pagination pagination = new Pagination();
	    pagination.setPageNo(page); //当前页码
	    pagination.setPageSize(rows);  //每页显示多少行
	    List<SysAdviceVo>  list = this.sysAdviceDao.findListByPage(vo,pagination);
	    pagination.setList(list);
	    return pagination;
    } 	
}

